//
//  PostTypeViewControllerTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "PostTypeViewControllerTest.h"
#import "CreatePostViewController.h"

@implementation PostTypeViewControllerTest

- (void)setUp
{
    [super setUp];
    appDelegate = [[UIApplication sharedApplication] delegate];
    postTypeViewController = [[PostTypeViewController alloc] init];
    postTypeViewController.postTypes = @[@"PlainPost", @"ZeroBin"];
    [appDelegate.nav pushViewController:postTypeViewController animated:NO];
}

- (void)tearDown
{
    appDelegate = nil;
    postTypeViewController = nil;
    [super tearDown];
}

- (void)testNumberOfSectionsInTableView
{
    STAssertEquals([postTypeViewController numberOfSectionsInTableView:postTypeViewController.tableView],
                   1,
                   @"The number of sections in the table view is different from 1.");
}

- (void)testNumberOfRowsInSection
{
    NSInteger numberOfRowsInSection = [postTypeViewController tableView:postTypeViewController.tableView numberOfRowsInSection:1];
    NSInteger dataSourceCount = [postTypeViewController.postTypes count];
    STAssertEquals(numberOfRowsInSection,
                   dataSourceCount,
                   @"The number of rows in the first section is different than the length of the data source.");
}

- (void)testCellForRowAtIndexPath
{
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [postTypeViewController tableView:postTypeViewController.tableView cellForRowAtIndexPath:cellIndexPath];
    NSString *titleForCellAtIndexPath = cell.textLabel.text;
    NSString *titleForIteminDataSourceAtIndexPath = postTypeViewController.postTypes[cellIndexPath.row];
    STAssertTrue([titleForCellAtIndexPath isEqualToString:titleForIteminDataSourceAtIndexPath],
                   @"Cell title doesn't match data source item.");
}

- (void)testDidSelectRowAtIndexPath
{
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [postTypeViewController tableView:postTypeViewController.tableView didSelectRowAtIndexPath:cellIndexPath];
    NSLog(@"topViewController class: %@", [[postTypeViewController.navigationController.topViewController class] description]);
    STAssertEqualObjects([[postTypeViewController.navigationController.topViewController class] description], [[CreatePostViewController class] description],
                   @"A CreatePostViewController instance couldn't be pushed.");
}

@end
