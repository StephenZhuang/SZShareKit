//
//  SZTimelineActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/27.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZTimelineActivity.h"
#import "SZShareManager.h"
#import "UIImage+SZBundleImage.h"

@implementation SZTimelineActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return SZShareTypeTimeline;
}

- (NSString *)activityTitle
{
    return SZShareTitleTimeline;
}

- (UIImage *)activityImage
{
    return [UIImage imagesNamedFromCustomBundle:@"timeline"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    [[SZShareManager sharedManager] shareToWeixin:YES];
}

@end
