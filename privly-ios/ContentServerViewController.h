//
//  ContentServerViewController.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <UIKit/UIKit.h>

@interface ContentServerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentContentServerLabel;

- (IBAction)dismissContentServerViewController:(id)sender;
- (IBAction)setContentServer:(id)sender;

@end
