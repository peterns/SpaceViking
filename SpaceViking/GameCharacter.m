    //
//  GameCharacter.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/4/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter

@synthesize characterHealth;
@synthesize characterState;

-(void) dealloc
{
    [super dealloc];
}

-(int) getWeaponDamage
{
    // Default to zero damage
    CCLOG(@"getWeaponDamage should be overridden");
    return 0;
}

-(void) checkAndClampSpritePosition
{
    CGPoint currentSpritePosition = [self position];
    
    CGSize levelSize = [[GameManager sharedGameManager] getDimensionsOfCurrentScene];
    
    float xOffset;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // Clamp for the iPad
        xOffset = 30.0f;
//        if(currentSpritePosition.x < 30.0f) {
//            [self setPosition:ccp(30.0f, currentSpritePosition.y)];
//        }
//        else if(currentSpritePosition.x > 1000.0f) {
//            [self setPosition:ccp(1000.0f, currentSpritePosition.y)];
//        }
    } else {
        // Clamp for iPhone, iPhone4, or iPod touch
        xOffset = 24.0f;
//        if (currentSpritePosition.x < 24.0f) {
//            [self setPosition:ccp(24.0f, currentSpritePosition.y)];
//        } else if (currentSpritePosition.x > 456.0f) {
//            [self setPosition:ccp(456.0f, currentSpritePosition.y)];
//        }
    }
    
    if (currentSpritePosition.x < xOffset) {
        [self setPosition:ccp(xOffset, currentSpritePosition.y)];
    } else if (currentSpritePosition.x > (levelSize.width - xOffset)) {
        [self setPosition:ccp((levelSize.width - xOffset), currentSpritePosition.y)];
    }
}


@end
