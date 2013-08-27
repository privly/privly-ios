//
//  ApplicationTypeViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ApplicationTypeViewController.h"
#import "ContentServerViewController.h"
#import "LoginViewController.h"
#import "ReadingModeViewController.h"
#import "PostTypeViewController.h"

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
        UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(contentServer:)];
        UINavigationItem *nav = self.navigationItem;
        [nav setLeftBarButtonItem:logoutButton];
        [nav setRightBarButtonItem:settingsButton];
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
    PostTypeViewController *postTypeViewController = [[PostTypeViewController alloc] init];
    [self.navigationController pushViewController:postTypeViewController animated:YES];
}

- (IBAction)readingMode:(id)sender {
    ReadingModeViewController *readingModeViewController = [[ReadingModeViewController alloc] init];
    [self.navigationController pushViewController:readingModeViewController animated:YES];
}

- (IBAction)contentServer:(id)sender {
    ContentServerViewController *contentServerViewController = [[ContentServerViewController alloc] init];
    contentServerViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:contentServerViewController animated:YES completion:nil];
}

@end