//
//  Mallet.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/9/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "GameObject.h"
#import <Foundation/Foundation.h>

@interface Mallet : GameObject
{
    CCAnimation *malletAnim;
}

@property (nonatomic, retain) CCAnimation *malletAnim;
@end
