//
//  TestPostViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface CreatePostViewController : UIViewController <UIWebViewDelegate>

/** UIWebView that loads the JavaScript posting applications */
@property (weak, nonatomic) IBOutlet UIWebView *testPostWebView;
/** Property used to determine post type. */
@property (nonatomic) NSString *postType;
@property (nonatomic) UIViewController *applicationTypeViewController;

@end
