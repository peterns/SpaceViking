//
//  PhaserBullet.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/18/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameCharacter.h"

@interface PhaserBullet : GameCharacter
{
    CCAnimation *firingAnim;
    CCAnimation *travelingAnim;
    
    PhaserDirection myDirection;
}

@property PhaserDirection myDirection;
@property (nonatomic, retain) CCAnimation *firingAnim;
@property (nonatomic, retain) CCAnimation *travelingAnim;

@end
