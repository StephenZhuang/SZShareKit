//
//  AppDelegate.h
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "TencentOpenAPI/TencentOAuth.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate , WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

