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
}

- (void)tearDown
{
    socialNetworkRequest = nil;
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

- (void)testPostMessage
{
//    NSString *testString = @"This is a test string.";
//    socialNetworkRequest.postContent = testString;
//    socialNetworkRequest.serviceTypeString = SLServiceTypeFacebook;
//    [socialNetworkRequest postMessage];
//    STAssertTrue(socialNetworkRequest.postContent == testString, @"Couldn't set post content.");
//    NSLog(@"Prout: %@", [socialNetworkRequest.delegate.presentedViewController class]);
//    STAssertTrue([socialNetworkRequest.delegate.presentedViewController isKindOfClass:[SLComposeViewController class]],
//                 @"SLComposeViewController couldn't be presented.");
}

@end
