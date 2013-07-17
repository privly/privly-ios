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

/**
 * Dismisses modal view controller.
 */
- (IBAction)dismissContentServerViewController:(id)sender;
/**
 * If the button's title is Update, set the content server
 * as the value of the Custom TextField if not empty.
 * Else, set the value of one of the default buttons.
 * Content Server is saved in user preferences.
 */
- (IBAction)setContentServer:(id)sender;

@end
