//
//  PlainPostDestinationViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "PlainPostDestinationViewController.h"
#import "SocialNetworksRequest.h"

@interface PlainPostDestinationViewController ()

@end

@implementation PlainPostDestinationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Destination";
        availableServices = [NSArray arrayWithObjects:@"Facebook", @"Twitter", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return [availableServices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [availableServices objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SocialNetworksRequest *requestHandler = [[SocialNetworksRequest alloc] init];
    // Set delegate to push SocialNetworkRequest's SLComposeViewController
    requestHandler.delegate = self;
    requestHandler.link = _link;
    // Select appropriate social network
    [requestHandler setupAccountForServiceTypeInt:indexPath.row];
    [requestHandler postMessage];
}

@end
