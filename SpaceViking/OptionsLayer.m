//
//  OptionsLayer.m
//  SpaceViking
//

#import "OptionsLayer.h"


@implementation OptionsLayer
-(void)returnToMainMenu {
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}
-(void)showCredits {
	[[GameManager sharedGameManager] runSceneWithID:kCreditsScene];
}

-(void)musicTogglePressed {
	if ([[GameManager sharedGameManager] isMusicON]) {
		CCLOG(@"OptionsLayer-> Turning Game Music OFF");
		[[GameManager sharedGameManager] setIsMusicON:NO];
	} else {
		CCLOG(@"OptionsLayer-> Turning Game Music ON");
		[[GameManager sharedGameManager] setIsMusicON:YES];
	}
}

-(void)SFXTogglePressed {
	if ([[GameManager sharedGameManager] isSoundEffectsON]) {
		CCLOG(@"OptionsLayer-> Turning Sound Effects OFF");
		[[GameManager sharedGameManager] setIsSoundEffectsON:NO];
	} else {
		CCLOG(@"OptionsLayer-> Turning Sound Effects ON");
		[[GameManager sharedGameManager] setIsSoundEffectsON:YES];
	}
}

-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
		
		CCSprite *background = [CCSprite spriteWithFile:@"LevelCompleteAlive.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		
		
		CCLabelBMFont *musicOnLabelText = [CCLabelBMFont labelWithString:@"Music ON" fntFile:@"VikingSpeechFont64.fnt"];
		CCLabelBMFont *musicOffLabelText = [CCLabelBMFont labelWithString:@"Music OFF" fntFile:@"VikingSpeechFont64.fnt"];
		CCLabelBMFont *SFXOnLabelText = [CCLabelBMFont labelWithString:@"Sound Effects ON" fntFile:@"VikingSpeechFont64.fnt"];
		CCLabelBMFont *SFXOffLabelText = [CCLabelBMFont labelWithString:@"Sound Effects OFF" fntFile:@"VikingSpeechFont64.fnt"];
		
		CCMenuItemLabel *musicOnLabel = [CCMenuItemLabel itemWithLabel:musicOnLabelText target:self selector:nil];
		CCMenuItemLabel *musicOffLabel = [CCMenuItemLabel itemWithLabel:musicOffLabelText target:self selector:nil];
		CCMenuItemLabel *SFXOnLabel = [CCMenuItemLabel itemWithLabel:SFXOnLabelText target:self selector:nil];
		CCMenuItemLabel *SFXOffLabel = [CCMenuItemLabel itemWithLabel:SFXOffLabelText target:self selector:nil];

										 
		CCMenuItemToggle *musicToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(musicTogglePressed) 
																   items:musicOnLabel,musicOffLabel,nil];
		
		CCMenuItemToggle *SFXToggle = [CCMenuItemToggle itemWithTarget:self 
																selector:@selector(SFXTogglePressed) 
																   items:SFXOnLabel,SFXOffLabel,nil];
				
		CCLabelBMFont *creditsButtonLabel = [CCLabelBMFont labelWithString:@"Credits" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel	*creditsButton = [CCMenuItemLabel itemWithLabel:creditsButtonLabel target:self selector:@selector(showCredits)];
		
		
		CCLabelBMFont *backButtonLabel = [CCLabelBMFont labelWithString:@"Back" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel	*backButton = [CCMenuItemLabel itemWithLabel:backButtonLabel target:self selector:@selector(returnToMainMenu)];
			
		CCMenu *optionsMenu = [CCMenu menuWithItems:musicToggle,
							   SFXToggle,
							   creditsButton,
							   backButton,nil];
		[optionsMenu alignItemsVerticallyWithPadding:60.0f];
		[optionsMenu setPosition:ccp(screenSize.width * 0.75f, screenSize.height/2)];
		[self addChild:optionsMenu];
        
        if ([[GameManager sharedGameManager] isMusicON] == NO) {
            [musicToggle setSelectedIndex:1]; // Music is OFF
        }
        
        if ([[GameManager sharedGameManager] isSoundEffectsON] == NO) {
            [SFXToggle setSelectedIndex:1]; // SFX are OFF
        }
	}
	return self;
}
@end
