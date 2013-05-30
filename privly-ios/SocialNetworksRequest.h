//
//  SocialNetworksRequest.h
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface SocialNetworksRequest : NSObject {
    NSString* serviceTypeString;
    NSString* accountIdentifierString;
}

@property (nonatomic) ACAccountStore *accountStore;
@property (nonatomic) NSURL *requestURL;
@property (nonatomic) NSDictionary *params;

- (id) initWithURL:(NSURL *)requestURL params:(NSDictionary *)params;
- (void)setupAccountForServiceTypeInt:(int)serviceTypeInt;
- (void)postMessage;

@end
