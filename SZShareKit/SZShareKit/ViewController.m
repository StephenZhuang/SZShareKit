//
//  ViewController.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "ViewController.h"
#import "SZShareManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)shareAction:(id)sender
{
    SZShareObject *shareObject = [[SZShareObject alloc] init];
    shareObject.shareTitle = @"移动开发技术尽在DevDiv移动技术开发社区";
    shareObject.shareDescription = @"移动开发技术尽在DevDiv移动技术开发社区";
    shareObject.shareUrl = @"http://www.DevDiv.com";
    shareObject.shareImage = [UIImage imageNamed:@"sina"];
    shareObject.shareImageUrl = @"http://img0.bdstatic.com/img/image/shouye/mnct-9404969720.jpg";
    NSArray *platforms = @[@(SZShareQQ),@(SZShareQZone),@(SZShareTimeline),@(SZShareWechat)];
    SZShareSuccessBlock successBlock = ^(void) {
        NSLog(@"分享成功");
    };
    SZShareFailureBlock failureBlock = ^(int errorCode , NSString *errorMessage) {
        NSLog(@"errorCode = %i , errorMessage = %@" ,errorCode , errorMessage);
    };
    [self showMenuWithObject:shareObject platforms:platforms successBlock:successBlock failureBlock:failureBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
