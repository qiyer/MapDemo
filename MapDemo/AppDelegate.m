//
//  AppDelegate.m
//  MapDemo
//。。。。。
//  Copyright © 2016年 qiye. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MapViewController * mapView = [[MapViewController alloc]init];
    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:mapView];
    self.window.rootViewController = navigation;
    
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


@end
