//
//  LDModuleAVC.m
//  MainArch_Example
//
//  Created by 令达 on 2018/3/26.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#import "LDModuleAVC.h"
#import "LDModuleAVC1.h"
#import "UIViewController+LDNaviBar.h"
#import "LDConfigVCTool.h"

@interface LDModuleAVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LDModuleAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self ld_setNaviBarRightItemText:@"必须登录时用来测试，退出登录" color:[UIColor redColor] sel:@selector(loginOut)];
    self.ld_naviBarColor = [UIColor whiteColor];
}

- (IBAction)jump:(id)sender {
    UIViewController * vc = [LDModuleAVC1 new];
     [self.navigationController pushViewController:vc animated:YES];
}

- (void)loginOut
{
    //1.发网络请求告诉服务器
    //2.成功的回调处理本地缓存，然后再到切换控制器
    [LDConfigVCTool configLoginVCToRootVC];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath.row---%ld",(long)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
