//
//  PlainPostDestinationViewControllerTest.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PlainPostDestinationViewController.h"
#import "AppDelegate.h"

@interface PlainPostDestinationViewControllerTest : SenTestCase {
    PlainPostDestinationViewController *plainPostDestinationViewController;
    AppDelegate *appDelegate;
    NSArray *services;
}

@end
