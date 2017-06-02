//
//  GGT_SelfInfoViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//  个人信息

#import "GGT_SelfInfoViewController.h"
#import "GGT_SelfInfoTableViewCell.h"
#import "GGT_selfInfoModel.h"
@interface GGT_SelfInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *leftTitleArray;
@property(nonatomic, strong) NSMutableArray *leftSubTitleArray;
@property(nonatomic, strong) GGT_selfInfoModel *selfInfoModel;
@end

@implementation GGT_SelfInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    self.navigationItem.title = @"个人信息";
    [self initTableView];
    [self getUserInfoData];
}
-(void)getUserInfoData
{
    [[BaseService share] sendGetRequestWithPath:URL_GetStudentInfo token:YES viewController:self success:^(id responseObject) {
        if([responseObject[@"result"] isEqual:@1]){
            _selfInfoModel = [GGT_selfInfoModel yy_modelWithDictionary:responseObject[@"data"]];
            _leftSubTitleArray = [NSMutableArray array];
            NSArray *arr1 = @[_selfInfoModel.Mobile,_selfInfoModel.NameEn,_selfInfoModel.NameEn,_selfInfoModel.Gender, [_selfInfoModel.Birthday substringWithRange:NSMakeRange(0, 10)]];
            NSArray *arr2 = @[_selfInfoModel.FatherName,_selfInfoModel.RealName,@""];
            _leftSubTitleArray = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
            [_tableView reloadData];
        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)initTableView{
    _leftTitleArray = @[@[@"账号信息",@"英文名",@"中文名",@"性别",@"生日"],@[@"父母称呼",@"所在地",@"修改密码"]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(LineH(405));
    }];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 5;
    }else{
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0.01;
    }else{
        return 20;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGT_SelfInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if(cell == nil){
        cell = [[GGT_SelfInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0 && indexPath.row == 0){
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.selfSubLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.mas_right).with.offset(-32);
        }];
    }
    if((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0)){
        [self cornCell:cell sideType:UIRectCornerTopRight | UIRectCornerTopLeft];
    }
    if((indexPath.section == 0 && indexPath.row == 4) ||(indexPath.section == 1 && indexPath.row == 2)){
        [self cornCell:cell sideType:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    }
    if((indexPath.section == 0 && indexPath.row == 4) || (indexPath.section == 1 && indexPath.row == 2)){
        cell.lineView.hidden = YES;
    }
    cell.backgroundColor = UICOLOR_FROM_HEX(ColorFFFFFF);
    cell.selfLabel.text = _leftTitleArray[indexPath.section][indexPath.row];
    cell.selfSubLabel.text = _leftSubTitleArray[indexPath.section][indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(48);
}
//设置cell的圆角
//[self cornCell:cell sideType:UIRectCornerTopLeft|UIRectCornerTopRight];
- (void)cornCell:(UITableViewCell *)cell sideType:(UIRectCorner)corners
{
    CGSize cornerSize = CGSizeMake(LineX(6), LineH(6));
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _tableView.width, LineH(48)) byRoundingCorners:corners cornerRadii:cornerSize];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, _tableView.width, LineH(48));
    maskLayer.path = maskPath.CGPath;
    cell.layer.mask = maskLayer;
    [cell.layer setMasksToBounds:YES];
}
@end
