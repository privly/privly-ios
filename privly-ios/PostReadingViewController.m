//
//  PostReadingViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "PostReadingViewController.h"

@interface PostReadingViewController ()

@end

@implementation PostReadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Reading";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.readingAppWebView.delegate = self;
    NSBundle *main = [NSBundle mainBundle];
    NSString *urlStringForHTML = [main pathForResource:@"show" ofType:@".html" inDirectory:@"privly-applications/PlainPost/"];
    // Encode string using Core Foundation String
    NSString *escapedURLString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                       (CFStringRef)urlStringForHTML,
                                                                                                       NULL,
                                                                                                       CFSTR(":?#[]@!$&’()*+,;="),
                                                                                                       kCFStringEncodingUTF8));
    escapedURLString = [escapedURLString stringByAppendingFormat:@"?privlyOriginalURL=%@", _applicationURL];
    NSURL *urlRequestForHTML = [NSURL URLWithString:escapedURLString];
    [self.readingAppWebView loadRequest:[NSURLRequest requestWithURL:urlRequestForHTML]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
