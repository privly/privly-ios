//
//  ContentServerViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface ContentServerViewController : UIViewController
/*
 * Content Server is set in this view and passed to 
 * the JavaScript app when the user wants to create a post.
 */

@property (weak, nonatomic) IBOutlet UILabel *currentContentServerLabel;
@property (weak, nonatomic) IBOutlet UITextField *customContentServerTextField;

- (IBAction)dismissContentServerViewController:(id)sender;
- (IBAction)setContentServer:(id)sender;

@end
