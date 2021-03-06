//
//  GameObject.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/3/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "CCSprite.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "GameManager.h"


@interface GameObject : CCSprite {
    BOOL isActive;
    BOOL reactsToScreenBoundaries;
    CGSize screenSize;
    GameObjectType gameObjectType;
}

@property (readwrite) BOOL isActive;
@property (readwrite) BOOL reactsToScreenBoundaries;
@property (readwrite) CGSize screenSize;
@property (readwrite) GameObjectType gameObjectType;

-(void) changeState:(CharacterStates) newState;

-(void) updateStateWithDeltaTime:(ccTime) deltaTime
            andListOfGameObjects:(CCArray *) listOfGameObjects;

-(CGRect) adjustBoundingBox;

-(CCAnimation *) loadPlistForAnimationWithName:(NSString *) animationName 
                                  andClassName:(NSString *) className;


@end
