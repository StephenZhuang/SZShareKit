//
//  SZShareObject.h
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/27.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SZShareObject : NSObject
@property (nonatomic , copy) NSString *shareTitle;
@property (nonatomic , copy) NSString *shareDescription;
@property (nonatomic , copy) NSString *shareUrl;
@property (nonatomic , copy) NSString *shareImageUrl;
@property (nonatomic , strong) UIImage *shareImage;
@end
