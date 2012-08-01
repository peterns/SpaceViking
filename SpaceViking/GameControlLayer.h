//
//  GameControlLayer.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 8/1/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"


@interface GameControlLayer : CCLayer {
    SneakyJoystick *leftJoystick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
    
}

@property (nonatomic, readonly) SneakyJoystick *leftJoystick;
@property (nonatomic, readonly) SneakyButton *jumpButton;
@property (nonatomic, readonly) SneakyButton *attackButton;



@end
