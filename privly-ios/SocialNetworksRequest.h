//
//  SocialNetworksRequest.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface SocialNetworksRequest : NSObject

@property (nonatomic) NSString *serviceTypeString;
@property (nonatomic) NSString *accountIdentifierString;

@property (nonatomic) UIViewController *delegate;
@property (nonatomic) NSString *postContent;

- (void)setupAccountForServiceTypeInt:(int)serviceTypeInt;
- (BOOL)userHasAccessToService;
- (void)postMessage;

@end
