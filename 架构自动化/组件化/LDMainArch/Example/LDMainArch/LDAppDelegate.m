//
//  LDAppDelegate.m
//  LDMainArch
//
//  Created by 81516741@qq.com on 04/07/2018.
//  Copyright (c) 2018 81516741@qq.com. All rights reserved.
//

#import "LDAppDelegate.h"
#import "LDConfigVCTool.h"
@implementation LDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [LDConfigVCTool config:NO];
    return YES;
}

@end
