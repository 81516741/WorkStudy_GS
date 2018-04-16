//
//  PayManager.h
//  支付例子
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayManager : NSObject

/**
 创建单例
 */
+ (instancetype)share;

#pragma - mark 银联支付
/**
 发起支付

 @param viewController 发起支付所在的控制器
 */
- (void)UPPayIn:(UIViewController *)viewController;

/**
 处理支付结果
 
 @param url AppDelegate回调的url
 */
- (void)UPPayHandlePayResult:(NSURL*)url;

#pragma - mark 微信支付
/**
 向微信注册
 */
+ (void)WXRegister;


/**
 微信支付
 */
- (void)WXPay;

/**
 处理微信回调url

 @param url AppDelegate回调的url
 @return 操作是否成功
 */
+ (BOOL)WXPayHOpenUrl:(NSURL *)url;

@end
