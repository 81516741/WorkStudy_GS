//
//  ViewController.m
//  支付例子
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "PayManager.h"

@interface ViewController ()<NSURLConnectionDelegate>
@property(nonatomic,strong)NSMutableData * data;
@end

@implementation ViewController

- (IBAction)UniPayClick:(id)sender
{
    [[PayManager share] UPPayIn:self];
}
- (IBAction)WXPayClick:(id)sender
{
    [[PayManager share] WXPay];
}

@end
