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
                         @"Post Type",
                         @"Title is not set.");
}

- (void)testReadButton
{
    STAssertEqualObjects(applicationTypeViewController.navigationItem.rightBarButtonItem.title,
                         @"Read", @"Reading mode button is not set.");
}

- (void)testCreatePlainPost
{
    [applicationTypeViewController createPlainPost:nil];
    if ([applicationTypeViewController.navigationController.viewControllers count] > 0) {
        STAssertTrue([applicationTypeViewController.navigationController.viewControllers[0] isKindOfClass:[PlainPostDestinationViewController class]], @"Plain Post view controller could not be created.");
    } else {
        STFail(@"Plain Post view controller could not be created.");
    }
}

- (void)testLogout
{
    
}

- (void)testSwitchToReadingMode
{
    
}

@end
