//
//  LDDBTool.h
//  MainArch_Example
//
//  Created by 令达 on 2018/3/27.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDDBTool : NSObject
void userDefaultSet(id object,id key);
id userDefaultGet(id key);
@end


