//
//  LDModuleAVC1.m
//  MainArch_Example
//
//  Created by 令达 on 2018/4/6.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "LDModuleAVC1.h"
#import "UIViewController+LDNaviBar.h"
#import "UIViewController+LDLogin.h"
#import "LDMediator+LDModuleLoginActions.h"

@interface LDModuleAVC1 ()

@end

@implementation LDModuleAVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self ld_setNaviBarRightItemImage:[UIImage imageNamed:@"first_selected"] render:NO sel:@selector(showLoginPage)];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
}

- (void)showLoginPage {
    UINavigationController * navi = [[LDMediator sharedInstance] LDMediator_viewControllerForModuleLoginVC];
    navi.childViewControllers.firstObject.ld_loginSuccessBlock = ^(UIViewController * vc){
        NSLog(@"登录完成");
        [vc dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:navi animated:YES completion:nil];
}



@end
