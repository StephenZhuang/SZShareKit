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
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

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

+ (BOOL)handleOpenUrl:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:@"wx"]) {
        return [[SZShareManager sharedManager] handleWeixnOpenUrl:url];
    } else {
        return [TencentOAuth HandleOpenURL:url];
    }
}

@end

@implementation SZShareManager (wechat)

#pragma -mark wechat
- (void)registerWeixinWithAppid:(NSString *)appid
{
    [WXApi registerApp:appid];
}

- (void)shareToWeixin:(BOOL)isTimeline
{
    if (_shareObject.shareUrl) {
        [self shareWebToWeixin:isTimeline];
    } else if (_shareObject.shareImage || _shareObject.shareImageUrl) {
        [self shareImageToWeixin:isTimeline];
    } else {
        [self shareTextToWeixin:isTimeline];
    }
}

- (void)shareWebToWeixin:(BOOL)isTimeline
{
    SendMessageToWXReq *send = [[SendMessageToWXReq alloc] init];
    send.bText = NO;
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    WXWebpageObject *web = [[WXWebpageObject alloc] init];
    [web setWebpageUrl:_shareObject.shareUrl];
    message.mediaObject = web;
    message.title = _shareObject.shareTitle;
    message.description = _shareObject.shareDescription;;
    [message setThumbImage:_shareObject.shareImage];
    send.message = message;
    [send setScene:isTimeline?WXSceneTimeline:WXSceneSession];
    [WXApi sendReq:send];
}

- (void)shareImageToWeixin:(BOOL)isTimeline
{
    SendMessageToWXReq *send = [[SendMessageToWXReq alloc] init];
    send.bText = NO;
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    WXImageObject *imageObject = [[WXImageObject alloc] init];
    if (_shareObject.shareImage) {
        imageObject.imageData = UIImagePNGRepresentation(_shareObject.shareImage);
    } else {
        imageObject.imageUrl = _shareObject.shareImageUrl;
    }
    message.mediaObject = imageObject;
    message.title = _shareObject.shareTitle;
    message.description = _shareObject.shareDescription;;
    [message setThumbImage:_shareObject.shareImage];
    send.message = message;
    [send setScene:isTimeline?WXSceneTimeline:WXSceneSession];
    [WXApi sendReq:send];
}

- (void)shareTextToWeixin:(BOOL)isTimeline
{
    SendMessageToWXReq *send = [[SendMessageToWXReq alloc] init];
    send.bText = YES;
    send.text = _shareObject.shareTitle;
    [send setScene:isTimeline?WXSceneTimeline:WXSceneSession];
    [WXApi sendReq:send];
}

- (BOOL)handleWeixnOpenUrl:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onReq:(BaseReq*)req
{
    NSLog(@"callback = %@",req);
}

- (void)onResp:(BaseResp*)resp
{
    NSLog(@"resp");
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
    if ([TencentOAuth iphoneQQInstalled] && [TencentOAuth iphoneQQSupportSSOLogin]) {
        [_tencentOAuth authorize:_permissions inSafari:NO];
    } else {
        [_tencentOAuth authorize:_permissions inSafari:YES];
    }
}

- (void)tencentDidLogin
{
    NSLog(@"登录成功");
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录失败");
}

- (void)shareToQQ:(BOOL)isQZone
{
    if ([_tencentOAuth isSessionValid]) {
        if (_shareObject.shareUrl) {
            [self shareWebToQQ:isQZone];
        } else if (_shareObject.shareImage) {
            [self shareImageToQQ:isQZone];
        } else {
            [self shareTextToQQ:isQZone];
        }
    } else {
        [self tencentLogin];
    }
}

- (void)shareTextToQQ:(BOOL)isQZone
{
    NSString *description = _shareObject.shareDescription;
    QQApiTextObject *textObj = [[QQApiTextObject alloc] initWithText:description];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:textObj];
    QQApiSendResultCode sent;
    if (isQZone) {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    } else {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    }
}

- (void)shareImageToQQ:(BOOL)isQZone
{
    NSString *title = _shareObject.shareTitle;
    NSString *description = _shareObject.shareDescription;
    QQApiImageObject *imageObj = [[QQApiImageObject alloc] initWithData:UIImagePNGRepresentation(_shareObject.shareImage) previewImageData:UIImagePNGRepresentation(_shareObject.shareImage) title:title description:description];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imageObj];
    QQApiSendResultCode sent;
    if (isQZone) {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    } else {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    }
}

- (void)shareWebToQQ:(BOOL)isQZone
{
    NSString *title = _shareObject.shareTitle;
    NSString *description = _shareObject.shareDescription;
    NSString *previewImageUrl = _shareObject.shareImageUrl;
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:_shareObject.shareUrl]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent;
    if (isQZone) {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    } else {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
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
    
    // 写一个block，用于completionHandler的初始化
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
    
    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该block都会被调用
    activityVC.completionWithItemsHandler = myBlock;
    
    // 以模态方式展现出UIActivityViewController
    [self presentViewController:activityVC animated:YES completion:Nil];
}

@end
