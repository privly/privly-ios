//
//  privly_ios_tests.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "privly_ios_tests.h"

@implementation privly_ios_tests

- (void)setUp
{
    [super setUp];
    NSLog(@"%@ setUp", self.name);
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)tearDown
{
    // Tear-down code here.
    NSLog(@"%@ tearDown", self.name);
    [super tearDown];
}

- (void)testAppDelegate
{
    NSLog(@"%@ start", self.name);
    STAssertNotNil(appDelegate, @"Cannot find the application delegate");
    STAssertNotNil(appDelegate.loginViewController, @"Cannot find application's delegate loginViewController");
    NSLog(@"%@ end", self.name);
}

- (void)testLoginViewController
{
    NSLog(@"%@ start", self.name);
    STAssertTrue([appDelegate.loginViewController.passwordTextField.delegate isEqual:appDelegate.loginViewController] , @"Delegate not set properly");
    STAssertTrue([appDelegate.loginViewController.emailTextField.delegate isEqual:appDelegate.loginViewController] , @"Delegate not set properly");
    // Need a test for user authentication
    NSLog(@"%@ end", self.name);

}

@end
