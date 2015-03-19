//
//  AppDelegate.m
//  Facade Tester
//
//  Created by loi on 3/19/15.
//  Copyright (c) 2015 GWrabbit. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherViewController.h"
#import "StockViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *weatherVC = [[UINavigationController alloc] initWithRootViewController:[[WeatherViewController alloc] init]];
    UIViewController *stockVC = [[UINavigationController alloc] initWithRootViewController:[[StockViewController alloc] init]];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:weatherVC, stockVC, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)loadServiceLocator {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://devbak.bayequest.com/loi/net/2/serviceLocator.json"] options:NSDataReadingUncached error:&error];
    });
}

- (NSURL *)findURLForServiceNamed:(NSString *)serviceName version:(NSInteger)versionNumber inDictionary:(NSDictionary *)locatorDIctionary {
    NSArray *services = [locatorDIctionary objectForKey:@"services"];
    
    for (NSDictionary *serviceInfo in services) {
        NSString *name = [serviceInfo objectForKey:@"name"];
        NSInteger version = [[serviceInfo objectForKey:@"version"] intValue];
        
        if ([name caseInsensitiveCompare:serviceName] == NSOrderedSame && version == versionNumber) {
            return [NSURL URLWithString:[serviceInfo objectForKey:@"url"]];
        }
    }
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
