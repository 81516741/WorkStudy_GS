//
//  MyCell.m
//  Runloop-性能优化，加载大图
//
//  Created by lingda on 2017/11/8.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "MyCell.h"
#import "LDRunloop.h"

@implementation MyCell

static NSString * const kMyCell = @"MyCell";
+ (instancetype)cell:(UITableView *)tableView
{
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:kMyCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:kMyCell owner:nil options:nil]lastObject];
    }
    return cell;
}

-(void)loadData
{
    [[LDRunloop shareInstance]  addTask:^BOOL{
        self.image0.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image1.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image2.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image3.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image4.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image5.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image6.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image7.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image8.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image9.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image10.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image11.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image12.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image13.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image14.image = [UIImage imageNamed:@"spaceship.jpg"];
        self.image15.image = [UIImage imageNamed:@"spaceship.jpg"];
        return YES;
    }];
}

@end
