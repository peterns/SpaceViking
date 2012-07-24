//
//  OptionsScene.m
//  SpaceViking
//
//  Created by Rod on 9/18/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "OptionsScene.h"

@implementation OptionsScene
-(id)init {
	self = [super init];
	if (self != nil) {
		OptionsLayer *myLayer = [OptionsLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
