//
//  GameScene2.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 8/1/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameScene2.h"

@implementation GameScene2

-(id) init {
    self = [super init];
    if (self != nil) {
        // Background Layer
        StaticBackgroundLayer *backgroundLayer = [StaticBackgroundLayer node];
        [self addChild:backgroundLayer z: 0];
        
        // Initialize the Control Layer
        controlLayer = [GameControlLayer node];
        [self addChild:controlLayer z: 2 tag: 2];
        
        // Gameplay Layer
        GameplayScrollingLayer * scrollingLayer = [GameplayScrollingLayer node];
        
        [scrollingLayer connectControllsWithJoystick:[controlLayer leftJoystick]
                                       andJumpButton:[controlLayer jumpButton]
                                     andAttackButton:[controlLayer attackButton]];
        
        [self addChild:scrollingLayer z:1 tag:1];
    }
    return self;
}
@end
