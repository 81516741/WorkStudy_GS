//
//  ViewController.m
//  test
//
//  Created by lingda on 2017/11/24.
//  Copyright © 2017年 btc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong ,atomic)NSMutableArray * arr;
@end

@implementation ViewController
//打印结果如下：总结  在一个线程中他是有个队列的东西存在的，上个队列的任务执行完了才会执行下个队列的内容
//这里打印 --------- 是异步的 但都是在主线程上，但是 打印 --------的队列排在了for循环队列之后
//2017-11-26 11:07:09.323728+0800 test[19480:1526248] 1
//2017-11-26 11:07:09.323793+0800 test[19480:1526248] once----
//2017-11-26 11:07:09.323829+0800 test[19480:1526248] 2
//2017-11-26 11:07:09.323842+0800 test[19480:1526248] 3
//2017-11-26 11:07:09.323854+0800 test[19480:1526248] 4
//2017-11-26 11:07:09.323865+0800 test[19480:1526248] sleep---
//2017-11-26 11:07:12.324999+0800 test[19480:1526248] 5
//2017-11-26 11:07:12.325168+0800 test[19480:1526248] 6
//2017-11-26 11:07:12.365617+0800 test[19480:1526248] ------------
- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    for (int i = 0 ;i < _arr.count ; i ++) {
        NSLog(@"%@",_arr[i]);
        if(i == 3){
            NSLog(@"sleep---");
            sleep(3);
        }
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"once----");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"------------");
            });
        });
    }
    
}

@end
