//
//  ApplicationTypeViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ApplicationTypeViewController.h"
#import "ContentServerViewController.h"
#import "LoginViewController.h"

@interface ApplicationTypeViewController ()

@end

@implementation ApplicationTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Privly";
        
        UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                        style:UIBarButtonItemStylePlain target:self
                                                                        action:@selector(logout:)];
        UINavigationItem *nav = self.navigationItem;
        [nav setRightBarButtonItem:logoutButton];
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

- (IBAction)logout:(id)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)createPost:(id)sender {
    TestPostViewController *testPostViewController = [[TestPostViewController alloc] init];
    [self.navigationController pushViewController:testPostViewController animated:YES];
}

- (IBAction)readingMode:(id)sender {
    UIAlertView *readingModeAlert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Reading Mode is currently being implemented." delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil];
    [readingModeAlert show];
}

- (IBAction)contentServer:(id)sender {
    ContentServerViewController *contentServerViewController = [[ContentServerViewController alloc] init];
    contentServerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:contentServerViewController animated:YES completion:nil];
}

@end