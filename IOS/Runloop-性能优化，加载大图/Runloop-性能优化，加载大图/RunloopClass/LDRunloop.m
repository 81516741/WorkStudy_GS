//
//  LDRunloop.m
//  Runloop-性能优化，加载大图
//
//  Created by lingda on 2017/11/8.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "LDRunloop.h"

@interface LDRunloop()
@property (nonatomic,strong) NSMutableArray * tasks;
@end

@implementation LDRunloop

+ (instancetype)shareInstance
{
    static LDRunloop * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [LDRunloop new];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxQueue = 18;
        self.tasks = [NSMutableArray array];
        [self addRunloopObserver];
    }
    return self;
}

- (void)removeAllTasks
{
    [self.tasks removeAllObjects];
}

- (void)addTask:(RunloopBlock)unit
{
    [self.tasks addObject:unit];
    if (self.tasks.count > self.maxQueue) {
        [self.tasks removeObjectAtIndex:0];
    }
}

static void callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    LDRunloop * runloop = (__bridge LDRunloop *)info;
    BOOL result = YES;
    while (result == YES && runloop.tasks.count) {
        RunloopBlock unit = runloop.tasks.firstObject;
        result = unit();
        [runloop.tasks removeObjectAtIndex:0];
    }
}

- (void)addRunloopObserver
{
    CFRunLoopRef current =  CFRunLoopGetCurrent();

    CFRunLoopObserverRef defaultModeObserver;
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    defaultModeObserver = CFRunLoopObserverCreate(NULL,
                                                  kCFRunLoopBeforeWaiting, YES,
                                                  NSIntegerMax - 999,
                                                  &callback,
                                                  &context);
    CFRunLoopAddObserver(current, defaultModeObserver, kCFRunLoopCommonModes);
    CFRelease(defaultModeObserver);
}

@end
