//
//  PlainPostViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface PlainPostViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *PlainPostContent;
@property (strong, nonatomic) UIBarButtonItem *dismissKeyboardButton;

- (IBAction)createPlainPost:(id)sender;

@end
