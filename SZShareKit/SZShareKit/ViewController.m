//
//  ViewController.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "ViewController.h"
#import "SZWechatActivity.h"
#import "SZQQActivity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (IBAction)shareAction:(id)sender
{
//    UIActivityViewController *shareController = [[UIActivityViewController alloc] initWithActivityItems:nil applicationActivities:nil];
//    [self presentViewController:shareController animated:YES completion:nil];
    
    NSArray *activityItems = [[NSArray alloc]initWithObjects:
                              @"移动开发技术尽在DevDiv移动技术开发社区",
                              @"http://www.DevDiv.com",
                              [UIImage imageNamed:@"sina"], nil];
    SZQQActivity *qq = [[SZQQActivity alloc] init];
    SZWechatActivity *wechat = [[SZWechatActivity alloc] init];
    NSArray *activities = [NSArray arrayWithObjects:wechat,qq, nil];
    
	    // 初始化一个UIActivityViewController
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:activities];
    activityVC.excludedActivityTypes = [NSArray arrayWithObjects:@"com.apple.UIKit.activity.PostToWeibo",@"com.evernote.iPhone.Evernote.EvernoteShare", nil];

    // 写一个bolck，用于completionHandler的初始化
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

    // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
    activityVC.completionWithItemsHandler = myBlock;

    // 以模态方式展现出UIActivityViewController
    [self presentViewController:activityVC animated:YES completion:Nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
