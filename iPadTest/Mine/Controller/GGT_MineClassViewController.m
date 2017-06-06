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
@property(nonatomic, strong) NSMutableDictionary *result_list;
//剩余&总共课时
@property(nonatomic, strong) NSMutableDictionary *result_listGoods;

//由于section==2的时候，数据不固定，作为一个临时数据来添加到大数组中
@property (nonatomic, strong) NSMutableArray *tempContentArray;
//大的数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation GGT_MineClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _result_list = [NSMutableDictionary dictionary];
    _result_listGoods = [NSMutableDictionary dictionary];
    self.dataArray = [NSMutableArray array];
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
            
//            //如果无数据。展示缺省图，并终止下面的操作
//            if (IsArrEmpty(listGoodsArr) && IsArrEmpty(listArray)) {
//                [self.tableView.mj_footer endRefreshing];
//                [self.tableView.mj_header endRefreshing];
//                self.dataArray = [NSMutableArray array];
//                self.mineClassPlaceholderView.hidden = NO;
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                [self.tableView reloadData];
//                return ;
//            }
            
            
            NSMutableArray *headerArray = [NSMutableArray array];
            for (NSDictionary *dic in listGoodsArr) {
                [headerArray addObject:@{@"leftTitle":[NSString stringWithFormat:@"剩余%@课时",dic[@"SurplusCount"]],@"rightTitle":@""}];
                [headerArray addObject:@{@"leftTitle":[NSString stringWithFormat:@"总共%@课时",dic[@"TotalCount"]],@"rightTitle":[NSString stringWithFormat:@"有效期至:%@",dic[@"ExpireTime"]]}];
            }
            
            
            
            NSMutableArray *contentArray = [NSMutableArray array];
            for (NSDictionary *dic in listArray) {
                //1 购买课时 2报名课时  3返还课时
                if ([dic[@"types"] isEqual:@1]) {
                    [contentArray addObject:@{@"leftTitle":[NSString stringWithFormat:@"获赠%@课时",dic[@"classHour"]],@"rightTitle":dic[@"createTime"]}];
                    
                } else if ([dic[@"types"] isEqual:@2]) {
                    [contentArray addObject:@{@"leftTitle":[NSString stringWithFormat:@"报名%@课时",dic[@"classHour"]],@"rightTitle":dic[@"createTime"]}];
                    
                } else if ([dic[@"types"] isEqual:@3]) {
                    [contentArray addObject:@{@"leftTitle":[NSString stringWithFormat:@"返还%@课时",dic[@"classHour"]],@"rightTitle":dic[@"createTime"]}];
                }
            }
            NSLog(@"%@",contentArray);
            
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            
            [_tempContentArray addObjectsFromArray:contentArray];
            NSMutableArray *ma = [NSMutableArray array];
            ma = [NSMutableArray arrayWithObjects:headerArray,_tempContentArray, nil];
            self.dataArray = ma;
            [self.tableView reloadData];
            
            
            if (contentArray.count < 20 && _tempContentArray.count < 20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView reloadData];
                return ;
            }
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
//    if(indexPath.section == 0){
//        cell.classLeftLabel.text = _dataArray[0][indexPath.row][@"leftTitle"];
//        cell.classRightLabel.text = _dataArray[0][indexPath.row][@"rightTitle"];
//        //cell.textLabel.text = [NSString stringWithFormat:@"%@",self.result_list[@"SurplusCount"]];
//    }else{
//        cell.classLeftLabel.text = _dataArray[1][indexPath.row][@"leftTitle"];
//        cell.classRightLabel.text = _dataArray[1][indexPath.row][@"rightTitle"];
//    }
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
