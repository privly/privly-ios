//
//  TestPostViewController.h
//  privly-ios
//
//  Created by Hery Ratsimihah on 6/5/13.
//  Copyright (c) 2013 Hery Ratsimihah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestPostViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *testPostWebView;
- (IBAction)loadThatJS:(id)sender;

@end
