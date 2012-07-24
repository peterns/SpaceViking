//
//  BackgroundLayer.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 6/29/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer


-(id) init
{
    self = [super init];
    
    if(self != nil) {
        CCSprite *backgroundImage;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // Indicates game is running on iPad
            backgroundImage = [CCSprite spriteWithFile:@"background.png"];
        } else {
            backgroundImage = [CCSprite spriteWithFile:@"backgroundiPhone.png"];
        }
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:CGPointMake(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:backgroundImage z:0 tag:0];
        
        //id wavesAction = [CCWaves actionWithWaves:5 amplitude:20 horizontal:NO vertical:YES grid:ccg(15,10) duration:20];
        
        //[backgroundImage runAction:[CCRepeatForever actionWithAction:wavesAction]];
    }
    
    return self;
}

@end
