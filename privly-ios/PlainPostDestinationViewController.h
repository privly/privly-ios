//
//  PlainPostDestinationViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "PlainPostViewController.h"

@interface PlainPostDestinationViewController : UITableViewController {
    NSArray *availableServices;
}

@property (nonatomic) NSString *link;

@end
