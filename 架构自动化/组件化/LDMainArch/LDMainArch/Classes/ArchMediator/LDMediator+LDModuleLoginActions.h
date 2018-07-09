//
//  LDMediator+LDModuleLoginActions.h
//  MainArch
//
//  Created by 令达 on 2018/4/4.
//

#import "LDMediator.h"

@interface LDMediator (LDModuleLoginActions)

/**
 返回包装了导航控制器的登录控制器
 */
- (UINavigationController *)LDMediator_viewControllerForModuleLoginVC;
@end
