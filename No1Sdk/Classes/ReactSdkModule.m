//
//  ReactSdkModule.m
//  ReactSdk
//
//  Created by 张留成 on 2022/4/9.
//

#import "ReactSdkModule.h"
#import "No1Sdk.h"
#import <BSDiff/BSDiff.h>

@interface ReactSdkModule () 

@end

@implementation ReactSdkModule

+(id)allocWithZone:(NSZone *)zone {
    static ReactSdkModule *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
     sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showSdkView) {
    [[No1Sdk shareInstance] showReactView];
}

RCT_EXPORT_METHOD(hideSdkView) {
    [[No1Sdk shareInstance] hideReactView];
}

RCT_EXPORT_METHOD(reloadSdkView) {
    [[No1Sdk shareInstance] reloadReactView];
}

RCT_EXPORT_METHOD(bsPatch:(NSString *) oldFile
                  patchFile:(NSString *) patchFile
                  newFile: (NSString *) newFile
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
//    NSLog(@"ios 开始bspatch  oldFile:: %@    newFile::%@    patchFile::%@", oldFile, patchFile, newFile);
    [BSDiff patchWithOldFilePath: oldFile
                      newFilePath: newFile
                    patchFilePath: patchFile
                completionHandler:^(NSString * _Nonnull newFilePath, NSError * _Nonnull error) {
         if (error) {
             NSLog(@"ReactSdkModule:: bspatch 合成失败 %@", error.description);
             reject(@"false", @"patch失败", error);
         } else {
             NSLog(@"ReactSdkModule:: bspatch 合成成功");
             resolve(@"true");
         }
     }];
}

RCT_REMAP_METHOD(getUniqueId,
                 resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    resolve(@{@"uniqueId": uuid});
}

RCT_EXPORT_METHOD(no1NotiThird:(NSInteger)type params:(NSString *)params) {
    [[No1Sdk shareInstance] no1NotiThird:type params:params];
}

- (void) thirdCallNo1:(NSInteger)type params:(NSString*) params {
    if (self.callableJSModules == nil) {
        NSLog(@"thirdCallNo1在sdk初始化之前被调用了，此次调用无效 type=%ld", type);
        return;
    }
    NSMutableDictionary *body = [NSMutableDictionary new];
    [body setObject:@(type) forKey:@"type"];
    if (params != nil && params != NULL) {
        [body setObject:params forKey:@"param"];
    }
    [self sendEventWithName:@"thirdCallNo1" body:body];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"thirdCallNo1"];
}

@end
