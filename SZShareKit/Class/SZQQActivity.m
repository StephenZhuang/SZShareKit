//
//  SZQQActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZQQActivity.h"
#import "SZShareManager.h"
#import "UIImage+SZBundleImage.h"

@implementation SZQQActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return SZShareTypeQQ;
}

- (NSString *)activityTitle
{
    return SZShareTitleQQ;
}

- (UIImage *)activityImage
{
    return [UIImage imagesNamedFromCustomBundle:@"qq"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    [self activityDidFinish:YES];
    [[SZShareManager sharedManager] shareToQQ:NO];
}
@end
