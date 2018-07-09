//
//  LDDBTool.m
//  MainArch_Example
//
//  Created by 令达 on 2018/3/27.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "LDDBTool.h"
#import <UIKit/UIKit.h>

@implementation LDDBTool

void userDefaultSet(id object,id key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}
id userDefaultGet(id key) {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
