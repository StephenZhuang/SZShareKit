//
//  SZQZoneActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/27.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZQZoneActivity.h"
#import "SZShareManager.h"
#import "UIImage+SZBundleImage.h"

@implementation SZQZoneActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return SZShareTypeQZone;
}

- (NSString *)activityTitle
{
    return SZShareTitleQZone;
}

- (UIImage *)activityImage
{
    return [UIImage imagesNamedFromCustomBundle:@"qzone"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    
}
@end
