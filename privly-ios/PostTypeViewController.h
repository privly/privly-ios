//
//  PostTypeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

/**
 * The different post types are hard-coded in an ivar array,
 * and refered to in the cellForRowAtIndexPath and didSelectRowAtIndexPath methods.
 * Additional application types should be added to the *postTypes array.
 */

@interface PostTypeViewController : UITableViewController

@property (nonatomic) NSArray *postTypes;
@property (nonatomic) NSArray *postDescription;
@property (nonatomic) UIViewController *applicationTypeViewController;

@end