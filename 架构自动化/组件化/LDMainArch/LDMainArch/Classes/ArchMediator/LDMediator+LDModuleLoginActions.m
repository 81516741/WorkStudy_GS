//
//  LDMediator+LDModuleLoginActions.m
//  MainArch
//
//  Created by 令达 on 2018/4/4.
//

#import "LDMediator+LDModuleLoginActions.h"

NSString  * const kLDMediatorTargetLogin = @"Login";
NSString  * const kLDMediatorActionNativeFetchModuleLoginVC = @"nativeFetchModuleLoginVC";

@implementation LDMediator (LDModuleLoginActions)
- (UINavigationController *)LDMediator_viewControllerForModuleLoginVC
{
    UIViewController *viewController = [self performTarget:kLDMediatorTargetLogin
                                                    action:kLDMediatorActionNativeFetchModuleLoginVC
                                                    params:nil
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
//        __weak UIViewController * weakSelf = viewController;
//        viewController.ld_loginSuccessBlock = ^{
//            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:kLoginStateKey];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            if (mustLogin) {//切换根控制器
//               [LDConfigVCTool configTabCToRootVC];
//            } else {//直接dismiss掉
//               [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                if (weakSelf.ld_loginCompleteBlock) {
//                   weakSelf.ld_loginCompleteBlock();
//                }
//            }
//        };
        UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:viewController];
        return navi;
    } else {
        return nil;
    }
}
@end
