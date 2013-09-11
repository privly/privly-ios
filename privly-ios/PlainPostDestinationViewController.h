//
//  PlainPostDestinationViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface PlainPostDestinationViewController : UITableViewController

/** Property used to pass the link from the previous view to the next view. */
@property (nonatomic) NSString *link;

@property (nonatomic) NSArray *availableServices;

@property (nonatomic) UIViewController *applicationTypeViewController;

@end
