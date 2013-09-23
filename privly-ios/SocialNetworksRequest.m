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
        _URLList = [[NSMutableArray alloc] init];
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

#pragma mark -

#pragma mark Shared

- (BOOL)userHasAccessToService {
    return [SLComposeViewController isAvailableForServiceType:_serviceTypeString];
}

#pragma mark Posting Application

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

#pragma mark Reading Application

- (void)getPostsWithCompletionHandler:(void (^)(NSString *tweet))completionHandler {
    /**
     * The current implementation dislays alert views when accounts are not set up.
     * For a smoother user experience, a label should be shown around the UITableView and 
     * update accordingly.
     * In addition, the current implementation returns URLs to be displayed as cells titles.
     * It can be improved by displaying posts metadata, which would be more descriptive.
     */
    if ([_serviceTypeString isEqualToString:SLServiceTypeFacebook]) {
        // Handle Facebook case here
        _facebookAppID = @"630036107036663";
        _facebookPermissions = @[@"email, read_stream"];
        _facebookOptions = @{ACFacebookAppIdKey : _facebookAppID,
                             ACFacebookPermissionsKey : _facebookPermissions};
        
        ACAccountType *facebookAccountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        [_accountStore requestAccessToAccountsWithType:facebookAccountType options:_facebookOptions completion:^(BOOL granted, NSError *error) {
            if (granted) {
                // Set up account
                ACAccount *facebookAccount = [[ACAccount alloc] initWithAccountType:facebookAccountType];
                NSArray *facebookAccounts = [_accountStore accountsWithAccountType:facebookAccountType];
                facebookAccount = [facebookAccounts lastObject];
                
                // Format URL request
                NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me/posts"];
                NSURL *postsURL = [NSURL URLWithString:urlString];
                SLRequest *postsRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                             requestMethod:SLRequestMethodGET
                                                                       URL:postsURL
                                                                parameters:@{@"fields":@"message",@"limit":@"100"}];
                
                [postsRequest setAccount:facebookAccount];
                [postsRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    if (responseData) {
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
                        NSArray *dataResponseArray = jsonResponse[@"data"];
                        if ([dataResponseArray count] > 0) {
                            for (NSDictionary *post in dataResponseArray) {
                                if (nil!=post[@"message"]) {
                                    // Got post.
                                    if ([post[@"message"] rangeOfString:@"privlyInject1"].location != NSNotFound) {
                                        completionHandler(post[@"message"]);
                                    }
                                }
                            }
                        }
                    } else {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                }];
            } else {
                NSLog(@"Error: %@", [error localizedDescription]);
                UIAlertView *accessDeniedAlertView = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                                message:@"Access to your Facebook account was denied. Please set up an account and try again."
                                                                               delegate:self.delegate
                                                                      cancelButtonTitle:@"Back"
                                                                      otherButtonTitles:nil];
                [accessDeniedAlertView show];

            }
        }];
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
                    NSDictionary *parameters = @{@"count":@"200", @"screen_name":userAccount.username, @"include_entities":@"true"};
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestUrl parameters:parameters];
                    request.account = userAccount;
                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        if (responseData) {
                            NSError *jsonError;
                            NSArray *userPosts = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                      options:NSJSONReadingAllowFragments
                                                                                        error:&jsonError];
                            
                            NSString *thisTweet;
                            NSArray *urlArray = [[NSArray alloc] init];
                            for (NSDictionary *tweet in userPosts) {
                                // filter URLs here and add them to data source.
                                urlArray = tweet[@"entities"][@"urls"];
                                if ([urlArray count] > 0) {
                                    thisTweet = urlArray[0][@"expanded_url"];
                                    if ([thisTweet rangeOfString:@"privlyInject1"].location != NSNotFound) {
                                        // The tweet contains a privly URL
                                        completionHandler(thisTweet);
                                    } // end of if ([thisTweet...])
                                } // end of if ([urlArray count] > 0)
                            } // end of for loop
                        } // end of if (responseData)
                    }]; // end of performRequestWithHandler
                } // end of if (granted)
            }];
        } else { // end of if ([self userHasAccessToService])
            UIAlertView *accessDeniedAlertView = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                            message:@"Access to your Twitter account was denied. Please set up an account and try again."
                                                                           delegate:self.delegate
                                                                  cancelButtonTitle:@"Back"
                                                                  otherButtonTitles:nil];
            [accessDeniedAlertView show];
        }
    }
}

@end
