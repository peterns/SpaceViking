//
//  GameCharacter.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/4/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface GameCharacter : GameObject {
    int characterHealth;
    CharacterStates characterState;
}


-(void) checkAndClampSpritePosition;
-(int) getWeaponDamage;

@property (readwrite) int characterHealth;
@property (readwrite) CharacterStates characterState;

@end
