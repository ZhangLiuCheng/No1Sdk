 //
//  AppDelegate.m
//  No1SdkDemo
//
//  Created by 张留成 on 2022/6/17.
//

#import "AppDelegate.h"
#import "SdkDemoController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SdkDemoController *rootViewController = [[SdkDemoController alloc] initWithNibName:@"SdkDemoController" bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
