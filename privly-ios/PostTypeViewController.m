//
//  PostTypeViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "PostTypeViewController.h"
#import "CreatePostViewController.h"

@interface PostTypeViewController ()

@end

@implementation PostTypeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        postTypes = @[@"PlainPost", @"ZeroBin"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.878 green:0.847 blue:0.784 alpha:1.000];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [postTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** Set up cells backgroun color and title. */
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:0.878 green:0.847 blue:0.784 alpha:1.000];
    cell.textLabel.text = [postTypes objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** Push a CreatePostViewController instance on cell selection. */
    CreatePostViewController *testPostViewController = [[CreatePostViewController alloc] init];
    NSString *postType = postTypes[indexPath.row];
    testPostViewController.postType = postType;
    [self.navigationController pushViewController:testPostViewController animated:YES];
}

@end
