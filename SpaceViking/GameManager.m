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
@synthesize managerSoundState;
@synthesize listOfSoundEffectFiles;
@synthesize soundEffectsState;

#pragma mark -
#pragma mark Singleton
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

#pragma mark - Init and Alloc
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
        
        // audio
        hasAudioBeenInitialized = NO;
        soundEngine = nil;
        managerSoundState = kAudioManagerUninitialized;
    }
    
    return self;
}

#pragma mark - Scene and site links

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
    
    // Load audio for new scene based on sceneID
    [self performSelectorInBackground:@selector(loadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:currentScene]];
    
    
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
    
    
    [self performSelectorInBackground:@selector(unloadAudioForSceneWithID:) withObject:[NSNumber numberWithInt:oldScene]];
    
    currentScene = oldScene;
    
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

#pragma mark - Audio

-(void) playBackgroundTrack:(NSString *)trackFileName {
    
    // Wait to make sure soundEngine is initialized
    if ((managerSoundState != kAudioManagerReady) && (managerSoundState != kAudioManagerFailed)) {
        int waitCycles = 0;
        
        while (waitCycles < AUDIO_MAX_WAITTIME) {
            [NSThread sleepForTimeInterval:0.1f];
            
            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed)) {
                break;
            }
            
            waitCycles++;
        }
    }
    
    if (managerSoundState == kAudioManagerReady) {
        if ([soundEngine isBackgroundMusicPlaying]) {
            [soundEngine stopBackgroundMusic];
        }
        
        [soundEngine preloadBackgroundMusic:trackFileName];
        [soundEngine playBackgroundMusic:trackFileName loop:YES];
        
    }
    
}

-(void) stopSoundEffect:(ALuint)soundEffectID
{
    if (managerSoundState == kAudioManagerReady) {
        [soundEngine stopEffect:soundEffectID];
    }
}

-(ALuint) playSoundEffect:(NSString *)soundEffectKey
{
    ALuint soundID = 0;
    if (managerSoundState == kAudioManagerReady) {
        NSNumber *isSFXLoaded = [soundEffectsState objectForKey:soundEffectKey];
        if ([isSFXLoaded boolValue] == SFX_LOADED) {
            soundID = [soundEngine playEffect:[listOfSoundEffectFiles objectForKey:soundEffectKey]];
        } else {
            CCLOG(@"GameMgr: SoundEffect %@ is not loaded.", soundEffectKey);
        }
    } else {
        CCLOG(@"GameMgr: Sound Manager is not ready, cannot play %@", soundEffectKey);
    }
    
    return soundID;
}


-(NSString *) formatSceneTypeToString:(SceneTypes)sceneID {
    NSString *result;
    switch (sceneID) {
        case kNoSceneUninitialized:
            result = @"kNoSceneUninitialized";
            break;
            
        case kMainMenuScene:
            result = @"kMainMenuScene";
            break;
            
        case kOptionsScene:
            result = @"kOptionsScene";
            break;
            
        case kCreditsScene:
            result = @"kCreditsScene";
            break;
            
        case kIntroScene:
            result = @"kIntroScene";
            break;
            
        case kLevelCompleteScene:
            result = @"kLevelCompleteScene";
            break;
            
        case kGameLevel1:
            result = @"kGameLevel1";
            break;
            
        case kGameLevel2:
            result = @"kGameLevel2";
            break;
            
        case kGameLevel3:
            result = @"kGameLevel3";
            break;
            
        case kGameLevel4:
            result = @"kGameLevel4";
            break;
            
        case kGameLevel5:
            result = @"kGameLevel5";
            break;
            
        case kCutSceneForLevel2:
            result = @"kCutSceneForLevel2";
            break;
            
        default:
            [NSException raise:NSGenericException format:@"Unexpected SceneType"];
    }
    
    return  result;
}

-(NSDictionary *) getSoundEffectsListForSceneWithID:(SceneTypes) sceneID {
    NSString *fullFileName = @"SoundEffects.plist";
    NSString *plistPath;
    
    // get the path to the plist
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"SoundEffects" ofType:@"plist"];
    }
    
    // read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // if the plistDictionary is null, the file was not found
    if (!plistDictionary) {
        CCLOG(@"Error reading SoundEffects.plist");
        return nil; // No Plist Dictionary or file found
    }
    
    
    // if the list of sound effects files is empty, load it
    if (!listOfSoundEffectFiles || ([listOfSoundEffectFiles count] < 1)) {
        NSLog(@"Before");
        [self setListOfSoundEffectFiles:[[NSMutableDictionary alloc] init]];
        NSLog(@"After");
        
        for (NSString* sceneSoundDictionary in plistDictionary) {
            [listOfSoundEffectFiles addEntriesFromDictionary:[plistDictionary objectForKey:sceneSoundDictionary]];
        }
        
        CCLOG(@"Number of SFX filenames: %d", [listOfSoundEffectFiles count]);
    }
    
    // load the list of sound effects state, mark them as unloaded
    if ((soundEffectsState == nil) || ([soundEffectsState count] < 1)){
        [self setSoundEffectsState:[[NSMutableDictionary alloc] init]];
        
        for (NSString *soundEffectKey in listOfSoundEffectFiles) {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:soundEffectKey];
        }
    }
    
    // return just the mini SFX list for this scene
    NSString *sceneIDName = [self formatSceneTypeToString:sceneID];
    NSDictionary *soundEffectsList = [plistDictionary objectForKey:sceneIDName];
    
    return soundEffectsList;
    
}

