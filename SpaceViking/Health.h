//
//  Health.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/10/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface Health : GameObject
{
    CCAnimation *healthAnim;
}

@property (nonatomic, retain) CCAnimation *healthAnim;

@end
