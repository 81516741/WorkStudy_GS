//
//  ProblemClass.m
//  Hotfix
//
//  Created by 令达 on 2018/4/13.
//  Copyright © 2018年 令达. All rights reserved.
//

#import "ProblemClass.h"
#import "TestObject.h"

@implementation ProblemClass

- (float)divideUsingDenominator:(NSInteger)denominator
{
    [TestObject log:@"sdd" str:@"3333"];
    float value =  1.f/denominator;
    return value;
}

@end
