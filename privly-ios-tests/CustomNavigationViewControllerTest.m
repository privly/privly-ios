//
//  CustomNavigationViewControllerTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//


#import "CustomNavigationViewControllerTest.h"

@implementation CustomNavigationViewControllerTest

- (void)setUp
{
    customNavigationViewController = [[CustomNavigationViewController alloc] init];
}

- (void)tearDown
{
    customNavigationViewController = nil;
}

- (void)testShouldAutorotate {
    STAssertEquals([customNavigationViewController shouldAutorotate],
                   YES,
                   @"Custom navigation controller shouldAutorotate's method does not return YES.");
}

- (void)testsupportedInterfaceOrientations {
    STAssertEquals([customNavigationViewController supportedInterfaceOrientations],
                   UIInterfaceOrientationMaskAll,
                   @"Custom navigation controller supportedInterfaceOrientations's \
                   method does not return UIInterfaceOrientationMaskAll.");
}

@end
