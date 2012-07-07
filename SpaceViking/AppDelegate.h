//
//  AppDelegate.h
//  SpaceViking
//
//  Created by Piotr Dudzicz on 6/29/12.
//  Copyright PolSource Sp. z o.o. 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
