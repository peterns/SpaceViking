//
//  IntroLayer.m
//  SpaceViking
//
#import "IntroLayer.h"

@implementation IntroLayer
-(void)startGamePlay {
	CCLOG(@"Intro complete, asking Game Manager to start the Game play");
	[[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, skipping intro");
	[self startGamePlay];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		// Accept touch input
		self.isTouchEnabled = YES;
		
		// Create the intro image
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCSprite *introImage = [CCSprite spriteWithFile:@"intro1.png"];
		[introImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:introImage];
		
		// Create the intro animation, and load it from intro1 to intro7.png
		CCAnimation *introAnimation = [CCAnimation animation];
        [introAnimation setDelay:2.5f];
		for (int frameNumber=0; frameNumber < 8; frameNumber++) {
			CCLOG(@"Adding image intro%d.png to the introAnimation.",frameNumber);
			[introAnimation addFrameWithFilename:
			 [NSString stringWithFormat:@"intro%d.png",frameNumber]];
		}
		
		// Create the actions to play the intro
		id animationAction = [CCAnimate actionWithAnimation:introAnimation restoreOriginalFrame:NO];
		id startGameAction = [CCCallFunc actionWithTarget:self selector:@selector(startGamePlay)];
		id introSequence = [CCSequence actions:animationAction,startGameAction,nil];
		
		[introImage runAction:introSequence];
	}
	return self;
}
@end
