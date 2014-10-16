//
//  SZWechatActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZWechatActivity.h"

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
}
@end
