//
//  Constants.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/3/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#ifndef SpaceViking_Constants_h
#define SpaceViking_Constants_h


#define kVikingSpriteZValue 100
#define kVikingSpriteTagValue 0
#define kVikingIdleTimer 3.0f
#define kVikingFistDamage 10
#define kVikingMalletDamage 40
#define kRadarDishTagValue 10

#define kMalletTagValie 11

typedef enum {
    kNoSceneUninitialized = 0,
    kMainManuScene = 1,
    kOptionsScene = 2,
    kCreditsScene = 3,
    kIntroScene = 4,
    kLevelCompleteScene = 5,
    kGameLevel1 = 101,
    kGameLevel2 = 102,
    kGameLevel3 = 103,
    kGameLevel4 = 104,
    kGameLevel5 = 105,
    kCutSceneForLevel2 = 201
} SceneTypes;




#endif
