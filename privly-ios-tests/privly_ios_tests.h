//
//  privly_ios_tests.h
//  privly-ios-tests
//
//  Created by Hery Ratsimihah on 6/5/13.
//  Copyright (c) 2013 Hery Ratsimihah. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface privly_ios_tests : SenTestCase {
    AppDelegate *appDelegate;
    LoginViewController *loginViewController;
}

@end
