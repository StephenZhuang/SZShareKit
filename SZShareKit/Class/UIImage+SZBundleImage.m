//
//  UIImage+SZBundleImage.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/27.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "UIImage+SZBundleImage.h"

@implementation UIImage (SZBundleImage)
+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)name
{
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SZShareResource.bundle"];
    NSString *image_path = [main_images_dir_path stringByAppendingPathComponent:name];
    return [UIImage imageWithContentsOfFile:image_path];
}
@end
