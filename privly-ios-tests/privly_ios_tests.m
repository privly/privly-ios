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
    NSLog(@"%@ tearDown", self.name);
    appDelegate = nil;
    [super tearDown];
}

- (void)testAppDelegate
{
    NSLog(@"%@ start", self.name);
    STAssertNotNil(appDelegate, @"Cannot find the application delegate");
    NSLog(@"%@ end", self.name);
}

- (void)testLogin {
    NSLog(@"%@ start", self.name);
    [appDelegate login];
    NSInteger loginViewControllerIndex = [appDelegate.nav.viewControllers count]-1;
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    STAssertEqualObjects([appDelegate.nav.viewControllers[loginViewControllerIndex] class],
                          [loginViewController class],
                          @"Login view controller couldn't be pushed.");
    NSLog(@"%@ end", self.name);
}

- (void)testSkipLogin {
    NSLog(@"%@ start", self.name);
    [appDelegate skipLogin];
    NSInteger applicationTypeViewControllerIndex = [appDelegate.nav.viewControllers count]-1;
    ApplicationTypeViewController *applicationTypeViewController = [[ApplicationTypeViewController alloc] init];
    STAssertEqualObjects([appDelegate.nav.viewControllers[applicationTypeViewControllerIndex] class],
                         [applicationTypeViewController class],
                         @"Application Type view controller couldn't be pushed.");
    NSLog(@"%@ end", self.name);
}
@end
