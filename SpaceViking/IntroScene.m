//
//  IntroScene.m
//  SpaceViking
//
#import "IntroScene.h"


@implementation IntroScene
-(id)init {
	self = [super init];
	if (self != nil) {
		IntroLayer *myLayer = [IntroLayer node];
		[self addChild:myLayer];
		
	}
	return self;
}
@end
