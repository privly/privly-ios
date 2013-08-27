//
//  TestPostViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface CreatePostViewController : UIViewController <UIWebViewDelegate>

/** Web view for Privly JavaScript posting applications */
@property (weak, nonatomic) IBOutlet UIWebView *testPostWebView;
@property (nonatomic) NSString *postType;

@end
