//
//  ContentServerViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

/**
 * The Content Server view controller is a modal view controller that lets
 * users set their content server, which is then passed to
 * the JavaScript posting application when users wants to create a post.
 */

@interface ContentServerViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentContentServerLabel;
/**
 * customContentServerTextField is strong because 
 * it needs to be retained in the test.
 */
@property (strong, nonatomic) IBOutlet UITextField *customContentServerTextField;

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
