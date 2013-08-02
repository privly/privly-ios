//
//  ApplicationTypeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "ApplicationTypeViewController.h"
#import "PlainPostDestinationViewController.h"
#import "CreatePostViewController.h"

@interface ApplicationTypeViewController : UIViewController

/** Action to load web view to create new posts. */
- (IBAction)createPost:(id)sender;

/** Action to logout. */
- (IBAction)logout:(id)sender;

/** Action to switch to reading mode. */
- (IBAction)readingMode:(id)sender;

/** Action to change posting content server. */
- (IBAction)contentServer:(id)sender;

@end
