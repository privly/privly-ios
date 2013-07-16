//
//  TestPostViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "TestPostViewController.h"

@interface TestPostViewController ()

@end

@implementation TestPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"New Post";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.testPostWebView.delegate = self;
    NSBundle *main = [NSBundle mainBundle];
    NSString *urlStringForHTML = [main pathForResource:@"new" ofType:@".html" inDirectory:@"privly-applications/PlainPost"];
    // Encode string using Core Foundation String
    NSString *escapedURLString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)urlStringForHTML,
                                                                                                    NULL,
                                                                                                    CFSTR(":?#[]@!$&’()*+,;="), 
                                                                                                    kCFStringEncodingUTF8));
    NSURL *urlRequestForHTML = [NSURL URLWithString:escapedURLString];    
    [self.testPostWebView loadRequest:[NSURLRequest requestWithURL:urlRequestForHTML]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Request URL: %@", [[request URL] absoluteString]);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView                               
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *auth_token = [userDefaults objectForKey:@"auth_token"];
    auth_token = [NSString stringWithFormat:@"privlyNetworkService.setAuthTokenString('%@');", auth_token];
    NSLog(@"Calling %@ function", auth_token);
    [_testPostWebView stringByEvaluatingJavaScriptFromString:auth_token];
}

@end
