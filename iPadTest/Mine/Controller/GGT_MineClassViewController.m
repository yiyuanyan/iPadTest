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
//获赠和报名课时
@property(nonatomic, strong) NSMutableArray *result_list;
//剩余&总共课时
@property(nonatomic, strong) NSMutableArray *result_listGoods;
@end

@implementation GGT_MineClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.result_list = [NSMutableArray array];
    self.result_listGoods = [NSMutableArray array];
    self.navigationItem.title = @"我的课时";
    self.view.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    [self initTableView];
    [self getLoadData];
}
-(void)getLoadData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?pageIndex=%d",URL_GetMyClassHour,1];
    [[BaseService share] sendGetRequestWithPath:urlStr token:YES viewController:self success:^(id responseObject) {
        if([responseObject[@"result"] isEqual:@1]){
            //总课时
            NSArray *listGoodsArr = responseObject[@"data"][@"result_listGoods"];
            
            NSArray *listArray = responseObject[@"data"][@"result_list"];
            [self.result_listGoods addObject:listGoodsArr];
            [self.result_list addObject:listArray];
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }
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
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGT_MineClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
    if(cell == nil){
        cell = [[GGT_MineClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == 0){
        [self cornCell:cell sideType:UIRectCornerTopLeft | UIRectCornerTopRight];
    }
    if(indexPath.row == 1){
        [self cornCell:cell sideType:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    }
    if(IsArrEmpty(self.result_listGoods)){
        
    }else{
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                cell.classLeftLabel.text = [NSString stringWithFormat:@"剩余%@课时",self.result_listGoods[0][0][@"SurplusCount"]];
            }
            if(indexPath.row == 1){
                cell.classLeftLabel.text = [NSString stringWithFormat:@"总共%@课时",self.result_listGoods[0][0][@"TotalCount"]];
                cell.classRightLabel.text = [NSString stringWithFormat:@"有效期至:%@",self.result_listGoods[0][0][@"ExpireTime"]];
            }
            
        }
        if(indexPath.section == 1){
            if(indexPath.row == 0){
                cell.classLeftLabel.text = [NSString stringWithFormat:@"获赠%@课时",self.result_list[0][0][@"classHour"]];
                cell.classRightLabel.text = [NSString stringWithFormat:@"%@",self.result_list[0][0][@"createTime"]];
            }else if(indexPath.row == 1){
                cell.classLeftLabel.text = [NSString stringWithFormat:@"报名%@课时",self.result_list[0][1][@"classHour"]];
                cell.classRightLabel.text = [NSString stringWithFormat:@"%@",self.result_list[0][1][@"createTime"]];
            }
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    //cell.textLabel.text = @"测试测试";
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
