//
//  PlainPostDestinationViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface PlainPostDestinationViewController : UITableViewController {
    NSArray *availableServices;
}

/** Property used to pass the link from the previous view to the next view. */
@property (nonatomic) NSString *link;

@end
