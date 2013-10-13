//
//  PostReadingViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

/**
 * View controller that loads the 
 * reading application in a web view.
 */

@interface PostReadingViewController : UIViewController <UIWebViewDelegate>

/** UIWebView that loads the reading application. */
@property (weak, nonatomic) IBOutlet UIWebView *readingAppWebView;

@property (nonatomic) NSString *applicationURL;

@end
