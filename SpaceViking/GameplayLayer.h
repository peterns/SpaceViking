//
//  GampleayLayer.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 6/30/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "RadarDish.h"
#import "Viking.h"
#import "Mallet.h"
#import "Health.h"
#import "SpaceCargoShip.h"
#import "EnemyRobot.h"
#import "PhaserBullet.h"
#import "GameManager.h"

@interface GameplayLayer : CCLayer <GameplayLayerDelegate>
{
    CCSprite *vikingSprite;
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
    CCSpriteBatchNode *sceneSpriteBatchNode;
}
@end
