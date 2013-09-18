//
//  ReadingStreamViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ReadingModeViewController.h"
#import "PostReadingViewController.h"

@interface ReadingModeViewController ()

@end

@implementation ReadingModeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        URLList = [[NSArray alloc] initWithObjects:
                   @"https://privlyalpha.org/apps/PlainPost/show?privlyApp=PlainPost&privlyInject1=true&random_token=94d8fcbe71&privlyDataURL=https%3A%2F%2Fprivlyalpha.org%2Fposts%2F1070.json%3Frandom_token%3D94d8fcbe71#privlyInject1=true&p=p", nil];
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
    snHelper.serviceTypeString = SLServiceTypeTwitter;
    snHelper.delegate = self;
    [snHelper getPosts];
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
    return [URLList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = URLList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostReadingViewController *postReadingViewController = [[PostReadingViewController alloc] init];
    postReadingViewController.applicationURL = URLList[indexPath.row];
    [self.navigationController pushViewController:postReadingViewController animated:YES];
}

@end
