//
//  CreditsScene.m
//  SpaceViking
//
//  Created by Rod on 9/18/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "CreditsScene.h"


@implementation CreditsScene
-(id)init {
	self = [super init];
	if (self != nil) {
		// Background Layer
		myCreditsLayer = [CreditsLayer node];
		[self addChild:myCreditsLayer];
	}
	return self;
}

@end
