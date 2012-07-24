//
//  Health.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/10/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "Health.h"

@implementation Health

@synthesize healthAnim;

-(void) dealloc
{
    [healthAnim release];
    
    [super dealloc];
}

-(void) changeState:(CharacterStates)newState
{
    if (newState == kStateSpawning) {
        id action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:healthAnim restoreOriginalFrame:NO]];
        [self runAction: action];
    }
    else {
        [self setVisible:NO]; // Picked up
        [self removeFromParentAndCleanup:YES];
        
    }
}

-(void) updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray *)listOfGameObjects
{
    float groundHeight = screenSize.height * 0.065f;
    
    if ([self position].y > groundHeight) {
        [self setPosition:ccp([self position].x, [self position].y - 5.0f)];
        
    }
}

-(void) initAnimations
{
    [self setHealthAnim:[self loadPlistForAnimationWithName:@"healthAnim" andClassName:NSStringFromClass([self class])]];
}

-(id) init
{
    if ( (self = [super init]) ) {
        screenSize = [CCDirector sharedDirector].winSize;
        [self initAnimations];
        [self changeState:kStateSpawning];
        gameObjectType = kPowerUpTypeHealth;
    }
    
    return self;
}

@end
