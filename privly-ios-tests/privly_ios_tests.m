//
//  privly_ios_tests.m
//  privly-ios-tests
//
//  Created by Hery Ratsimihah on 6/5/13.
//  Copyright (c) 2013 Hery Ratsimihah. All rights reserved.
//

#import "privly_ios_tests.h"

@implementation privly_ios_tests

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    NSLog(@"%@ setUp", self.name);
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testAppDelegate
{
    STAssertNotNil(appDelegate, @"Cannot find the application delegate");
}

@end
