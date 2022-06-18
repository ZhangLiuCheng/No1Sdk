//
//  SdkDemoController.m
//  ReactSdk
//
//  Created by 张留成 on 2022/3/21.
//
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTDevLoadingView.h>
#import "SdkDemoController.h"
#import "No1Sdk.h"
#import "No1ToThirdListener.h"

@interface SdkDemoController () <No1ToThirdListener>

@end

@implementation SdkDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RCTDevLoadingView setEnabled:NO];

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [[No1Sdk shareInstance] init:window no1ToThirdListener:self debug:TRUE];
}

- (void)no1NotiThird:(NSInteger)type params:(NSString *)params {
    NSLog(@"no1NotiThird    type=%ld  params=%@", type, params);
}

- (IBAction) sdkLogin:(id)sender {
    NSMutableDictionary *dict = [NSMutableDictionary new];
//    [dict setObject:@"22" forKey:@"sourceId"];
//    [dict setObject:@"1000" forKey:@"appId"];
//    [dict setObject:@"WJ" forKey:@"trainPrefix"];
//    [dict setObject:@"111623" forKey:@"userId"];
    
    [dict setObject:@"90002" forKey:@"sourceId"];
    [dict setObject:@"10007" forKey:@"appId"];
    [dict setObject:@"CN" forKey:@"trainPrefix"];
    [dict setObject:@"1439162" forKey:@"userId"];
    
    [dict setObject:@"" forKey:@"nickName"];
    [dict setObject:@"" forKey:@"avatar"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *params = [data base64EncodedStringWithOptions: 0];
    [[No1Sdk shareInstance] thirdCallNo1:10 params:params];
}

- (IBAction) toTrainMore:(id)sender {
    [[No1Sdk shareInstance] thirdCallNo1:103 params:NULL];
}

- (IBAction) toTrainMine:(id)sender {
//    [[No1Sdk shareInstance] toTrainMine];
    [[No1Sdk shareInstance] thirdCallNo1:111 params:NULL];
}

- (IBAction) toTeamMain:(id)sender {
//    [[No1Sdk shareInstance] toTeamMain];
    [[No1Sdk shareInstance] thirdCallNo1:104 params:NULL];
}

- (IBAction) toMatchMain:(id)sender {
//    [[No1Sdk shareInstance] toMatchMain];
    [[No1Sdk shareInstance] thirdCallNo1:102 params:NULL];
}

- (IBAction) toMatchCreate:(id)sender {
//    [[No1Sdk shareInstance] toMatchCreate];
    [[No1Sdk shareInstance] thirdCallNo1:101 params:NULL];
}

- (IBAction) toMatchJoin:(id)sender {
//    [[No1Sdk shareInstance] toMatchJoin];
    [[No1Sdk shareInstance] thirdCallNo1:100 params:nil];
}

- (IBAction) toDataMain:(id)sender {
//    [[No1Sdk shareInstance] toDataMain];
    [[No1Sdk shareInstance] thirdCallNo1:106 params:NULL];
}

- (IBAction) toMallMain:(id)sender {
//    [[No1Sdk shareInstance] toMallMain];
    [[No1Sdk shareInstance] thirdCallNo1:107 params:NULL];
}

- (IBAction) toPersonal:(id)sender {
//    [[No1Sdk shareInstance] toPersonal];
    [[No1Sdk shareInstance] thirdCallNo1:108 params:NULL];
}

- (IBAction) toRecordMain:(id)sender {
//    [[No1Sdk shareInstance] toRecordMain];
    [[No1Sdk shareInstance] thirdCallNo1:109 params:NULL];
}

- (IBAction) toClubMain:(id)sender {
//    [[No1Sdk shareInstance] toClubMain];
    [[No1Sdk shareInstance] thirdCallNo1:105 params:nil];
}

- (IBAction)test:(id)sender {
//    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];

    NSURL *jsCodeLocation = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"bundle/index.ios.bundle" ofType:nil]];
    
    RCTRootView *rootView =
      [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                  moduleName: @"ReactSdk"
                           initialProperties:nil
                               launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
