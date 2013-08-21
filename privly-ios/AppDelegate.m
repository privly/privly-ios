//
//  AppDelegate.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ApplicationTypeViewController.h"
#import "InitViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *authToken = [userDefaults valueForKey:@"auth_token"];
    NSLog(@"Authentication Token: %@", authToken);
    // Check authToken validity with server. Must be async.
    // Assumes authToken is always valid for now.
    if (authToken) {
        // Check that auth_token is valid
        NSString *contentServerString = [userDefaults valueForKey:@"content_server"];
        NSString *stringURL = [NSString stringWithFormat:@"%@/token_authentications.json", contentServerString];
        NSURL *requestURL = [NSURL URLWithString:stringURL];
        NSMutableURLRequest *mutableURLRequest = [NSMutableURLRequest requestWithURL:requestURL];
        
        [mutableURLRequest setHTTPMethod:@"GET"];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:mutableURLRequest queue:queue completionHandler:^(NSURLResponse *response,
                                                                                                   NSData *data,
                                                                                                   NSError *error) {
            if ([data length] > 0 && error == nil) {
                // If successful request, deserialize JSON response and get authentication key
                id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if (jsonResponse != nil && error == nil) {
                    NSLog(@"Response to auth_token verification: %@", jsonResponse);
                    // If valid, load application type view controller directly
                    [self skipLogin];
                }
            } else if ([data length] == 0 && error == nil) {
                NSLog(@"Success, no response.");
                [self login];
            } else if (error != nil) {
                NSLog(@"Couldn't validate authentication token.");
                [self login];
            }
        }];
    } else {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        nav = [[CustomNavigationViewController alloc] initWithRootViewController:loginViewController];
        [self.window setRootViewController:nav];
        [self.window makeKeyAndVisible];
        return YES;
    }
    
    InitViewController *initViewController = [[InitViewController alloc] init];
    nav = [[CustomNavigationViewController alloc] initWithRootViewController:initViewController];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)login {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [nav pushViewController:loginViewController animated:YES];
}

- (void)skipLogin {
    ApplicationTypeViewController *applicationTypeViewController = [[ApplicationTypeViewController alloc] init];
    [nav pushViewController:applicationTypeViewController animated:YES];
}

@end
