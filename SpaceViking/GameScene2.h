//
//  GameScene2.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 8/1/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "CCScene.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "GameControlLayer.h"
#import "GameplayScrollingLayer.h"
#import "StaticBackgroundLayer.h"

@interface GameScene2 : CCScene {
    GameControlLayer *controlLayer;
}
@end
