//
//  ZeroBinPostViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ZeroBinPostViewController.h"

@interface ZeroBinPostViewController ()

@end

@implementation ZeroBinPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"ZeroBin";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // JavaScript code to be loaded here.
    // See https://github.com/hery/PrivlyJavaScriptSandbox
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
