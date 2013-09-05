//
//  PostTypeViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface PostTypeViewController : UITableViewController

/**
 * The different post types are hard-coded in an ivar array,
 * and refered to in the cellForRowAtIndexPath and didSelectRowAtIndexPath methods.
 */
@property (nonatomic) NSArray *postTypes;

@end
