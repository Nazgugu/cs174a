//
//  AppDelegate.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "PatientViewController.h"
#import "DoctorViewController.h"
#import "AdminViewController.h"
#import "settingViewViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loginSuccess"])
    {
        [self presentTabel];
    }
    else
    {
        [self goToLogin];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loginSuccess"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}

- (void)goToLogin
{
    NSLog(@"login");
    LoginViewController *login = [[LoginViewController alloc] init];
    self.window.rootViewController = login;
    [self.window makeKeyAndVisible];
}

- (void)presentTabel
{
    TabBarViewController *tab = [[TabBarViewController alloc] init];
    PatientViewController *patientController  = [[PatientViewController alloc] init];
    UINavigationController  *nav1 = [[UINavigationController alloc] initWithRootViewController:patientController];
    nav1.tabBarItem.title = @"Patient";
    DoctorViewController *doctorController = [[DoctorViewController alloc] init];
    UINavigationController  *nav2 = [[UINavigationController alloc] initWithRootViewController:doctorController];
    nav2.tabBarItem.title = @"Doctor";
    AdminViewController *adminController = [[AdminViewController alloc] init];
    UINavigationController  *nav3 = [[UINavigationController alloc] initWithRootViewController:adminController];
    nav3.tabBarItem.title = @"Administrator";
    settingViewViewController *settingControll = [[settingViewViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:settingControll];
    nav4.tabBarItem.title = @"Setting";
    tab.viewControllers = @[nav1,nav2,nav3,nav4];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
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
