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
    NSString *userMessage = _PlainPostContent.text;
    NSString *privlyMessage = @"Ultimately, this would be converted to a privly link.";
    NSString *postContent = [userMessage stringByAppendingFormat:@"\n\n%@", privlyMessage];
    SocialNetworksRequest *requestHandler = [[SocialNetworksRequest alloc] init];
    // Set delegate to push SocialNetworkRequest's SLComposeViewController
    requestHandler.delegate = self;
    requestHandler.postContent = postContent;
    // Select appropriate social network
    [requestHandler setupAccountForServiceTypeInt:_socialNetworkId];
    [requestHandler postMessage];
}

@end
