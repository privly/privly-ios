//
//  ReadingStreamViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ReadingModeViewController.h"
#import "PostReadingViewController.h"
#import "SocialNetworksRequest.h"

@interface ReadingModeViewController ()

@end

@implementation ReadingModeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _URLList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    snHelper = [[SocialNetworksRequest alloc] init];
    snHelper.delegate = self;

    // Load Twitter posts
    snHelper.serviceTypeString = SLServiceTypeTwitter;
    [snHelper getPostsWithCompletionHandler:^(NSString *tweet) {
        [_URLList addObject:tweet];
        [[self tableView] reloadData];
    }];
    
    // Load Facebook posts
    snHelper.serviceTypeString = SLServiceTypeFacebook;
    [snHelper getPostsWithCompletionHandler:^(NSString *post) {
        [_URLList addObject:post];
        [[self tableView] reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_URLList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _URLList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostReadingViewController *postReadingViewController = [[PostReadingViewController alloc] init];
    postReadingViewController.applicationURL = _URLList[indexPath.row];
    [self.navigationController pushViewController:postReadingViewController animated:YES];
}

@end
