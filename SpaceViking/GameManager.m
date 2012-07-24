//
//  GameManager.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/24/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameManager.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#import "OptionsScene.h"
#import "CreditsScene.h"
#import "IntroScene.h"
#import "LevelCompleteScene.h"



@implementation GameManager

static GameManager* _sharedGameManager = nil;

@synthesize isMusicON;
@synthesize isSoundEffectsON;
@synthesize hasPlayerDied;

+(GameManager*) sharedGameManager {
    @synchronized([GameManager class])
    {
        if (!_sharedGameManager) {
            [[self alloc] init];
        }
        return _sharedGameManager;
    }
    
    return nil;
}

+(id) alloc
{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil, @"Attempted to allocate a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil;
}

-(id) init
{
    self = [super init];
    if (self != nil) {
        // Game Manager initialized
        CCLOG(@"Game Manager Singleton, init");
        isMusicON = YES;
        isSoundEffectsON = YES;
        hasPlayerDied = NO;
        currentScene = kNoSceneUninitialized;
    }
    
    return self;
}


-(void) runSceneWithID:(SceneTypes)sceneID {

    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    
    switch (sceneID) {
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
            
        case kOptionsScene:
            sceneToRun = [OptionsScene node];
            break;
            
        case kCreditsScene:
            sceneToRun = [CreditsScene node];
            break;
            
        case kIntroScene:
            sceneToRun = [IntroScene node];
            break;
            
        case kLevelCompleteScene:
            sceneToRun = [LevelCompleteScene node];
            break;
            
        case kGameLevel1:
            sceneToRun = [GameScene node];
            break;
            
        case kGameLevel2:
            // Placeholder for Level 2
            break;
            
        case kGameLevel3:
            // Placeholder for Level 3
            break;
            
        case kGameLevel4:
            // Placeholder for Level 4
            break;
            
        case kGameLevel5:
            // Placeholder for Level 5
            break;
            
        case kCutSceneForLevel2:
            // Placeholder for Platform Level
            break;
            
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if(sceneToRun == nil) {
        // Revert back, since no new scene was found
        currentScene = oldScene;
        return;
    }
    
    // Menu Scenes have a value of < 100
    
    if (sceneID < 100) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels;
            
            if (screenSize.width == 960.0f) {
                // iPhone 4 Retina
                [sceneToRun setScaleX:0.9375f];
                [sceneToRun setScaleY:0.8333f];
                CCLOG(@"GM:Scaling for iPhone 4 (retina)");
            } else {
                [sceneToRun setScaleX:0.4688f];
                [sceneToRun setScaleY:0.4166f];
                CCLOG(@"GM:Scaling for iPhone 3G(non-retina)");
            }
        }
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    } else {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
    
}

-(void) openSiteWithLinkType:(LinkTypes)linkTypeToOpen
{
    NSURL *urlToOpen = nil;
    if (linkTypeToOpen == kLinkTypeBookSite) {
        CCLOG(@"Opening Book Site");
        urlToOpen = [NSURL URLWithString:@"http://www.informit.com/titles/9780321735621"];
    } else if (linkTypeToOpen == kLinkTypeDeveloperSiteRod) {
        CCLOG(@"Opening Developer Site for Rod");
        urlToOpen = [NSURL URLWithString:@"http://www.prop.gr"];
    } else if (linkTypeToOpen == kLinkTypeDeveloperSiteRay) {
        CCLOG(@"Opening Developer Site for Ray");
        urlToOpen = [NSURL URLWithString:@"http://www.raywenderlich.com/"];
    } else if (linkTypeToOpen == kLinkTypeArtistSite) {
        CCLOG(@"Opening Artist Site");
        urlToOpen = [NSURL URLWithString:@"http://EricStevensArt.com"];
    } else if (linkTypeToOpen == kLinkTypeMusicianSite) {
        CCLOG(@"Opening Musician Site");
        urlToOpen = [NSURL URLWithString:@"http://www.mikeweisermusic.com/"];
    } else {
        CCLOG(@"Defaulting to Cocos2DBook.com Blog Site");
        urlToOpen = [NSURL URLWithString:@"http://www.cocos2dbook.com/"];
    }

    if (![[UIApplication sharedApplication] openURL:urlToOpen]) {
        CCLOG(@"%@%@", @"Failed to open url:", [urlToOpen description]);
        [self runSceneWithID:kMainMenuScene];
    }


}


@end









