//
//  LoginViewControllerTests.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "LoginViewControllerTests.h"
#import "LoginViewController.h"

@implementation LoginViewControllerTests

- (void)setUp
{
    [super setUp];
    NSLog(@"%@ setUp", self.name);
    loginViewController = [[LoginViewController alloc] init];
}

- (void)tearDown
{
    NSLog(@"%@ tearDown", self.name);
    loginViewController = nil;
    [super tearDown];
}

- (void)testTitle
{
    STAssertTrue([loginViewController.title isEqual:@"Login"], @"Title is not set.");
}

- (void)testTextFieldsDelegate
{
    NSLog(@"%@ start", self.name);
    [loginViewController view];
    STAssertTrue([loginViewController.emailTextField.delegate isEqual:loginViewController] , @"Email TextField's delegate not set.");
    STAssertTrue([loginViewController.passwordTextField.delegate isEqual:loginViewController] , @"Password Textfield's delegate not set.");
    NSLog(@"%@ end", self.name);
}

- (void)testFirstResponder
{
    [loginViewController textFieldShouldReturn:loginViewController.emailTextField];
    STAssertFalse([loginViewController.emailTextField isFirstResponder], @"Textfield is still first responder.");
}

- (void)testAuthentication
{
    STFail(@"Authentication request is not tested.");
}

@end
