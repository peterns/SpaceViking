//
//  SpaceCargoShip.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/10/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameObject.h"

@interface SpaceCargoShip : GameObject
{
    BOOL hasDroppedMallet;
    id <GameplayLayerDelegate> delegate;
    int soundNumberToPlay;
}

@property (nonatomic, assign) id <GameplayLayerDelegate> delegate;

@end
