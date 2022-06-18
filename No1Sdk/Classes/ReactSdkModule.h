//
//  ReactSdkModule.h
//  ReactSdk
//
//  Created by 张留成 on 2022/4/9.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReactSdkModule : RCTEventEmitter <RCTBridgeModule>

- (void) thirdCallNo1:(NSInteger)type params:(NSString*) params;

@end

NS_ASSUME_NONNULL_END
