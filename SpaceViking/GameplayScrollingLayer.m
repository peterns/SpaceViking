//
//  GameplayScrollingLayer.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 8/1/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameplayScrollingLayer.h"

@implementation GameplayScrollingLayer


-(void) connectControllsWithJoystick:(SneakyJoystick *)leftJoystick
                       andJumpButton:(SneakyButton *)jumpButton
                     andAttackButton:(SneakyButton *)attackButton {
    
    Viking *viking = (Viking*) [sceneSpriteBatchNode getChildByTag:kVikingSpriteTagValue];
    [viking setJoystick:leftJoystick];
    [viking setJumpButton:jumpButton];
    [viking setAttackButton:attackButton];
}

// Scrolling with just a large width * 2 background
-(void) addScrollingBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGSize levelSize = [[GameManager sharedGameManager] getDimensionsOfCurrentScene];
    
    
    CCSprite *scrollingBackground;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Indicates game is running on iPad
        scrollingBackground = [CCSprite spriteWithFile:@"FlatScrollingLayer.png"];
    } else {
        scrollingBackground = [CCSprite spriteWithFile:@"FlatScrollingLayeriPhone.png"];
    }
    
    [scrollingBackground setPosition:ccp(levelSize.width / 2.0f, screenSize.height / 2.0f)];
    
    [self addChild:scrollingBackground];
}

-(id) init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlas.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlas.png"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"scene1atlasiPhone.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"scene1atlasiPhone.png"];
        }
        
        [self addChild:sceneSpriteBatchNode z:20];
        
        Viking *viking = [[Viking alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sv_anim_1.png"]];
        [viking setJoystick:nil];
        [viking setJumpButton:nil];
        [viking setAttackButton:nil];
        [viking setPosition:ccp(screenSize.width * 0.35f, screenSize.height * 0.14f)];
        [viking setCharacterHealth:100];
        [sceneSpriteBatchNode addChild:viking z:1000 tag:kVikingSpriteTagValue];
        
        [self addScrollingBackground];
        
        [self scheduleUpdate];
    }
    
    return self;
}

@end






