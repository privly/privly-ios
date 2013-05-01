//
//  ApplicationTypeViewController.m
//  privly-ios
//
//  Created by devplayerx on 5/1/13.
//  Copyright (c) 2013 Hery Ratsimihah. All rights reserved.
//

#import "ApplicationTypeViewController.h"

@interface ApplicationTypeViewController ()

@end

@implementation ApplicationTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Post Type";
        
        UIBarButtonItem *readingMode = [[UIBarButtonItem alloc] initWithTitle:@"Read" style:UIBarButtonItemStylePlain target:self action:@selector(switchToReadingMode)];
        UINavigationItem *nav = self.navigationItem;
        [nav setRightBarButtonItem:readingMode];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPlainPost:(id)sender {
}

- (IBAction)createZeroBinPost:(id)sender {
    ZeroBinPostViewController *zeroBinPostViewController = [[ZeroBinPostViewController alloc] init];
    [self.navigationController pushViewController:zeroBinPostViewController animated:YES];
}

- (IBAction)logout:(id)sender {
}

- (void)switchToReadingMode {
    NSLog(@"Feature not implemented yet.");
    // Push reading mode view controller
}
@end
