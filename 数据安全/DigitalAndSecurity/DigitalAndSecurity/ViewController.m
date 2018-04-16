//
//  ViewController.m
//  DigitalAndSecurity
//
//  Created by ld on 2017/12/1.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ViewController.h"
#import "NSData+ByteOrderCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber * num1 = [NSNumber numberWithInt:3];
    NSNumber * num2 = [NSNumber numberWithLong:3];
    NSNumber * num3 = [NSNumber numberWithLongLong:3];
    const char * type = @encode(int);
    const char * type1 = [num1 objCType];
    const char * type2 = [num2 objCType];
    const char * type3 = [num3 objCType];
    NSLog(@"dd");
}



@end
