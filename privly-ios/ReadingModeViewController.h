//
//  ReadingModeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "SocialNetworksRequest.h"

@interface ReadingModeViewController : UITableViewController {
    /** Array holding a hard-coded list of URLs used by the reading application. */
    NSArray *URLList;
    
    /** SocialNetworkRequest instance dealing with social networks network operations. */
    SocialNetworksRequest *snHelper;
}

@end
