//
//  CreditsLayer.m
//  SpaceViking
//
//  Created by Rod on 9/18/10.
//  Copyright 2010 Prop Group LLC - www.prop-group.com. All rights reserved.
//

#import "CreditsLayer.h"


@implementation CreditsLayer

-(void)returnToOptionMenu {
	[[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}

-(void)goToWebSite:(CCMenuItemLabel*)labelPressed {
	CCLOG(@"Going to WebSite");
	[[GameManager sharedGameManager] openSiteWithLinkType:[labelPressed tag]];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		CGSize screenSize = [CCDirector sharedDirector].winSize; 
		CCSprite *background = [CCSprite spriteWithFile:@"GenericMenuBackground.png"];
		[background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:background];
		
		
		CCLabelBMFont *developerLabelTextRod = [CCLabelBMFont labelWithString:@"Dev and Programming: Rod Strougo" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel *developerLabelRod = [CCMenuItemLabel itemWithLabel:developerLabelTextRod target:self selector:@selector(goToWebSite:)];
		[developerLabelRod setTag:kLinkTypeDeveloperSiteRod];

		CCLabelBMFont *developerLabelTextRay = [CCLabelBMFont labelWithString:@"Physics Programming: Ray Wenderlich" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel *developerLabelRay = [CCMenuItemLabel itemWithLabel:developerLabelTextRay target:self selector:@selector(goToWebSite:)];
		[developerLabelRay setTag:kLinkTypeDeveloperSiteRay];
        
		CCLabelBMFont *artistLabelText = [CCLabelBMFont labelWithString:@"Art and Graphics: Eric Stevens" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel *artistLabel = [CCMenuItemLabel itemWithLabel:artistLabelText target:self selector:@selector(goToWebSite:)];
		[artistLabel setTag:kLinkTypeArtistSite];
		
		CCLabelBMFont *musicianLabelText = [CCLabelBMFont labelWithString:@"Music and Sound Effects: Mike Weiser" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel *musicianLabel = [CCMenuItemLabel itemWithLabel:musicianLabelText target:self selector:@selector(goToWebSite:)];
		[musicianLabel setTag:kLinkTypeMusicianSite];
		
		CCLabelBMFont *backLabelText = [CCLabelBMFont labelWithString:@"Back" fntFile:@"VikingSpeechFont64.fnt"];
		CCMenuItemLabel *backLabel = [CCMenuItemLabel itemWithLabel:backLabelText target:self selector:@selector(returnToOptionMenu)];
	
		
		
		CCMenu *optionsMenu = [CCMenu menuWithItems:
							   developerLabelRod,
                               developerLabelRay,
							   artistLabel,
							   musicianLabel,
							   backLabel,nil];
		
		[optionsMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
		[optionsMenu setPosition:ccp(screenSize.width /2, screenSize.height * 0.35f)];
		[self addChild:optionsMenu];
		
		
	}
	return self;
}

@end
