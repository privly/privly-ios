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

@end
