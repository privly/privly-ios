//
//  ReadingModeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

/**
 * View controller that displays the list of privly URLs
 * fetched from external sources.
 * It currently supports Facebook and Twitter, but was implemented
 * to ease integration of additional services.
 */

@class SocialNetworksRequest;

@interface ReadingModeViewController : UITableViewController {
    /** SocialNetworkRequest instance dealing with social networks network operations. */
    SocialNetworksRequest *snHelper;
}

/** Array holding a hard-coded list of URLs used by the reading application. */
@property (nonatomic) NSArray *URLListArray;
@property (nonatomic) NSMutableSet *URLList;

@end
