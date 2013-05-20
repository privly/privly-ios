//
//  ApplicationTypeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "ApplicationTypeViewController.h"
#import "ZeroBinPostViewController.h"
#import "PlainPostViewController.h"

@interface ApplicationTypeViewController : UIViewController

- (IBAction)createPlainPost:(id)sender;
- (IBAction)createZeroBinPost:(id)sender;
- (IBAction)logout:(id)sender;

@end
