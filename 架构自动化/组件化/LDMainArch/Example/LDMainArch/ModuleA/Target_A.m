//
//  Target_A.m
//  MainArch_Example
//
//  Created by 令达 on 2018/3/26.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "Target_A.h"
#import "LDModuleAVC.h"

@implementation Target_A
    
- (UIViewController *)Action_nativeFetchModuleAVC:(NSDictionary *)params
{
    LDModuleAVC * vc = [[LDModuleAVC alloc] init];
    vc.tabBarItem.title = params[@"title"];
    vc.tabBarItem.image = [UIImage imageNamed:params[@"image"]];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:params[@"selectedImage"]];
    return vc;
}
@end
