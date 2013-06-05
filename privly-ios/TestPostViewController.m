//
//  TestPostViewController.m
//  privly-ios
//
//  Created by Hery Ratsimihah on 6/5/13.
//  Copyright (c) 2013 Hery Ratsimihah. All rights reserved.
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
    NSString *jSFunction = @"getURL();";
    NSString *url = [self.testPostWebView stringByEvaluatingJavaScriptFromString:jSFunction];
    NSLog(@"JS URL is: %@", url);
}
@end
