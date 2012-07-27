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

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20
#define kMalletTagValie 11

typedef enum {
    kNoSceneUninitialized = 0,
    kMainMenuScene = 1,
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


typedef enum {
    kLinkTypeBookSite,
    kLinkTypeDeveloperSiteRod,
    kLinkTypeDeveloperSiteRay,
    kLinkTypeArtistSite,
    kLinkTypeMusicianSite
} LinkTypes;

// Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG 0

#define AUDIO_MAX_WAITTIME 150

typedef enum {
    kAudioManagerUninitialized = 0,
    kAudioManagerFailed = 1,
    kAudioManagerInitializing = 2,
    kAudioManagerInitialized = 100,
    kAudioManagerLoading = 200,
    kAudioManagerReady = 300
} GameManagerSoundState;


// Audio Constants
#define SFX_NOTLOADED NO
#define SFX_LOADED YES

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__ ]]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:@#__VA_ARGS__ ]]


// Background Music
// Menu Scenes
#define BACKGROUND_TRACK_MAIN_MENU @"VikingPreludeV1.mp3"

// GameLevel1 (Ole Awakens)
#define BACKGROUND_TRACK_OLE_AWAKES @"SpaceDesertV2.mp3"

// Physics Puzzle Level
#define BACKGROUND_TRACK_PUZZLE @"VikingPreludeV1.mp3"

// Physics MineCart Level
#define BACKGROUND_TRACK_MINECART @"DrillBitV2.mp3"

// Physics Escape Level
#define BACKGROUND_TRACK_ESCAPE @"EscapeTheFutureV3.mp3"

#endif










