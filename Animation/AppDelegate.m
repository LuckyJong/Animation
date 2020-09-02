//
//  AppDelegate.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/8/31.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "AppDelegate.h"

#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [RootViewController new];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
