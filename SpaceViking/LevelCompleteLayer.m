//
//  LevelCompleteLayer.m
//  SpaceViking
//
//  Created by Rod on 10/7/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "LevelCompleteLayer.h"


@implementation LevelCompleteLayer


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, returning to the Main Menu");
	[[GameManager sharedGameManager] setHasPlayerDied:NO]; // Reset this for the next level
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}



-(id)init {
	self = [super init];
	if (self != nil) {
		// Accept touch input
		self.isTouchEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
	
		// If Viking is dead, reset him and show the tombstone,
		// Any touch gets you back to the main menu
		BOOL didPlayerDie = [[GameManager sharedGameManager] hasPlayerDied];
		CCSprite *background = nil;
		if (didPlayerDie) {
			background = [CCSprite spriteWithFile:@"LevelCompleteDead.png"];
		} else {
			background = [CCSprite spriteWithFile:@"LevelCompleteAlive.png"];
		}
		
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		
		
		// Add the text for level complete.
		CCLabelBMFont *levelLabelText = [CCLabelBMFont labelWithString:@"Level Complete" fntFile:@"VikingSpeechFont64.fnt"];
		[levelLabelText setPosition:ccp(screenSize.width/2, screenSize.height * 0.9f)];
		[self addChild:levelLabelText];
		
		
		
		
		
	}
	return self;
}
@end
