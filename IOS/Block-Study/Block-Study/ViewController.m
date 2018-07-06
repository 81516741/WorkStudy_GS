//
//  ViewController.m
//  Block-Study
//
//  Created by lingda on 2018/7/3.
//  Copyright © 2018年 lingda. All rights reserved.
//

#import "ViewController.h"

typedef void(^Block)(int a);
static NSString * globStr;

@interface ViewController ()

@end

Block globBlock;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int b = 3;
    int c = 4;
    static int d = 5;
    NSString * constStr = @"nihao";
    Block tempBlock;
    NSLog(@"%p---%p---%p",globBlock,tempBlock,globStr);

    NSLog(@"\n------栈区-------");
    NSLog(@"【b】%p",&b);
    NSLog(@"【c】%p",&c);
    NSLog(@"【unassign】%@",^(int a ) {
        NSLog(@"%d",b);
        NSLog(@"%d",a);
    });
    
    NSLog(@"\n------堆区-------");
    globBlock = ^(int a ) {
        NSLog(@"%d",b);
        NSLog(@"%d",a);
    };
    tempBlock = ^(int a ) {
        NSLog(@"%d",b);
        NSLog(@"%d",a);
    };
    NSLog(@"【globBlock】%@",globBlock);
    NSLog(@"【tempBlock】%@",tempBlock);
    
    NSLog(@"\n------全局静态区-------");
    globBlock = ^(int a ) {
        NSLog(@"%d",a);
    };
    tempBlock = ^(int a ) {
        NSLog(@"%d",a);
    };
    NSLog(@"%@",^(int a ) {
        NSLog(@"%d",a);
    });
    NSLog(@"【globBlock】%@",globBlock);
    NSLog(@"【tempBlock】%@",tempBlock);
    NSLog(@"【static】%p",&d);
    tempBlock = [^(int a ) {
        NSLog(@"%d",a);
    } copy];
    NSLog(@"-【tempBlock】%@",tempBlock);
    
    
    NSLog(@"\n------常量区-------");
    NSLog(@"【constStr】%p",constStr);
}


@end
