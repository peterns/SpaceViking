//
//  GameManager.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/24/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameManager : NSObject {
    
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    BOOL hasPlayerDied;
    SceneTypes currentScene;
    
}

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundEffectsON;
@property (readwrite) BOOL hasPlayerDied;
//@property (readwrite) SceneTypes currentScene;

+(GameManager*) sharedGameManager;

-(void) runSceneWithID:(SceneTypes)sceneID;
-(void) openSiteWithLinkType:(LinkTypes) linkTypeToOpen;

@end
