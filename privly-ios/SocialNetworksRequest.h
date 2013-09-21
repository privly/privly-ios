//
//  SocialNetworksRequest.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "ReadingModeViewController.h"

@interface SocialNetworksRequest : NSObject

/** Property container holding the social network accounts. */
@property (nonatomic) ACAccountStore *accountStore;

/** Property used to store the serviceType (e.g: Facebook, Twitter) */
@property (nonatomic) NSString *serviceTypeString;

/** Property used to store the user's account identifier. */
@property (nonatomic) NSString *accountIdentifierString;

/** Property used to show and dismiss alert views */
@property (nonatomic) UIViewController *delegate;

/** Property used to store the link to be passed to the SLComposeViewController. */
@property (nonatomic) NSString *link;

/** Property holding the return view controllerp pushed when a user
 is done sharing a post. */
@property (nonatomic) UIViewController *returnViewController;

/** Property holding a list of URL to display */
@property (nonatomic) NSMutableArray *URLList;


/** Facebook API properties **/
@property (nonatomic) NSString *facebookAppID;
@property (nonatomic) NSArray *facebookPermissions;
@property (nonatomic) NSDictionary *facebookOptions;

/** 
  * Sets the service type based on integer parameter,
  * which is useful when used with a table view.
  */
- (void)setupAccountForServiceTypeInt:(int)serviceTypeInt;

/** Verifies that user has access to the appropriate service. */
- (BOOL)userHasAccessToService;

/** Creates a SLComposeViewController that posts a message containing
  * the post's link to the appropriate service.
  */
- (void)postMessage;

/** Download a user's posts for the appropriate service. */
- (void)getPostsWithCompletionHandler:(void (^)(NSString *tweet))completionHandler;

    
@end
