//
//  LDMediator+LDModuleBActions.m
//  MainArch_Example
//
//  Created by 令达 on 2018/3/29.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "LDMediator+LDModuleBActions.h"

NSString  * const kLDMediatorTargetB = @"B";
NSString  * const kLDMediatorActionNativeFetchModuleBVC = @"nativeFetchModuleBVC";

@implementation LDMediator (LDModuleBActions)
- (UINavigationController *)LDMediator_viewControllerForModuleB
{
    NSDictionary * params = @{@"title":@"首页",
                              @"image":@"second_normal",
                              @"selectedImage":@"second_selected"
                              };
    
    UIViewController *viewController = [self performTarget:kLDMediatorTargetB
                                                    action:kLDMediatorActionNativeFetchModuleBVC
                                                    params:params
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:viewController];
        return navi;
    } else {
        return nil;
    }
}



@end
