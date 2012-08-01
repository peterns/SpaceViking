//
//  StaticBackgroundLayer.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 8/1/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "StaticBackgroundLayer.h"

@implementation StaticBackgroundLayer


-(id) init {
    
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        CCSprite *backgoundImage;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // Indicates game is running on iPad
            backgoundImage = [CCSprite spriteWithFile:@"chap9_scrolling1.png"];
        } else {
            backgoundImage = [CCSprite spriteWithFile:@"chap9_scrolling1iPhone.png"];
        }
        
        [backgoundImage setPosition:ccp(screenSize.width/2.0f, screenSize.height/2.0f)];
        
        [self addChild:backgoundImage];
    }
    return self;
}

@end
