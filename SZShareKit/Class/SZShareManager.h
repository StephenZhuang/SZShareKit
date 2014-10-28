//
//  SZShareManager.h
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/22.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentOpenAPI/TencentOAuth.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "SZShareObject.h"
#import "SZShareConstString.h"
#import "SZWechatActivity.h"
#import "SZQQActivity.h"

typedef enum : NSUInteger {
    SZShareQQ = 0,
    SZShareQZone = 1,
    SZShareTimeline = 2,
    SZShareWechat = 3
} SZSHareType;

typedef void(^SZShareSuccessBlock)();
typedef void(^SZShareFailureBlock)(int errorCode,NSString *errorMessage);

@interface SZShareManager : NSObject
@property (nonatomic , strong) SZShareObject *shareObject;
@property (nonatomic , strong) TencentOAuth *tencentOAuth;
@property (nonatomic , strong) UIActivity *currentActivity;
@property (nonatomic , copy) SZShareSuccessBlock successBlock;
@property (nonatomic , copy) SZShareFailureBlock failureBlock;

+ (instancetype) sharedManager;
+ (BOOL)handleOpenUrl:(NSURL *)url;
@end

@interface SZShareManager (wechat)<WXApiDelegate>
- (void)registerWeixinWithAppid:(NSString *)appid;
- (void)shareToWeixin:(BOOL)isTimeline;
- (BOOL)handleWeixnOpenUrl:(NSURL *)url;
@end

@interface SZShareManager (qq)<TencentSessionDelegate>
- (void)registerQQWithAppid:(NSString *)appid;
- (void)shareToQQ:(BOOL)isQZone;
@end

@interface UIViewController (SZShareKit)
- (void)showMenuWithObject:(SZShareObject *)shareObject platforms:(NSArray *)platforms successBlock:(SZShareSuccessBlock)successBlock failureBlock:(SZShareFailureBlock)failureBlock;

@end
