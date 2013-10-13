//
//  PlainPostDestinationViewControllerTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "PlainPostDestinationViewControllerTest.h"

@implementation PlainPostDestinationViewControllerTest

- (void)setUp
{
    [super setUp];
    plainPostDestinationViewController = [[PlainPostDestinationViewController alloc] init];
    appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.nav pushViewController:plainPostDestinationViewController animated:YES];
    services = [NSArray arrayWithObjects:@"Facebook", @"Twitter", nil];
}

- (void)tearDown
{
    plainPostDestinationViewController = nil;
    [super tearDown];
}

- (void)testAvailableServices
{
    STAssertEqualObjects(services, plainPostDestinationViewController.availableServices,
                   @"The plainPostDestinationViewController is not testing for the correct available services.");
}

- (void)testNumberOfSections
{
    STAssertEquals([plainPostDestinationViewController numberOfSectionsInTableView:plainPostDestinationViewController.tableView],
                   1,
                   @"The number of sections in the table view is different from 1.");
}

- (void)testNumberOfRows
{
    NSInteger numberOfRows = [plainPostDestinationViewController tableView:plainPostDestinationViewController.tableView numberOfRowsInSection:1];
    NSInteger servicesCount = [services count];
    STAssertEquals(numberOfRows,
                   servicesCount,
                   @"The number of rows is different from the length of the services array.");
}

- (void)testCellAtIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    UITableViewCell *testCell = [plainPostDestinationViewController tableView:plainPostDestinationViewController.tableView cellForRowAtIndexPath:indexPath];
    STAssertEqualObjects(testCell.textLabel.text,
                   services[indexPath.row],
                   @"Cell title doesn't match service name.");
}

@end
