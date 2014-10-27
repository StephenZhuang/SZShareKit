//
//  SZShareManager.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/22.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZShareManager.h"
#import "SZShareConstString.h"
#import "SZWechatActivity.h"
#import "SZQQActivity.h"
#import "SZTimelineActivity.h"
#import "SZQZoneActivity.h"

@implementation SZShareManager
+ (instancetype) sharedManager
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

@end

@implementation SZShareManager (wechat)

#pragma -mark wechat
- (void)registerWeixinWithAppid:(NSString *)appid
{
    [WXApi registerApp:appid];
}

@end

@implementation SZShareManager (qq)

#pragma -mark qq
- (void)registerQQWithAppid:(NSString *)appid
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:self];
}

- (void)tencentLogin
{
    NSArray *_permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

- (void)tencentDidLogin
{
    NSLog(@"登录成功");
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录失败");
}

- (void)addShareResponse:(APIResponse*) response {
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        
        
        NSMutableString *str=[NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse) {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
                              
                                                       delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles:nil];
        [alert show];
        
        
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
                              
                                                       delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        [alert show];
    }
    
    
}
@end

@implementation UIViewController (SZShareKit)

- (void)showMenuWithObject:(SZShareObject *)shareObject platforms:(NSArray *)platforms
{
    SZShareManager *shareManager = [SZShareManager sharedManager];
    shareManager.shareObject = shareObject;
    NSArray *activityItems = nil;
    if (shareObject.shareImage) {
        activityItems = [[NSArray alloc]initWithObjects:shareObject.shareTitle,shareObject.shareUrl,shareObject.shareImage, nil];
    } else {
        activityItems = [[NSArray alloc]initWithObjects:shareObject.shareTitle,shareObject.shareUrl, nil];
    }
    
    NSMutableArray *activities = [[NSMutableArray alloc] init];
    for (NSNumber *number in platforms) {
        switch (number.integerValue) {
            case SZShareQQ:
            {
                SZQQActivity *qq = [[SZQQActivity alloc] init];
                [activities addObject:qq];
            }
                break;
            case SZShareQZone:
            {
                SZQZoneActivity *qzone = [[SZQZoneActivity alloc] init];
                [activities addObject:qzone];
            }
                break;
            case SZShareTimeline:
            {
                SZTimelineActivity *timeline = [[SZTimelineActivity alloc] init];
                [activities addObject:timeline];
            }
                break;
            case SZShareWechat:
            {
                SZWechatActivity *wechat = [[SZWechatActivity alloc] init];
                [activities addObject:wechat];
            }
                break;
            default:
                break;
        }
    }
    
    // 初始化一个UIActivityViewController
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:activities];
    
    // 写一个bolck，用于completionHandler的初始化
    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        NSLog(@"%@", activityType);
        NSLog(@"%@",returnedItems);
        if(completed) {
            NSLog(@"completed");
        } else
        {
            NSLog(@"cancled");
        }
        [activityVC dismissViewControllerAnimated:YES completion:Nil];
    };
    
    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    activityVC.completionWithItemsHandler = myBlock;
    
    // 以模态方式展现出UIActivityViewController
    [self presentViewController:activityVC animated:YES completion:Nil];
}

@end
