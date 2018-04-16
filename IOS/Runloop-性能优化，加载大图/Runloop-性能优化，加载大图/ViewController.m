//
//  ViewController.m
//  Runloop-性能优化，加载大图
//
//  Created by codepgq on 2017/2/28.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "LDRunloop.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[LDRunloop shareInstance] removeAllTasks];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell = [MyCell cell:tableView];
    [cell loadData];
    return cell;
}


@end
