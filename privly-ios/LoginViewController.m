//
//  LoginViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "LoginViewController.h"
#import "ContentServerViewController.h"
#import "CustomNavigationViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Login";
        NSLog(@"Login VC done initializing.");
        checkingCredentialsAlert = [[UIAlertView alloc] initWithTitle:@"Checking credentials,\nplease wait..."
                                                              message:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
      * Sets textfields delegate as self to receive the textFieldShouldReturn message.
      * Hide the back button to prevent users from going back to an undesired state
      * where an ApplicationTypeViewController is popped when the user is not logged in.
      */
    self.navigationController.navigationBarHidden = NO;

    _passwordTextField.delegate = self;
    _emailTextField.delegate = self;
    originalCenter = self.view.center;
    UIBarButtonItem *noBack = [[UIBarButtonItem alloc] initWithTitle:@""
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:nil];
    [[self navigationItem] setLeftBarButtonItem:noBack];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentContentServer = [userDefaults valueForKey:@"content_server"];
    if (currentContentServer) {
        _contentServerLabel.text = currentContentServer;
    } else {
        _contentServerLabel.text = @"None. Please set a content server below.";
    }
    NSLog(@"Login VC done loading.");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"Login VC done appearing.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Authentication

- (IBAction)getToken:(id)sender {
    /**
     * Upon login, the appropriate request is sent to the chosen
     * content server, which returns an authentication token.
     * The authentication token is stored in user preferences for subsequent requests.
     * In this case, it is passed to the UIWebViews that load the posting applications.
     */
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *contentServerString = [userDefaults valueForKey:@"content_server"];

    
    if ([email isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertView *emptyFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Hold on!"
                                                                   message:@"Email or password can't be empty."
                                                                  delegate:self
                                                         cancelButtonTitle:@"Back"
                                                         otherButtonTitles:nil];
        [emptyFieldsAlert show];
    } else {
        NSString *stringURL = [NSString stringWithFormat:@"%@/token_authentications.json", contentServerString];
        NSURL *requestURL = [NSURL URLWithString:stringURL];
        NSMutableURLRequest *mutableURLRequest = [NSMutableURLRequest requestWithURL:requestURL];
        
        NSString *parameterString = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
        NSData *parameterData = [parameterString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        [mutableURLRequest setHTTPMethod:@"POST"];
        [mutableURLRequest setHTTPBody:parameterData];
        [mutableURLRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:mutableURLRequest queue:queue completionHandler:^(NSURLResponse *response,
                                                                                                   NSData *data,
                                                                                                   NSError *error) {
            if ([data length] > 0 && error == nil) {
                // If successful request, deserialize JSON response and get authentication key
                id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"%@", jsonResponse);
                if (jsonResponse != nil && error == nil) {
                    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithDictionary:jsonResponse];
                    if ([[jsonDictionary objectForKey:@"error"] isEqualToString:@"incorrect email or password"]) {
                        // Request is successful but credentials are wrong.
                        [checkingCredentialsAlert dismissWithClickedButtonIndex:0 animated:YES];
                        UIAlertView *invalidCredentials = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials"
                                                                                     message:@"Incorrect email or password."
                                                                                    delegate:self cancelButtonTitle:@"Back"
                                                                           otherButtonTitles:nil];
                        [invalidCredentials show];
                    } else {
                        // Request is successful and credentials are valid.
                        NSDictionary *authKeyDictionary = (NSDictionary *)jsonResponse;
                        NSString *authenticationKey = [authKeyDictionary objectForKey:@"auth_key"];
                        NSLog(@"Authentication token received: %@.", authenticationKey);
                        // Save token in user preferences.
                        [userDefaults setObject:authenticationKey forKey:@"auth_token"];
                        [userDefaults synchronize];
                        NSLog(@"Authentication token saved in user preferences.");
                        [checkingCredentialsAlert dismissWithClickedButtonIndex:0 animated:YES];
                        ApplicationTypeViewController *applicationTypeViewController = [[ApplicationTypeViewController alloc] init];
                        [self.navigationController pushViewController:applicationTypeViewController animated:YES];
                    }
                }
            } else if ([data length] == 0 && error == nil) {
                NSLog(@"Success, no response.");
            } else if (error != nil) {
                NSLog(@"Something went wrong");
            }
        }];
        [self.view endEditing:YES];
        [checkingCredentialsAlert show];
    }
}

#pragma mark - textfield delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)showContentServerViewController:(id)sender {
    ContentServerViewController *contentServerViewController = [[ContentServerViewController alloc] init];
    [self.navigationController presentViewController:contentServerViewController animated:YES completion:nil];
}

@end

