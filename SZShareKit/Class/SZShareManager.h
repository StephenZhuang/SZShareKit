//
//  SZShareManager.h
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/22.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentOpenAPI/TencentOAuth.h"

@interface SZShareManager : NSObject<TencentSessionDelegate>
@property (nonatomic , strong) TencentOAuth *tencentOAuth;
@property (nonatomic , copy) NSString *QQAppid;

+ (instancetype) sharedManager;
- (void)tencentLogin;
@end
