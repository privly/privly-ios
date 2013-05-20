//
//  ApplicationTypeViewController.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "ApplicationTypeViewController.h"

@interface ApplicationTypeViewController ()

@end

@implementation ApplicationTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Post Type";
        
        UIBarButtonItem *readingMode = [[UIBarButtonItem alloc] initWithTitle:@"Read"
                                                                        style:UIBarButtonItemStylePlain target:self
                                                                       action:@selector(switchToReadingMode)];
        UINavigationItem *nav = self.navigationItem;
        [nav setRightBarButtonItem:readingMode];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPlainPost:(id)sender {
    PlainPostViewController *plainPostViewController = [[PlainPostViewController alloc] init];
    [self.navigationController pushViewController:plainPostViewController animated:YES];
}

- (IBAction)createZeroBinPost:(id)sender {
    ZeroBinPostViewController *zeroBinPostViewController = [[ZeroBinPostViewController alloc] init];
    [self.navigationController pushViewController:zeroBinPostViewController animated:YES];
}

- (IBAction)logout:(id)sender {
}

- (void)switchToReadingMode {
    UIAlertView *featureNotAvailableAlertView = [[UIAlertView alloc] initWithTitle:@"Feature Not Available"
                                                                           message:@"Reading capabilities will be added soon. "
                                                                          delegate:self cancelButtonTitle:@"Ok"
                                                                 otherButtonTitles:nil];
    [featureNotAvailableAlertView show];
    // Push reading mode view controller
}
@end
