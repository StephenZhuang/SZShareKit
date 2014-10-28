//
//  SZWechatActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZWechatActivity.h"
#import "SZShareManager.h"
#import "UIImage+SZBundleImage.h"

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
    return [UIImage imagesNamedFromCustomBundle:@"wechat"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    [self activityDidFinish:YES];
    [[SZShareManager sharedManager] shareToWeixin:NO];
}



@end
