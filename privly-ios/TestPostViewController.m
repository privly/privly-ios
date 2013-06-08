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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.testPostWebView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    [self.testPostWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"simpleApp"
                                                                                                                      ofType:@"html"]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
   
}

- (IBAction)loadThatJS:(id)sender {
    NSString *jSFunction = @"makeCorsRequest();";
    NSString *url = [self.testPostWebView stringByEvaluatingJavaScriptFromString:jSFunction];
    NSLog(@"%@", @"CORS request sent.");
}
@end
