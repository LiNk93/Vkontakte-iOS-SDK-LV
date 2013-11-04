//
//  ASAAppDelegate.m
//  Project
//
//  Created by AndrewShmig on 6/28/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import "ASAAppDelegate.h"
#import "ASAViewController.h"


static NSString *const kVKAppID = @"3974432";
//static NSString *const kVKAppID = @"3541027";
static NSString *const kVKPermissionsArray = @"photos,friends,wall,audio,video,docs,notes,pages,status,groups,messages";


@implementation ASAAppDelegate

- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]
                             initWithFrame:[[UIScreen mainScreen] bounds]];

    [[VKConnector sharedInstance] startWithAppID:kVKAppID
                                      permissons:[kVKPermissionsArray componentsSeparatedByString:@","]
                                        delegate:self];

    // Override point for customization after application launch.
    self.viewController = [[ASAViewController alloc]
                                              initWithNibName:@"ASAViewController"
                                                       bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)VKConnector:(VKConnector *)connector
  willShowModalView:(VKModal *)view
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)VKConnector:(VKConnector *)connector
  willHideModalView:(VKModal *)view
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)   VKConnector:(VKConnector *)connector
accessTokenInvalidated:(VKAccessToken *)accessToken
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)     VKConnector:(VKConnector *)connector
accessTokenRenewalFailed:(VKAccessToken *)accessToken
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)        VKConnector:(VKConnector *)connector
accessTokenRenewalSucceeded:(VKAccessToken *)accessToken
{
    NSLog(@"%s", __FUNCTION__);

    NSLog(@"Access token: %@", accessToken);

    VKRequestManager *rm = [[VKRequestManager alloc]
                                              initWithDelegate:self
                                                          user:[VKUser currentUser]];

    [rm execute:@"return API.users.get({\"uids\":API.audio.search({\"q\":\"Beatles\",\"count\":3})@.owner_id})@.last_name;"];
}

- (void)   VKConnector:(VKConnector *)connector
connectionErrorOccured:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"CONNECTION error: %@", error);
}

- (void)VKConnector:(VKConnector *)connector
parsingErrorOccured:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"error: %@", error);
}

- (void)VKRequest:(VKRequest *)request
         response:(id)response
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"response: %@", response);
}

- (void)   VKRequest:(VKRequest *)request
responseErrorOccured:(id)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"error: %@", error);
}

- (void)VKRequest:(VKRequest *)request
       captchaSid:(NSString *)captchaSid
     captchaImage:(NSString *)captchaImage
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"captchaSid: %@", captchaSid);
    NSLog(@"captchaImage: %@", captchaImage);
}

- (void)  VKRequest:(VKRequest *)request
parsingErrorOccured:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", error);
}

- (void)     VKRequest:(VKRequest *)request
connectionErrorOccured:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", error);
}

- (void)VKRequest:(VKRequest *)request
       totalBytes:(NSUInteger)totalBytes
    uploadedBytes:(NSUInteger)uploadedBytes
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%d %d", totalBytes, uploadedBytes);
}

- (void)VKRequest:(VKRequest *)request
       totalBytes:(NSUInteger)totalBytes
  downloadedBytes:(NSUInteger)downloadedBytes
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%d %d", totalBytes, downloadedBytes);
}

- (void)  VKConnector:(VKConnector *)connector
applicationWasDeleted:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"Error: %@", error);
}

@end
