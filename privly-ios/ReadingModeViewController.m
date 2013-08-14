//
//  ReadingStreamViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ReadingModeViewController.h"

@interface ReadingModeViewController ()

@end

@implementation ReadingModeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        URLList = [[NSArray alloc] initWithObjects:
                   @"https://privlyalpha.org/apps/PlainPost/show?privlyApp=PlainPost&privlyInject1=true&random_token=8286588067&privlyDataURL=https%3A%2F%2Fprivlyalpha.org%2Fposts%2F1016.json%3Frandom_token%3D8286588067#privlyInject1=true&p=p",
                   @"https://privlyalpha.org/apps/PlainPost/show?privlyApp=PlainPost&privlyInject1=true&random_token=c72d4aeb70&privlyDataURL=https%3A%2F%2Fprivlyalpha.org%2Fposts%2F1015.json%3Frandom_token%3Dc72d4aeb70#privlyInject1=true&p=p",
                   @"https://privlyalpha.org/apps/PlainPost/show?privlyApp=PlainPost&privlyInject1=true&random_token=67bdb9de26&privlyDataURL=https%3A%2F%2Fprivlyalpha.org%2Fposts%2F1004.json%3Frandom_token%3D67bdb9de26#privlyInject1=true&p=p", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", URLList[indexPath.row]);
}

@end
