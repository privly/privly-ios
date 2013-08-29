//
//  SocialNetworksRequest.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface SocialNetworksRequest : NSObject

/** Property used to store the serviceType (e.g: Facebook, Twitter) */
@property (nonatomic) NSString *serviceTypeString;
/** Property used to store the user's account identifier. */
@property (nonatomic) NSString *accountIdentifierString;

@property (nonatomic) UIViewController *delegate;
/** Property used to store the link to be passed to the SLComposeViewController. */
@property (nonatomic) NSString *link;

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

@end
