//
//  AppDelegate.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/8.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeTaberViewController.h"
#import "IQKeyboardManager.h"
#import <CoreLocation/CoreLocation.h>
#import "OutLinkViewController.h"
#import "MMBaseNavigationController.h"
#import "MJJFristViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"玩的来_____药药～～切克闹" message:@"你可以随便问我问题，我会告诉你回答这个问题的你所需要做的，我也可以选择不回答" delegate:self cancelButtonTitle:@"回答" otherButtonTitles:@"不回答", nil];
    [alertview show];
    //请求获取位置服务
    CLLocationManager *location=[[CLLocationManager alloc]init];
    
    [location requestAlwaysAuthorization];
    
    //设置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [HomeTaberViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIViewController *controller = [(UINavigationController *)[(UITabBarController *)[[UIApplication sharedApplication] keyWindow].rootViewController selectedViewController] visibleViewController];
    if([controller isKindOfClass:[OutLinkViewController class]]||[controller isKindOfClass:[HomeTaberViewController class]]){
        HomeTaberViewController *home=[[HomeTaberViewController alloc]init];
        [controller.navigationController pushViewController:home animated:NO];
    }
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
