//
//  GameplayScrollingLayer.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 8/1/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Viking.h"
#import "GameControlLayer.h"


@interface GameplayScrollingLayer : CCLayer {
    CCSpriteBatchNode *sceneSpriteBatchNode;
    
    CCTMXTiledMap *tileMapNode;
    CCParallaxNode *parallaxNode;
}

-(void) connectControllsWithJoystick:(SneakyJoystick*)leftJoystick
                       andJumpButton:(SneakyButton*)jumpButton
                     andAttackButton:(SneakyButton*)attackButton;

@end
