//
//  LDMediator+LDModuleAActions.m
//  MainArch_Example
//
//  Created by 令达 on 2018/3/26.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "LDMediator+LDModuleAActions.h"

NSString  * const kLDMediatorTargetA = @"A";
NSString  * const kLDMediatorActionNativeFetchModuleAVC = @"nativeFetchModuleAVC";

@implementation LDMediator (LDModuleAActions)
- (UINavigationController *)LDMediator_viewControllerForModuleA
{
    NSDictionary * params = @{@"title":@"我的",
                              @"image":@"first_normal",
                              @"selectedImage":@"first_selected"
                              };
    
    UIViewController *viewController = [self performTarget:kLDMediatorTargetA
                                                    action:kLDMediatorActionNativeFetchModuleAVC
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
