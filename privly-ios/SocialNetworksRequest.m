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

- (id) initWithURL:(NSURL *)requestURL params:(NSDictionary *)params {
    if (self) {
        _accountStore = [[ACAccountStore alloc] init];
        _requestURL = requestURL;
        _params = params;
    }
    return self;
}

- (void)setupAccountForServiceTypeInt:(int)serviceTypeInt {
    switch (serviceTypeInt) {
        case 0:
            serviceTypeString = SLServiceTypeFacebook;
            accountIdentifierString = ACAccountTypeIdentifierFacebook;
            break;
        case 1:
            serviceTypeString = SLServiceTypeTwitter;
            accountIdentifierString = ACAccountTypeIdentifierTwitter;
            break;
        case 2: // Privly
            break;
        default:
            break;
    }
}

- (BOOL)userHasAccessToService {    
    return [SLComposeViewController isAvailableForServiceType:serviceTypeString];
}

- (void)postMessage
{
    if ([self userHasAccessToService]) {
        ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:accountIdentifierString];
        [_accountStore requestAccessToAccountsWithType:accountType
           options:NULL
        completion:^(BOOL granted, NSError *error) {
            if (granted) {
                // Create a request
                NSArray *accounts = [self.accountStore accountsWithAccountType:accountType];
                SLRequest *request = [SLRequest requestForServiceType:serviceTypeString
                                                        requestMethod:SLRequestMethodPOST
                                                                  URL:_requestURL
                                                           parameters:_params];
                // Attach account to request
                [request setAccount:[accounts lastObject]];
                // Execute request
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    if (responseData) {
                        if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                            NSError *jsonError;
                            NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                         options:NSJSONReadingAllowFragments
                                                                                           error:&jsonError];
                            if (responseBody) {
                                NSLog(@"%@", responseBody);
                            } else {
                                NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                            }
                        } else {
                            // Request failed
                            NSLog(@"Status code: %d", urlResponse.statusCode);
                        }
                    }
                }];
            } else {
                // Access refused
                NSLog(@"Access refused. %@", [error localizedDescription]);
            }
        }];
    }
}

@end
