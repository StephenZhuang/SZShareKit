//
//  SZShareManager.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14/10/22.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZShareManager.h"

@implementation SZShareManager
+ (instancetype) sharedManager
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)registerQQWithAppid:(NSString *)appid
{
    _QQAppid = appid;
    
}

- (void)tencentLogin
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"222222" andDelegate:self];
    NSArray *_permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

- (void)tencentDidLogin
{
    
}

- (void)tencentDidLogout
{
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)addShareResponse:(APIResponse*) response {
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        
        
        NSMutableString *str=[NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse) {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
                              
                                                       delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles:nil];
        [alert show];
        
        
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
                              
                                                       delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        [alert show];
    }
    
    
}
@end
