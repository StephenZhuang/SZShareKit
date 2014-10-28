SZShareKit
==========

share to sina, weixin ,qq

![github logo](https://github.com/StephenZhuang/SZShareKit/raw/master/screenshot/UIActivityController.png)
![github logo](https://github.com/StephenZhuang/SZShareKit/raw/master/screenshot/SLComposeController.png)

usage
=========
- 引入工程
- 添加framework

  > libz.dylib
  
  > libstdc++.dylib
  
  > CoreTelephony.framework
  
  > libsqlite3.dylib
  
  > libz.1.1.3.dylib
  
  > SystemConfiguration
  
  > libiconv.dylib

- 在info里添加urltypes

- AppDelegate
```objc
#import "SZShareManager.h"
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SZShareManager *shareManager = [SZShareManager sharedManager];
    [shareManager registerWeixinWithAppid:@"wx712df8473f2a1dbe"];
    [shareManager registerQQWithAppid:@"222222"];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [SZShareManager handleOpenUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [SZShareManager handleOpenUrl:url];
}
```
- viewcontroller
```objc
#import "SZShareManager.h"
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
```
TODO
=========
QQ分享每次打开应用都要重新登录一次
