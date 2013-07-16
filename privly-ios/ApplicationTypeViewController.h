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

- (IBAction)createPost:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)readingMode:(id)sender;
- (IBAction)contentServer:(id)sender;

@end
