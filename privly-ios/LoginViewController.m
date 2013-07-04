//
//  LoginViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Login";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
      set textfields delegate as self to receive the textFieldShouldReturn message
      */
    self.passwordTextField.delegate = self;
    self.emailTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Authentication

- (IBAction)getToken:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if ([email isEqualToString:@"a"] || [password isEqualToString:@"a"]) {
        NSLog(@"All fields are required.");
    } else {
        NSString *stringURL = [NSString stringWithFormat:@"https://privlyalpha.org/token_authentications.json"];
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
                if (jsonResponse != nil && error == nil) {
                    NSDictionary *authKeyDictionary = (NSDictionary *)jsonResponse;
                    NSString *authenticationKey = [authKeyDictionary objectForKey:@"auth_key"];
                    NSLog(@"Authentication token received: %@.", authenticationKey);
                    // Save token in user preferences.
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:authenticationKey forKey:@"auth_token"];
                    [userDefaults synchronize];
                    NSLog(@"Authentication token saved in user preferences.");
                }
            } else if ([data length] == 0 && error == nil) {
                NSLog(@"Success, no response.");
            } else if (error != nil) {
                NSLog(@"Something went wrong");
            }
        }];
        
        [self.view endEditing:YES];
        ApplicationTypeViewController *applicationTypeViewController = [[ApplicationTypeViewController alloc] init];
        [self.navigationController pushViewController:applicationTypeViewController animated:YES];
    }
}

#pragma mark - textfield delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
