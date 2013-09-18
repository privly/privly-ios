//
//  SocialNetworksRequest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "SocialNetworksRequest.h"

@implementation SocialNetworksRequest

- (id) init
{
    self = [super init];
    if (self) {
        _accountStore = [[ACAccountStore alloc] init];
    }    
    return self;
}

- (void)setupAccountForServiceTypeInt:(int)serviceTypeInt {
    switch (serviceTypeInt) {
        case 0:
            _serviceTypeString = SLServiceTypeFacebook;
            break;
        case 1:
            _serviceTypeString = SLServiceTypeTwitter;
            break;
        case 2: // Privly
            break;
        default:
            break;
    }
}

- (BOOL)userHasAccessToService {
    return [SLComposeViewController isAvailableForServiceType:_serviceTypeString];
}

- (void)postMessage {
    if ([self userHasAccessToService]) {
        SLComposeViewController *socialNetworkViewController = [SLComposeViewController composeViewControllerForServiceType:_serviceTypeString];
        [socialNetworkViewController setInitialText:_link];
        
        // Redirect users to the READ/POST page when they're done writing their post.
        socialNetworkViewController.completionHandler = ^(SLComposeViewControllerResult result) {
            [self.delegate.navigationController popToViewController:self.returnViewController animated:YES];
        };
        
        [_delegate presentViewController:socialNetworkViewController animated:YES completion:nil];
    } else {
        UIAlertView *serviceUnavailableAlert = [[UIAlertView alloc] initWithTitle:@"Service Unavailable"
                                                                          message:@"Login in your Settings to post content on social networks."
                                                                         delegate:self.delegate
                                                                cancelButtonTitle:@"Back"
                                                                otherButtonTitles:nil];
        [serviceUnavailableAlert show];
    }
}

- (void)getPosts {
    if ([_serviceTypeString isEqualToString:SLServiceTypeFacebook]) {
        // Handle Facebook case here
    } else if ([_serviceTypeString isEqualToString:SLServiceTypeTwitter]) {
        // Handle Twitter case here
        if ([self userHasAccessToService]) {
            ACAccountType *twitterAccountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            [_accountStore requestAccessToAccountsWithType:twitterAccountType
               options:NULL
            completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    NSArray *twitterAccounts = [_accountStore accountsWithAccountType:twitterAccountType];
                    ACAccount *userAccount = [twitterAccounts lastObject];
                    NSURL *requestUrl = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                    NSDictionary *parameters = @{@"count":@"200", @"screen_name":userAccount.username};
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestUrl parameters:parameters];
                    request.account = userAccount;
                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        if (responseData) {
                            NSError *jsonError;
                            NSArray *userPosts = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                      options:NSJSONReadingAllowFragments
                                                                                        error:&jsonError];
                            for (NSDictionary *tweet in userPosts) {
                                // filter URLs here and add them to data source.
                                // Handle errors below.
                                NSLog(@"%@", tweet[@"text"]);
                            }
                        }
                    }];
                }
            }];
        }
    }
}

@end
