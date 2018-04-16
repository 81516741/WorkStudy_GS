//
//  MyCell.h
//  Runloop-性能优化，加载大图
//
//  Created by lingda on 2017/11/8.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
+ (instancetype)cell:(UITableView *)tableView;@property (weak, nonatomic) IBOutlet UIImageView *image0;

@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;
@property (weak, nonatomic) IBOutlet UIImageView *image7;
@property (weak, nonatomic) IBOutlet UIImageView *image8;
@property (weak, nonatomic) IBOutlet UIImageView *image9;
@property (weak, nonatomic) IBOutlet UIImageView *image10;
@property (weak, nonatomic) IBOutlet UIImageView *image11;
@property (weak, nonatomic) IBOutlet UIImageView *image12;
@property (weak, nonatomic) IBOutlet UIImageView *image13;
@property (weak, nonatomic) IBOutlet UIImageView *image14;
@property (weak, nonatomic) IBOutlet UIImageView *image15;
- (void)loadData;
@end
