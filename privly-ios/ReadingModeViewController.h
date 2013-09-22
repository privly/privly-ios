//
//  ReadingModeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@class SocialNetworksRequest;

@interface ReadingModeViewController : UITableViewController {
    /** SocialNetworkRequest instance dealing with social networks network operations. */
    SocialNetworksRequest *snHelper;
}

/** Array holding a hard-coded list of URLs used by the reading application. */
@property (nonatomic) NSArray *URLListArray;
@property (nonatomic) NSMutableSet *URLList;

@end
