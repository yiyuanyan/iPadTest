//
//  GGT_MineClassViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//  我的课时

#import "GGT_MineClassViewController.h"
#import "GGT_MineClassTableViewCell.h"
@interface GGT_MineClassViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation GGT_MineClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的课时";
    self.view.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    [self initTableView];
    [self getLoadData];
}
-(void)getLoadData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?pageIndex=%d",URL_GetMyClassHour,1];
    [[BaseService share] sendGetRequestWithPath:urlStr token:YES viewController:self success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(LineH(308));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 2;
    }else{
        return 4;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGT_MineClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if(cell == nil){
        cell = [[GGT_MineClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassCell"];
    }
    cell.textLabel.text = @"测试测试";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(48);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0){
        return 20;
    }else{
        return 0.01;
    }
}

@end
