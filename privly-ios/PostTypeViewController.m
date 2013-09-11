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
        _postTypes = @[@"PlainPost", @"ZeroBin"];
        _postDescription = @[@"No Encryption", @"Link Encrypted"];
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
    return [_postTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** Set up cells backgroun color and title. */
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    // If performance becomes an issue, reimplement custom cells using dequeueReusableCellWithIdentifier:CellIdentifier.
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    cell.backgroundColor = [UIColor colorWithRed:0.878 green:0.847 blue:0.784 alpha:1.000];
    cell.detailTextLabel.text = [_postDescription objectAtIndex:indexPath.row];
    cell.textLabel.text = [_postTypes objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** Push a CreatePostViewController instance on cell selection. */
    CreatePostViewController *testPostViewController = [[CreatePostViewController alloc] init];
    testPostViewController.applicationTypeViewController = self.applicationTypeViewController;
    NSString *postType = _postTypes[indexPath.row];
    testPostViewController.postType = postType;
    [self.navigationController pushViewController:testPostViewController animated:YES];
}

@end
