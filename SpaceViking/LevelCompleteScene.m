//
//  LevelCompleteScene.m
//  SpaceViking
//
//  Created by Rod on 10/7/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "LevelCompleteScene.h"
#import "LevelCompleteLayer.h"

@implementation LevelCompleteScene
-(id)init {
	self = [super init];
	if (self != nil) {
		LevelCompleteLayer *myLayer = [LevelCompleteLayer node];
		[self addChild:myLayer];
	}
	return self;
}
@end
