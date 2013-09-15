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

@end
