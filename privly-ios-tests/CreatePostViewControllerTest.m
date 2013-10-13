//
//  CreatePostViewControllerTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "CreatePostViewControllerTest.h"
#import "PlainPostDestinationViewController.h"

@implementation CreatePostViewControllerTest

- (void)setUp
{
    [super setUp];
    appDelegate = [[UIApplication sharedApplication] delegate];
    createPostViewController = [[CreatePostViewController alloc] init];
    createPostViewController.postType = @"PlainPost";
    [appDelegate.nav pushViewController:createPostViewController animated:NO];
}

- (void)tearDown
{
    appDelegate = nil;
    createPostViewController = nil;
    [super tearDown];
}

- (void)testRequestHandler
{
    // Send a request containing a link that should be shared.
    // Verify that the proper view controller (PlainPostDestinationViewController) is pushed.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"js-frame:http://domain.com"]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:60];
    [createPostViewController webView:createPostViewController.testPostWebView
           shouldStartLoadWithRequest:request
                       navigationType:UIWebViewNavigationTypeOther];
    STAssertEquals([appDelegate.nav.topViewController class], [PlainPostDestinationViewController class],
                   @"A PlainPostDestinationViewController could not be pushed.");
}

@end
