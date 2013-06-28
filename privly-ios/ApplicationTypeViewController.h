//
//  ApplicationTypeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "ApplicationTypeViewController.h"
#import "PlainPostDestinationViewController.h"
#import "TestPostViewController.h"

@interface ApplicationTypeViewController : UIViewController

- (IBAction)createPlainPost:(id)sender;
- (IBAction)createZeroBinPost:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)createTestPost:(id)sender;

@end
