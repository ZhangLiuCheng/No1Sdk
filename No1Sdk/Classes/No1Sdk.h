//
//  WJSdk.h
//  ReactSdk
//
//  Created by 张留成 on 2022/4/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "No1ToThirdListener.h"

@interface No1Sdk : NSObject

+ (instancetype)shareInstance;

- (void) init:(UIWindow*) window no1ToThirdListener:(id<No1ToThirdListener>) listener;
- (void) init:(UIWindow*) window no1ToThirdListener:(id<No1ToThirdListener>) listener debug:(BOOL) debug;
- (void) destroy;
- (void) showReactView;
- (void) hideReactView;
- (void) reloadReactView;
- (void) no1NotiThird:(NSInteger)type params:(NSString*) params;
- (void) thirdCallNo1:(NSInteger)type params:(NSString*) params;

@end

