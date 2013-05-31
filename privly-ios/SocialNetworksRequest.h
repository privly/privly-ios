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

@property (nonatomic) UIViewController *delegate;
@property (nonatomic) NSString *postContent;

- (void)setupAccountForServiceTypeInt:(int)serviceTypeInt;
- (void)postMessage;

@end
