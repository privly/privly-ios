//
//  AppDelegate.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) CustomNavigationViewController *nav;

- (void)login;

@end
