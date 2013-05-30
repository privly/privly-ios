//
//  PlainPostViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "PlainPostViewController.h"

@interface PlainPostViewController ()

@end

@implementation PlainPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"PlainPost";
        self.dismissKeyboardButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
        UINavigationItem *nav = self.navigationItem;
        [nav setRightBarButtonItem:self.dismissKeyboardButton];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.PlainPostContent.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dismissKeyboardButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark textfield behavior methods

- (BOOL)textViewShouldReturn:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.dismissKeyboardButton.enabled = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.dismissKeyboardButton.enabled = NO;
}

- (void)dismissKeyboard {
    [self.PlainPostContent resignFirstResponder];
}

# pragma mark content posting methods 

- (IBAction)createPlainPost:(id)sender {
    NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
    NSString *status = _PlainPostContent.text;
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:@[status] forKeys:@[@"status"]];
    SocialNetworksRequest *requestHandler = [[SocialNetworksRequest alloc] initWithURL:requestURL params:params];
    [requestHandler setupAccountForServiceTypeInt:_socialNetworkId];
    [requestHandler postMessage];
    UIAlertView *messagePosted = [[UIAlertView alloc] initWithTitle:@"Message posted!" message:nil delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil];
    [messagePosted show];
}

@end
