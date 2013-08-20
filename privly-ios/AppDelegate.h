//
//  AppDelegate.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    CustomNavigationViewController *nav;
}

@property (strong, nonatomic) UIWindow *window;

- (void)login;

@end
