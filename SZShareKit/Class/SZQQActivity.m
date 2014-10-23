//
//  SZQQActivity.m
//  SZShareKit
//
//  Created by Stephen Zhuang on 14-10-16.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "SZQQActivity.h"

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
    return [UIImage imageNamed:@"qq"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%@",activityItems);
    TencentOAuth *oauth = [SZShareManager sharedManager].tencentOAuth;
    if (oauth) {
        
        NSData *imgData = nil;
        NSString *title = @"";
        for (id activityItem in activityItems) {
            if ([activityItem isKindOfClass:[NSString class]]) {
                title = activityItem;
            } else if ([activityItem isKindOfClass:[UIImage class]]) {
                imgData = UIImagePNGRepresentation(activityItem);
            }
        }
//        QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imgData
//                                                   previewImageData:imgData
//                                                              title:title
//                                                        description:title];
//        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
//        //将内容分享到qq
//        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
//        NSLog(@"%d",sent);
        
        NSString *utf8String = @"http://www.163.com";
//        NSString *title = @"新闻标题";
        NSString *description = @"新闻描述";
        NSString *previewImageUrl = @"http://cdni.wired.co.uk/620x413/k_n/NewsForecast%20copy_620x413.jpg";
        QQApiNewsObject *newsObj = [QQApiNewsObject
                                    objectWithURL:[NSURL URLWithString:utf8String]
                                    title:title
                                    description:description
                                    previewImageURL:[NSURL URLWithString:previewImageUrl]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        //将内容分享到qzone
//        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    } else {
        [[SZShareManager sharedManager] tencentLogin];
    }
    
//    TCAddShareDic *params = [TCAddShareDic dictionary];
//    params.paramTitle = @"腾讯内部addShare接口测试";
//    params.paramComment = @"风云乔帮主";
//    params.paramSummary =  @"乔布斯被认为是计算机与娱乐业界的标志性人物，同时人们也把他视作麦金塔计算机、iPod、iTunes、iPad、iPhone等知名数字产品的缔造者，这些风靡全球亿万人的电子产品，深刻地改变了现代通讯、娱乐乃至生活的方式。";
//    params.paramImages = @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg";
//    params.paramUrl = @"http://www.qq.com";
    
//    if(![_tencentOAuth addShareWithParams:params]){
//        [self showInvalidTokenOrOpenIDMessage];
//    }
}
@end
