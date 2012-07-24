//
//  MainMenuScene.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/24/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

-(id) init {
    self = [super init];
    if (self != nil) {
        mainMenuLayer = [MainMenuLayer node];
        [self addChild:mainMenuLayer];
    }
    
    return self;
}

@end
