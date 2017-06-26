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
#import "Constants.h"
#import <Leanplum/Leanplum.h>
#import "Configure.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLeanplum];
    return YES;
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

@end
