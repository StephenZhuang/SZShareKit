//
//  SZWechatActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZWechatActivity.h"
#import <Social/Social.h>
#import "WXApi.h"
#import "WXApiObject.h"

@implementation SZWechatActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return SZShareTypeWeChat;
}

- (NSString *)activityTitle
{
    return SZShareTitleWeChat;
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"wechat"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%@",activityItems);
//    __weak SLComposeViewController *currentComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SZShareTypeWeChat];
//    [currentComposeViewController setInitialText:@"Hello social framework!"];
//    [currentComposeViewController addImage:[UIImage imageNamed:@"1.jpg"]];
//    [currentComposeViewController addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    currentComposeViewController.completionHandler = ^(SLComposeViewControllerResult result){
//        switch (result)
//        {
//            case SLComposeViewControllerResultDone:
//                NSLog(@"Done!");
//                break;
//            case SLComposeViewControllerResultCancelled:
//                NSLog(@"Canceled");
//            default:
//                break;
//        }
//        [currentComposeViewController	dismissViewControllerAnimated:YES
//                                                         completion:nil];
//    };
//    [self presentViewController:currentComposeViewController
//                       animated:YES
//                     completion:nil];
    SendMessageToWXReq *send = [[SendMessageToWXReq alloc] init];
    send.bText = NO;
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]]) {
            if ([activityItem hasPrefix:@"http"]) {
                WXWebpageObject *web = [[WXWebpageObject alloc] init];
                [web setWebpageUrl:activityItem];
                message.mediaObject = web;
            } else {
                message.title = activityItem;
                message.description = activityItem;
            }
        } else if ([activityItem isKindOfClass:[UIImage class]]) {
//            WXImageObject *imageObject = [WXImageObject object];
//            [imageObject setImageData:UIImagePNGRepresentation(activityItem)];
//            message.mediaObject = imageObject;
            [message setThumbImage:activityItem];
        }
    }
    send.bText = NO;
    send.message = message;
    [WXApi sendReq:send];
}



@end
