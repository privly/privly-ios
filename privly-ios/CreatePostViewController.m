//
//  TestPostViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "CreatePostViewController.h"
#import "PlainPostDestinationViewController.h"

@interface CreatePostViewController ()

@end

@implementation CreatePostViewController

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
    /**
     * The appropriate posting application is loaded based
     * on the postType property.
     */
    [super viewDidLoad];
    self.testPostWebView.delegate = self;
    NSBundle *main = [NSBundle mainBundle];
    NSString *directoryName = [NSString stringWithFormat:@"privly-applications/%@", _postType];
    NSString *urlStringForHTML = [main pathForResource:@"new" ofType:@".html" inDirectory:directoryName];
    // Encode string using Core Foundation String
    NSString *escapedURLString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)urlStringForHTML,
                                                                                                    NULL,
                                                                                                    CFSTR(":?#[]@!$&’()*+,;="), 
                                                                                                    kCFStringEncodingUTF8));
    NSURL *urlRequestForHTML = [NSURL URLWithString:escapedURLString];    
    [self.testPostWebView loadRequest:[NSURLRequest requestWithURL:urlRequestForHTML]];
    NSLog(@"Request URL: %@", urlRequestForHTML);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /**
     * If it's a js-frame request, it was sent by a privly-application, 
     * so get the Privly link and share it. Otherwise, load request.
     */
    NSString *URLString = [NSString stringWithFormat:@"%@", [request URL]];
    NSRange jsFrameRange = [URLString rangeOfString:@"js-frame"];
    if (jsFrameRange.length > 0) {
        // Request was sent by a privly-application
        // Get link and pass it to a PlainPostDestination ViewController.
        // Do not load the request.
        NSString *privlyLink = [URLString substringFromIndex:jsFrameRange.length+1];
        PlainPostDestinationViewController *dest = [[PlainPostDestinationViewController alloc] init];
        dest.applicationTypeViewController = self.applicationTypeViewController;
        dest.link = privlyLink;
        [self.navigationController pushViewController:dest
                                             animated:YES];
    } else {
        // Not a js-frame request, so load it.
        return YES;
    }
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView                               
{
    /**
     * Send authentication token and posting content server
     * to webView once the web view is done loading.
     */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *auth_token = [userDefaults objectForKey:@"auth_token"];
    NSString *content_server= [userDefaults objectForKey:@"content_server"];
    auth_token = [NSString stringWithFormat:@"privlyNetworkService.setAuthTokenString('%@');", auth_token];
    content_server = [NSString stringWithFormat:@"localStorage[\"posting_content_server_url\"] = \"%@\";", content_server];
    NSLog(@"Calling %@ function", auth_token);
    [_testPostWebView stringByEvaluatingJavaScriptFromString:auth_token];
    NSLog(@"Calling %@ function", content_server);
    [_testPostWebView stringByEvaluatingJavaScriptFromString:content_server];
}

@end
