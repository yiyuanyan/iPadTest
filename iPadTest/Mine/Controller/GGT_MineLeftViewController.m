//
//  GGT_MineLeftViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineLeftViewController.h"
#import "GGT_MineRightViewController.h"
#import "GGT_SelfInfoViewController.h"
#import "GGT_MineClassViewController.h"
#import "GGT_FeedbackViewController.h"
#import "GGT_TestReportViewController.h"
#import "GGT_SettingViewController.h"
#import "BaseNavigationController.h"
#import "GGT_MineHeaderView.h"
#import "GGT_MineLeftTableViewCell.h"
#import "GGT_MineLeftMode.h"
@interface GGT_MineLeftViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSArray *iconArray;
@property(nonatomic, strong) GGT_MineHeaderView *headerView;
@property(nonatomic, strong) GGT_MineLeftMode *model;
@end

@implementation GGT_MineLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLoadData];
    [self initTableView];
    [self initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getLoadData
{
    [[BaseService share] sendGetRequestWithPath:URL_GetLessonStatistics token:YES viewController:self success:^(id responseObject) {
        if([responseObject[@"result"] isEqual:@1]){
            _model = [GGT_MineLeftMode yy_modelWithDictionary:responseObject[@"data"]];
            //数据传递给模型
            [_headerView getResultModel:_model];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LineW(351), SCREEN_HEIGHT()) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UICOLOR_FROM_HEX(ColorFFFFFF);
    [self.view addSubview:self.tableView];
    
    self.headerView = [[GGT_MineHeaderView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, LineW(350), LineH(275));
    self.tableView.tableHeaderView = self.headerView;
}
-(void)initDataSource
{
    self.splitViewController.maximumPrimaryColumnWidth = LineW(350);
    self.splitViewController.preferredPrimaryColumnWidthFraction = 0.48;
    _dataArray = @[@"个人信息",@"我的课时",@"测评报告",@"意见反馈",@"设置"];
    _iconArray = @[@"Personal_information",@"class",@"Test_report",@"feedback",@"Set_up_the"];
    [self.tableView reloadData];
    //默认选中第一行
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionNone)];
}
#pragma mark --TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGT_MineLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[GGT_MineLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    }
    cell.backgroundColor = UICOLOR_FROM_HEX(ColorFFFFFF);
    cell.leftTitleLabel.text = _dataArray[indexPath.row];
    if(indexPath.row == 1){
        cell.leftSubTitleLabel.text = _model.totalCount;
    }
    cell.iconName = self.iconArray[indexPath.row];
    if(indexPath.row == 0){
        GGT_SelfInfoViewController *vc = [[GGT_SelfInfoViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self.splitViewController showDetailViewController:nav sender:self];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(60);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
            //个人信息
            vc = [[GGT_SelfInfoViewController alloc] init];
            break;
        case 1:
            //我的课时
            vc = [[GGT_MineClassViewController alloc] init];
            break;
        case 2:
            //测评报告
            vc = [[GGT_TestReportViewController alloc] init];
            break;
        case 3:
            //意见反馈
            vc = [[GGT_FeedbackViewController alloc] init];
            break;
        case 4:
            //设置
            vc = [[GGT_SettingViewController alloc] init];
            break;
        default:
            break;
    }
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.splitViewController showDetailViewController:nav sender:self];
}
@end
