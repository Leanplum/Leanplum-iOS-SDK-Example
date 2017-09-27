//
//  AppDelegate.m
//  no-arc
//
//  Created by Ben Marten on 9/27/17.
//  Copyright © 2017 BenMarten. All rights reserved.
//

#import "AppDelegate.h"
#import "Leanplum/Leanplum.h"
#import "LPMessageTemplates.h"

@interface AppDelegate ()

@property NSString *firstName;
@property NSString *lastName;

@end

@implementation AppDelegate

#if __has_feature(objc_arc)
#error This should be non-arc
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.firstName = @"first";
    self.lastName = @"last";
    
    // Override point for customization after application launch.
    [Leanplum setAppId:@"app_BWTRIgOs0OoevDfSsBtabRiGffu5wOFU3mkxIxA7NBs" withDevelopmentKey:@"dev_Bx8i3Bbz1OJBTBAu63NIifr3UwWqUBU5OhHtywo58RY"];
    [LPMessageTemplates sharedTemplates];
    [Leanplum start];
    
    NSString *string = [[NSString alloc] initWithFormat:@"%@ %@", self.firstName, self.lastName];
    NSLog(@"%@", string);
    [Leanplum track:string];
    [string release];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
