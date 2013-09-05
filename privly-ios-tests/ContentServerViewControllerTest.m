//
//  ContentServerViewControllerTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ContentServerViewControllerTest.h"

@implementation ContentServerViewControllerTest

- (void)setUp
{
    [super setUp];
    appDelegate = [[UIApplication sharedApplication] delegate];
    contentServerViewController = [[ContentServerViewController alloc] init];
    NSLog(@"Presented view controller: %@", appDelegate.nav.presentedViewController);
    [appDelegate.nav pushViewController:contentServerViewController animated:NO];
}

- (void)tearDown
{
    appDelegate = nil;
    contentServerViewController = nil;
    [super tearDown];
}

- (void)testDismissContentServerViewController
{
    NSLog(@"Presented view controller: %@", appDelegate.nav.presentedViewController);
    [contentServerViewController dismissContentServerViewController:nil];
    NSLog(@"Presented view controller: %@", appDelegate.nav.presentedViewController);
    STFail(@"testDismissContentServerViewController is incomplete.");
}

- (void)testSetContentServer
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    UIButton *contentServerButton = [[UIButton alloc] init];
    contentServerButton.titleLabel.text = @"https://privlyalpha.org";
    [contentServerViewController setContentServer:contentServerButton];
    NSLog(@"content server: %@", [userDefaults objectForKey:@"content_server"]);
    STAssertTrue([[userDefaults valueForKey:@"content_server"] isEqualToString:@"https://privlyalpha.org"], @"Content server not set.");
    
    contentServerButton.titleLabel.text = @"Update";
    contentServerViewController.customContentServerTextField.text = @"https://customdomain.com";
    [contentServerViewController setContentServer:contentServerButton];
    NSLog(@"content server: %@", [userDefaults objectForKey:@"content_server"]);
    STAssertEqualObjects([userDefaults valueForKey:@"content_server"], @"https://customdomain.com", @"Content server not set.");
}

@end
