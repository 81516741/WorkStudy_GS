//
//  LDLoginVC.m
//  MainArch_Example
//
//  Created by 令达 on 2018/4/4.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "LDLoginVC.h"
#import "UIViewController+LDNaviBar.h"
#import "UIViewController+LDLogin.h"
@interface LDLoginVC ()

@end

@implementation LDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginSuccess:(UIButton *)sender {
    //下面这句代码是，该项目是非必须登录架构时使用
    //如果是必须登录架构，登录成功后是直接切根控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.ld_loginSuccessBlock) {
        self.ld_loginSuccessBlock(self);
    }
}

@end
