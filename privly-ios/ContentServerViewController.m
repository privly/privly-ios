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
        _customContentServerTextField = [[UITextField alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _customContentServerTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    /**
     * If the Content Server is set,
     * update text label.
     */
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
    /**
     * Sets content server with appropriate field validation
     */
    
    // Prepare an alert to notify users that the content server has been successfully set.
    UIAlertView *contentServerSetAlert = [[UIAlertView alloc] initWithTitle:@"Content Server Updated"
                                                                    message:nil
                                                                   delegate:self
                                                          cancelButtonTitle:@"Back"
                                                          otherButtonTitles:nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIButton *contentServerButton = (UIButton *)sender;
    NSString *contentServerString = contentServerButton.titleLabel.text;
    NSString *customContentServer = _customContentServerTextField.text;
    
    NSLog(@"CUSTOM CONTENT SERVER IN FILE: %@", _customContentServerTextField);

    
    // Case where user enters empty custom content server.
    // ToDo: Validate content server URL.
    if ([contentServerString isEqualToString:@"Update"] && [customContentServer isEqualToString:@""]) {
        UIAlertView *emptyContentServerAlert = [[UIAlertView alloc] initWithTitle:@"Content Server cannot be empty."
                                                                          message:nil
                                                                         delegate:self
                                                                cancelButtonTitle:@"Back"
                                                                otherButtonTitles:nil];
        [emptyContentServerAlert show];
    // Save content server.
    // Users enter valid content server.
    } else if ([contentServerString isEqualToString:@"Update"] && ![_customContentServerTextField.text isEqualToString:@""]) {
        [userDefaults setValue:customContentServer forKey:@"content_server"];
        _currentContentServerLabel.text = [NSString stringWithFormat:@"Current Content Server:\n%@", customContentServer];
        [contentServerSetAlert show];
    } else {
    // User chooses default content server.
        [userDefaults setValue:contentServerString forKey:@"content_server"];
        _currentContentServerLabel.text = [NSString stringWithFormat:@"Current Content Server:\n%@", contentServerString];
        [contentServerSetAlert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // ToDo: Update Content Server on TextField return.
    [textField resignFirstResponder];
    return YES;
}

@end
