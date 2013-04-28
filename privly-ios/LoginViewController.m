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
    NSString * authToken;
    if ((authToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"])) {
        [self.authenticationTokenLabel setText:authToken];
    } else {
        [self.authenticationTokenLabel setText:@"No token"];
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark API CALLS

- (IBAction)getToken:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    NSString *stringURL = [NSString stringWithFormat:@"https://privlyalpha.org/token_authentications.json"
                           ];
    NSURL *requestURL = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *mutableURLRequest = [NSMutableURLRequest requestWithURL:requestURL];
    
    // Set request's method
    [mutableURLRequest setHTTPMethod:@"POST"];
    
    // Set request's parameters
    NSString *parameterString = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    NSData *parameterData = [parameterString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [mutableURLRequest setHTTPBody:parameterData];
    
    // Set request's Content-Type
    [mutableURLRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:mutableURLRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // Was the request successful ?
        if ([data length] > 0 && error == nil) {
            // Deserialize JSON response and get authentication key
            id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (jsonResponse != nil && error == nil) {
                NSDictionary *authKeyDictionary = (NSDictionary *)jsonResponse;
                NSString *authenticationKey = [authKeyDictionary objectForKey:@"auth_key"];
                [self.authenticationTokenLabel setText:authenticationKey];
                NSLog(@"%@", authenticationKey);
                // Save token in user preferences
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:authenticationKey forKey:@"auth_token"];
                [userDefaults synchronize];
            }
        } else if ([data length] == 0 && error == nil) {
            NSLog(@"Success. No response.");
        } else if (error != nil) {
            NSLog(@"Something went wrong");
        }
    }];
    
    [self.view endEditing:YES];
}

@end
