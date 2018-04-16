//
//  LDRunloop.h
//  Runloop-性能优化，加载大图
//
//  Created by lingda on 2017/11/8.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^RunloopBlock)(void);

@interface LDRunloop : NSObject
@property (nonatomic,assign) NSUInteger maxQueue;
+ (instancetype)shareInstance;
- (void)addTask:(RunloopBlock)unit;
- (void)removeAllTasks;
@end
