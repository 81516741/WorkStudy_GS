//
//  ViewController.m
//  测试数据包装NSNumber的相关问题
//
//  Created by lingda on 2017/12/7.
//  Copyright © 2017年 lingda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    char a = 'a';
    short b = 1;
    int c = 1;
    long d = 1;
    long long e = 1;
    
    NSNumber * aa = [NSNumber numberWithChar:a];
    NSNumber * bb = [NSNumber numberWithShort:b];
    NSNumber * cc = [NSNumber numberWithInt:c];
    NSNumber * dd = [NSNumber numberWithLong:d];
    NSNumber * ee = [NSNumber numberWithLongLong:e];
    
    const char * aaa = [aa objCType];
    //在32位系统下  以下值全是 'i'  在64位则比较准 除了 long  和 long long分不清
    const char * bbb = [bb objCType];
    const char * ccc = [cc objCType];
    const char * ddd = [dd objCType];
    const char * eee = [ee objCType];
    
    
    const char * charType = @encode(char);//'c'
    const char * shortType = @encode(short);//'s'
    const char * intType = @encode(int);//'i'
    //64位下比较准确 但是下面2个是一样的 'q'
    const char * longType = @encode(long);
    const char * longlongType = @encode(long long);
    NSLog(@"d");
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