-(void) initAudioAsync
{
    // Initializes the audio engine asynchronously
    managerSoundState = kAudioManagerInitializing;
    // Inidicate that we are trying to start up the Audio Manager
    [CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];
    
    // Init audio manager assynchrounously as it can take a few seconds
    // The FXPlusMusicIfNoOtherAudio mode will check if the user is
    // playing music and disable backgound music playback if
    // that is the case
    [CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
    
    // Wait for the audio manager to initialize
    while ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
        [NSThread sleepForTimeInterval:0.1];
    }
    
    // At this point the CocosDneshion should be initialized
    // Grab the CDAudioManager and check the state
    CDAudioManager *audioManager = [CDAudioManager sharedManager];
    if (audioManager.soundEngine == nil || audioManager.soundEngine.functioning == NO) {
        CCLOG(@"CocosDenschion failed to init, no audio will play.");
        managerSoundState = kAudioManagerFailed;
    } else {
        [audioManager setResignBehavior:kAMRBStopPlay autoHandle:YES];
        soundEngine = [SimpleAudioEngine sharedEngine];
        managerSoundState = kAudioManagerReady;
        CCLOG(@"CocosDenschion is Ready");
    }
}

-(void) setupAudioEngine
{
    if (hasAudioBeenInitialized) {
        return;
    } else {
        hasAudioBeenInitialized = YES;
        NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
        NSInvocationOperation *asyncSetupOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(initAudioAsync) object:nil];
        
        [queue addOperation:asyncSetupOperation];
        [asyncSetupOperation autorelease];
    }
}

-(void) loadAudioForSceneWithID:(NSNumber *) sceneIDNumber {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    SceneTypes sceneID = (SceneTypes) [sceneIDNumber intValue];
    
    if (managerSoundState == kAudioManagerInitializing) {
        int waitCycles = 0;
        while (waitCycles < AUDIO_MAX_WAITTIME) {
            [NSThread sleepForTimeInterval:0.1f];
            if ((managerSoundState == kAudioManagerReady) || (managerSoundState == kAudioManagerFailed)) {
                break;
            }
            
            waitCycles = waitCycles + 1;
        }
    }
    
    if (managerSoundState == kAudioManagerFailed) {
        return; // Nothing to load, CocosDenshion not ready
    }
    
    NSDictionary *soundEffectsToLoad = [self getSoundEffectsListForSceneWithID:sceneID];
    
    if (soundEffectsToLoad == nil) {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    
    // Get all of the entries and PreLoad
    for (NSString *keyString in soundEffectsToLoad) {
        CCLOG(@"\nLoading Audio Key:%@ File:%@", keyString, [soundEffectsToLoad objectForKey:keyString]);
        
        [soundEngine preloadEffect:[soundEffectsToLoad objectForKey:keyString]];
        
        [soundEffectsState setObject:[NSNumber numberWithBool:SFX_LOADED] forKey:keyString];
    }
    
    [pool release];
}

-(void) unloadAudioForSceneWithID:(NSNumber*)sceneIDNumber {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    SceneTypes sceneID = (SceneTypes)[sceneIDNumber intValue];
    
    if (sceneID == kNoSceneUninitialized) {
        return; // Nothing to unload
    }
    
    NSDictionary *soundEffectsToUnload = [self getSoundEffectsListForSceneWithID:sceneID];
    
    if (soundEffectsToUnload == nil) {
        CCLOG(@"Error reading SoundEffects.plist");
        return;
    }
    
    if (managerSoundState == kAudioManagerReady) {
        // Get all of the entries and unload
        for (NSString *keyString in soundEffectsToUnload) {
            [soundEffectsState setObject:[NSNumber numberWithBool:SFX_NOTLOADED] forKey:keyString];
            [soundEngine unloadEffect:keyString];
            CCLOG(@"\nUnloading Audio Key: %@ File: %@", keyString, [soundEffectsToUnload objectForKey:keyString]);
        }
    }
    
    [pool release];
}


@end









