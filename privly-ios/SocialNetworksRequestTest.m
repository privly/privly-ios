//
//  SocialNetworksRequestTest.m
//  privly-ios
//  Copyright 2013 The Privly Foundation.
//

#import "SocialNetworksRequestTest.h"
#import "SocialNetworksRequest.h"

#import <Social/Social.h>

@implementation SocialNetworksRequestTest

- (void)setUp
{
    socialNetworkRequest = [[SocialNetworksRequest alloc] init];
    delegate = [[UIViewController alloc] init];
    socialNetworkRequest.delegate = delegate;
}

- (void)tearDown
{
    socialNetworkRequest = nil;
    delegate = nil;
}

- (void)testSetupAccountForServiceTypeInt
{
    [socialNetworkRequest setupAccountForServiceTypeInt:0];
    STAssertEqualObjects(socialNetworkRequest.serviceTypeString, SLServiceTypeFacebook,
                         @"Account service type is not set properly.");
    [socialNetworkRequest setupAccountForServiceTypeInt:1];
    STAssertEqualObjects(socialNetworkRequest.serviceTypeString, SLServiceTypeTwitter,
                         @"Account service type is not set properly.");
}

- (void)testUserHasAccessToService
{
    socialNetworkRequest.serviceTypeString = SLServiceTypeFacebook;
    STAssertTrue([socialNetworkRequest userHasAccessToService] == [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook],
                 @"Can't verify access to Facebook account.");
    socialNetworkRequest.serviceTypeString = SLServiceTypeTwitter;
    STAssertTrue([socialNetworkRequest userHasAccessToService] == [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter],
                 @"Can't verify access to Twitter account.");
}

@end
