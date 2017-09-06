//
//  AppDelegate.m
//  SortForOC
//
//  Created by zhangke on 15/10/15.
//  Copyright © 2015年 zhangke. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreSpotlight/CoreSpotlight.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


/**
 *  spotlight跳转处理
 *
 *  @param application        -
 *  @param userActivity       携带信息
 *  @param restorationHandler -
 *
 *  @return -
 */
-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    
    NSString *identifier = userActivity.userInfo[CSSearchableItemActivityIdentifier];
    NSLog(@"%@",identifier);
    
    return YES;
}

/**
 *  处理3D Touch进入的事件
 *
 *  @param application
 *  @param shortcutItem      点击的3D Touch标签（附带好多属性）
 *  @param completionHandler
 */
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    NSLog(@"%@",shortcutItem.type);
    /**
     *
     系统的几个 shortcutIcon
     typedef NS_ENUM(NSInteger, UIApplicationShortcutIconType) {
     UIApplicationShortcutIconTypeCompose,//编辑图标
     UIApplicationShortcutIconTypePlay,//播放
     UIApplicationShortcutIconTypePause,//暂停
     UIApplicationShortcutIconTypeAdd,//添加
     UIApplicationShortcutIconTypeLocation,//定位
     UIApplicationShortcutIconTypeSearch,//搜索
     UIApplicationShortcutIconTypeShare//分享
     } NS_ENUM_AVAILABLE_IOS(9_0);
     
     *
     */
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**
     *  如果是从3D Touch标签进入则返回NO，防止逻辑重复处理
     */
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey]) {
        return NO;
    }
    
    return YES;
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
