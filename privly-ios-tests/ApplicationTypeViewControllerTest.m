//
//  ApplicationTypeViewControllerTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//


#import "ApplicationTypeViewControllerTest.h"
#import "ApplicationTypeViewController.h"

@implementation ApplicationTypeViewControllerTest

- (void)setUp
{
    applicationTypeViewController = [[ApplicationTypeViewController alloc] init];
}

- (void)tearDown
{
    applicationTypeViewController = nil;
}

- (void)testTitle
{
    STAssertEqualObjects(applicationTypeViewController.title,
                         @"Privly",
                         @"Title is different from Privly.");
}

- (void)testReadButton
{
    STAssertEqualObjects(applicationTypeViewController.navigationItem.rightBarButtonItem.title,
                         @"Settings", @"Reading mode button is not set.");
}

- (void)testLogoutButton
{
    STAssertEqualObjects(applicationTypeViewController.navigationItem.leftBarButtonItem.title,
                         @"Logout", @"Reading mode button is not set.");
}

@end
