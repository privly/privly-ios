//
//  LoginViewControllerTests.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//


#import <SenTestingKit/SenTestingKit.h>

@class LoginViewController;

@interface LoginViewControllerTests : SenTestCase <UITextFieldDelegate>
{
    LoginViewController *loginViewController;
}

@end
