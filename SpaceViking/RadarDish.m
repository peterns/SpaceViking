//
//  RadarDish.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/4/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "RadarDish.h"

@implementation RadarDish

@synthesize tiltingAnim;
@synthesize transmittingAnim;
@synthesize takingAHitAnim;
@synthesize blowingUpAnim;

-(void) dealloc
{
    [tiltingAnim release];
    [transmittingAnim release];
    [takingAHitAnim release];
    [blowingUpAnim release];
    [super dealloc];
}


-(void) changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateSpawning:
            CCLOG(@"RadarDish->Starting the Spawning Animation");
            action = [CCAnimate actionWithAnimation:tiltingAnim restoreOriginalFrame:NO];
            break;
            
        case kStateIdle:
            CCLOG(@"RadarDish->Changing state to idle");
            action = [CCAnimate actionWithAnimation:transmittingAnim restoreOriginalFrame:NO];
            break;
            
        case kStateTakingDamage:
            CCLOG(@"RadarDish->Changing state to TakingDamage");
            characterHealth = characterHealth - [vikingCharacter getWeaponDamage];
            
            if(characterHealth < 0.0f)
            {
                [self changeState:kStateDead];
            } else {
                PLAYSOUNDEFFECT(VIKING_HAMMERHIT1);
                action = [CCAnimate actionWithAnimation:takingAHitAnim restoreOriginalFrame:NO];
            }
            break;
            
        case kStateDead:
            CCLOG(@"RadarDish->Changing state to Dead");
            PLAYSOUNDEFFECT(VIKING_HAMMERHIT2);
            PLAYSOUNDEFFECT(ENEMYROBOT_DYING);
            action = [CCAnimate actionWithAnimation:blowingUpAnim restoreOriginalFrame:NO];
            break;
            
        default:
            CCLOG(@"Unhandled state %d in RadarDish", newState);
            break;
    }
    
    if(action != nil)
    {
        [self runAction:action];
    }
}

-(void) updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    if (characterState == kStateDead) {
        return;
    }
    
    vikingCharacter = (GameCharacter*)[[self parent] getChildByTag:kVikingSpriteTagValue];
    
    CGRect vikingBoundingBox = [vikingCharacter adjustBoundingBox];
    
    CharacterStates vikingState = [vikingCharacter characterState];
    
    // Calculate if the Viking is attacking and nearby
    if((vikingState == kStateAttacking) && (CGRectIntersectsRect([self adjustBoundingBox], vikingBoundingBox))) {
        if (characterState != kStateTakingDamage) {
            // If RadarDish in NOT already taking Damage
            [self changeState:kStateTakingDamage];
            return;
        }
    }
    
    if(([self numberOfRunningActions] == 0) && (characterState != kStateDead)) {
        CCLOG(@"Going to Idle");
        [self changeState:kStateIdle];
        return;
    }
}

-(void) initAnimations
{
    [self setTiltingAnim:[self loadPlistForAnimationWithName:@"tiltingAnim" andClassName:NSStringFromClass([self class])]];
    [self setTransmittingAnim:[self loadPlistForAnimationWithName:@"transmittingAnim" andClassName:NSStringFromClass([self class])]];
    [self setTakingAHitAnim:[self loadPlistForAnimationWithName:@"takingAHitAnim" andClassName:NSStringFromClass([self class])]];
    [self setBlowingUpAnim:[self loadPlistForAnimationWithName:@"blowingUpAnim" andClassName:NSStringFromClass([self class])]];
    
}

-(id) init
{
    if ((self = [super init])) {
        CCLOG(@"### RadarDish initialized");
        [self initAnimations];
        characterHealth = 100.0f;
        gameObjectType = kEnemyTypeRadarDish;
        [self changeState:kStateSpawning];
    }
    return self;
}


@end
