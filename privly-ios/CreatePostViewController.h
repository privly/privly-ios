//
//  TestPostViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

/**
 * View controller that loads the posting application in a web view.
 * It also receives requests sent by the posting application, but
 * the only request it expects is the generated privly link.
 */

@interface CreatePostViewController : UIViewController <UIWebViewDelegate>

/** UIWebView that loads the JavaScript posting applications */
@property (weak, nonatomic) IBOutlet UIWebView *testPostWebView;
/** Property used to determine post type. */
@property (nonatomic) NSString *postType;
@property (nonatomic) UIViewController *applicationTypeViewController;

@end
