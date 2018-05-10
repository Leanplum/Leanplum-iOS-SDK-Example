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
#import "LPNotification.h"

@interface AppDelegate ()

@property NSURLSession *session;
@property LPNotification *notification;
@property (nonatomic, copy) void (^completionHandler)(UIBackgroundFetchResult fetchResult);

@end

@implementation AppDelegate

static NSString *POST_URL = @"https://guarded-shore-40772.herokuapp.com/notification";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLeanplum];
    return YES;
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSString *messageTitle = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
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
    

    
    LPNotification *notification = [[LPNotification alloc] initWithAction:action
                                               messageTitle:messageTitle
                                             openActionType:openActionType
                                              openActionUrl:openActionUrl];
    completionHandler = completionHandler;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification"
                                                        object: notification];
    
    [self postNotificationReceipt:notification];
}

- (void)postNotificationReceipt:(LPNotification *)notification
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

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)notification
  completionHandler:(void (^)())completionHandler
{
    NSLog(@"Handle remote action %@", identifier);
    [Leanplum handleActionWithIdentifier:identifier
                   forRemoteNotification:notification
                       completionHandler:completionHandler];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler
{
    NSLog(@"Handle local action %@", identifier);
    [Leanplum handleActionWithIdentifier:identifier
                    forLocalNotification:notification
                       completionHandler:completionHandler];
}

@end
