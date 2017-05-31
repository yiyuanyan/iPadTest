//
//  GGT_SettingViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//  设置

#import "GGT_SettingViewController.h"

@interface GGT_SettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation GGT_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    [self initTableView];
}
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(LineX(20), LineY(20), LineW(547), LineH(240)) style:UITableViewStylePlain];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - TableView

@end
