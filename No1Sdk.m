//
//  WJSdk.m
//  ReactSdk
//
//  Created by 张留成 on 2022/4/9.
//

#import "No1Sdk.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTDevLoadingView.h>
#import "ReactSdkModule.h"

static const NSString *VERSION = @"1.3";

@interface No1Sdk ()

@property (nonatomic, weak) UIWindow *window;
@property (nonatomic, weak) id<No1ToThirdListener> no1ToThirdListener;
@property (nonatomic, assign) BOOL inited;
@property (nonatomic, assign) BOOL debug;
@property (nonatomic, strong) RCTRootView *reactView;

@end

@implementation No1Sdk

+ (instancetype)shareInstance {
    static No1Sdk *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     if (!sharedInstance) {
         sharedInstance = [[self alloc] init];
     }
    });
    return sharedInstance;
}

- (void) init:(UIWindow*) window no1ToThirdListener:(id) listener {
    [self init:window no1ToThirdListener:listener debug:TRUE];
}

- (void) init:(UIWindow*) window no1ToThirdListener:(id) listener debug:(BOOL) debug {
    self.window = window;
    self.no1ToThirdListener = listener;
    self.debug = debug;
    [self attachReactView];
}
- (void) destroy {
    self.inited = FALSE;
    [self detachReactView];
}

- (void) showReactView {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.reactView.frame = self.window.frame;
    });
}

- (void) hideReactView {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.reactView.frame = CGRectMake(0, 0, 0, 0);
    });
}

- (void) reloadReactView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self detachReactView];
        [self attachReactView];
    });
}

- (void) attachReactView {
    NSURL *jsCodeLocation;
    // 下载资源
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *rootPath = [pathArray firstObject];
    NSString *bundlePath = [NSString stringWithFormat:@"%@/ios_%@/index.ios.bundle", rootPath, VERSION];
    if ([[NSFileManager defaultManager] fileExistsAtPath: bundlePath]) {
        jsCodeLocation = [NSURL fileURLWithPath: bundlePath];
    }
    // 本地资源
    if (!jsCodeLocation) {
        jsCodeLocation = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"bundle/index.ios.bundle" ofType:nil]];
    }
    NSLog(@"jsCodeLocation=%@", jsCodeLocation);
    NSDictionary * params = @{@"debug": @(self.debug)};
    self.reactView = [[RCTRootView alloc] initWithBundleURL: jsCodeLocation moduleName: @"ReactSdk" initialProperties:params launchOptions: nil];
    [self.window.rootViewController.view addSubview:self.reactView];    
    [self hideReactView];
}

- (void) detachReactView {
    if (nil != self.reactView) {
        [self.reactView removeFromSuperview];
        self.reactView = nil;
    }
}

- (void) no1NotiThird:(NSInteger)type params:(NSString*) params {
    if (nil != self.no1ToThirdListener) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.no1ToThirdListener no1NotiThird:type params:params];
        });
    }
}

- (void) thirdCallNo1:(NSInteger)type params:(NSString*) params {
    [[ReactSdkModule allocWithZone: nil] thirdCallNo1:type params:params];
}

@end
