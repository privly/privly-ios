//
//  ContentServerViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ContentServerViewController.h"

@interface ContentServerViewController ()

@end

@implementation ContentServerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *contentServerString = [[NSUserDefaults standardUserDefaults] valueForKey:@"content_server"];
    if (![contentServerString isEqualToString:@""]) {
        _currentContentServerLabel.text = [NSString stringWithFormat:@"Current Content Server is:\n%@", contentServerString];
    } else {
        _currentContentServerLabel.text = @"Content Server is not set.";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissContentServerViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setContentServer:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIButton *contentServerButton = (UIButton *)sender;
    NSString *contentServerString = contentServerButton.titleLabel.text;
    [userDefaults setValue:contentServerString forKey:@"content_server"];
    _currentContentServerLabel.text = [NSString stringWithFormat:@"Current Content Server is:\n%@", contentServerString]; 
    UIAlertView *contentServerAlert = [[UIAlertView alloc] initWithTitle:@"Content Server Updated" message:nil delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil];
    [contentServerAlert show];
}
@end
