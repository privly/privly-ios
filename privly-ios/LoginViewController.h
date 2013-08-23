//
//  LoginViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "ApplicationTypeViewController.h"

/**
 * View controller that handles user authentication.
 */

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    CGPoint originalCenter;
}

/** Outlet for user email address textfield */
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
/** Outlet for user password textfield */
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *contentServerLabel;

/**
 * Parses username and password and fire authentication request.
 * @returns Stores authentication token in NSUserDefaults and returns
 */
- (IBAction)getToken:(id)sender;
- (IBAction)showContentServerViewController:(id)sender;

@end
