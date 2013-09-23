//
//  AppDelegate.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationViewController.h"

/**
 * Application's delegate. It sets the navigation controller and root view controller,
 * and redirects users to the login page or home page based on their login status.
 */

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) CustomNavigationViewController *nav;

- (void)login;
- (void)skipLogin;

@end
