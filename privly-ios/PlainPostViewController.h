//
//  PlainPostViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>
#import "SocialNetworksRequest.h"

@interface PlainPostViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *PlainPostContent;
@property (strong, nonatomic) UIBarButtonItem *dismissKeyboardButton;
@property (nonatomic) int socialNetworkId;

- (IBAction)createPlainPost:(id)sender;

@end
