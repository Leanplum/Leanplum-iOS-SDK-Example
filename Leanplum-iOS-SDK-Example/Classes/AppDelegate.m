//
//  AppDelegate.m
//  Leanplum-iOS-SDK-Example
//  Copyright © 2017 Leanplum.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//      http://www.apache.org/licenses/LICENSE-2.0
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "AppDelegate.h"
#import <Leanplum/Leanplum.h>
#import "Configure.h"
#import "LeanplumExampleTestNotification.h"

@interface AppDelegate ()

@property NSURLSession *session;
@property LeanplumExampleTestNotification *notification;
@property (nonatomic, copy) void (^completionHandler)(UIBackgroundFetchResult fetchResult);

@end

@implementation AppDelegate

static NSString *POST_URL = @"insert proxy url";

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSString *messageTitle = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    NSString *uuid = [userInfo objectForKey:@"uuid"];
    NSString *os = [userInfo objectForKey:@"os"];
    NSString *action = [userInfo objectForKey:@"action"];
    NSString *openActionType = [[userInfo objectForKey:@"_lpx"] objectForKey:@"__name__"] ?:
    [NSNull null];
    NSString *openActionUrl = [[userInfo objectForKey:@"_lpx"] objectForKey:@"URL"] ?:
    [NSNull null];
    
    NSLog(@"Push Notification received.\nTitle: '%@'\nOS: '%@'\nAction: ",
          messageTitle, action);
    
    if (messageTitle == nil || action == nil) {
        completionHandler(UIBackgroundFetchResultNoData);
        return;
    }
    
    LeanplumExampleTestNotification *notification = [[LeanplumExampleTestNotification alloc] initWithAction:action
                                               messageTitle:messageTitle
                                                os:os
                                                uuid:uuid
                                             openActionType:openActionType
                                              openActionUrl:openActionUrl];
    completionHandler = completionHandler;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification"
                                                        object: notification];
    
    [self postNotificationReceipt:notification];
}

- (void)postNotificationReceipt:(LeanplumExampleTestNotification *)notification
{
    NSError *error;
    
    NSLog(@"Posting to server...");
    
    NSURL *url = [NSURL URLWithString:POST_URL];
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:url
                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                        timeoutInterval:20.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    NSDictionary *mapData =
    @{ @"action" : notification.action,
       @"messageTitle" : notification.messageTitle,
       @"os" : notification.os,
       @"uuid" : notification.uuid,
       @"openActionType" : notification.openActionType,
       @"openActionUrl" : notification.openActionUrl };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    }];
    
    [postDataTask resume];



}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)configureLeanplum {
    // warning: Only used for testing purposes, do not use in production.
    [Leanplum setApiHostName:LP_API_HOST_NAME withServletName:@"api" usingSsl:LP_API_SSL];
    
    #ifdef DEBUG
        [Leanplum setAppId:LP_APP_ID withDevelopmentKey:LP_DEVELOPMENT_KEY];
    #else
        [Leanplum setAppId:LP_APP_ID withProductionKey:LP_PRODUCTION_KEY];
    #endif
    [Leanplum trackAllAppScreens];
    [Leanplum start];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLeanplum];
    [self registerForPushNotifications:application];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                            settingsForTypes:UIUserNotificationTypeAlert |
                                            UIUserNotificationTypeBadge |
                                            UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    return YES;
}

- (void) registerForPushNotifications:(UIApplication *)application {
    id notificationCenterClass = NSClassFromString(@"UNUserNotificationCenter");
    if (notificationCenterClass) {
        // iOS 10.
        SEL selector = NSSelectorFromString(@"currentNotificationCenter");
        id notificationCenter =
        ((id (*)(id, SEL)) [notificationCenterClass methodForSelector:selector])
        (notificationCenterClass, selector);
        if (notificationCenter) {
            selector = NSSelectorFromString(@"requestAuthorizationWithOptions:completionHandler:");
            IMP method = [notificationCenter methodForSelector:selector];
            void (*func)(id, SEL, unsigned long long, void (^)(BOOL, NSError *__nullable)) =
            (void *) method;
            func(notificationCenter, selector,
                 0b111, /* badges, sounds, alerts */
                 ^(BOOL granted, NSError *__nullable error) {
                     if (error) {
                         NSLog(@"Leanplum: Failed to request authorization for user "
                               "notifications: %@", error);
                     }
                 });
        }
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else if ([[UIApplication sharedApplication] respondsToSelector:
                @selector(registerUserNotificationSettings:)]) {
        // iOS 8-9.
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:UIUserNotificationTypeAlert |
                                                UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        // iOS 7 and below.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
#pragma clang diagnostic pop
         UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge];
    }
}

@end
