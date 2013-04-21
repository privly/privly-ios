//
//  LoginViewController.h
//  privly-ios
//
//  Created by devplayerx on 4/21/13.
//  Copyright (c) 2013 Hery Ratsimihah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *authenticationTokenLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)getToken:(id)sender;
-(NSString *)urlEncodeString:(NSString *)thisString
               UsingEncoding:(NSStringEncoding)encoding;

@end
