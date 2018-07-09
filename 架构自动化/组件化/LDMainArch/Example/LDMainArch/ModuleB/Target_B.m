//
//  Target_B.m
//  MainArch_Example
//
//  Created by 令达 on 2018/3/29.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "Target_B.h"
#import "LDModuleBVC.h"
@implementation Target_B
- (UIViewController *)Action_nativeFetchModuleBVC:(NSDictionary *)params
{
    LDModuleBVC * vc = [[LDModuleBVC alloc] init];
    vc.tabBarItem.title = params[@"title"];
    vc.tabBarItem.image = [UIImage imageNamed:params[@"image"]];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:params[@"selectedImage"]];
    return vc;
}
@end
