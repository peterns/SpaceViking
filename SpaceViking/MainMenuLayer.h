//
//  MainMenuLayer.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/24/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayer.h"
#import "Constants.h"
#import "GameManager.h"


@interface MainMenuLayer : CCLayer {
    CCMenu *mainMenu;
    CCMenu *sceneSelecteMenu;
}

@end
