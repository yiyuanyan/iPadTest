//
//  GGT_SettingViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//  设置

#import "GGT_SettingViewController.h"
#import "GGT_SettingTableViewCell.h"
#import "GGT_LoginViewController.h"
@interface GGT_SettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *loginOutButton;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation GGT_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    [self initTableView];
}
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(LineX(20), LineY(20), LineW(547), LineH(240)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置圆角
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 6;
    //禁止滚动
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorColor = UICOLOR_FROM_HEX(Color999999);
    [self.view addSubview:self.tableView];
    //添加数据
    _dataArray =  @[@"推送信息",@"清除缓存",@"前往AppStore评分",@"关于我们",@"当前版本"];
    //刷新tableview
    [_tableView reloadData];
    self.loginOutButton = [[UIButton alloc] init];
    [self.loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.loginOutButton setTitleColor:UICOLOR_FROM_HEX(0xB80011) forState:UIControlStateNormal];
    [self.loginOutButton addTarget:self action:@selector(loginOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginOutButton.layer.masksToBounds = YES;
    self.loginOutButton.layer.cornerRadius = 20;
    self.loginOutButton.layer.borderWidth = 1;
    self.loginOutButton.layer.borderColor = UICOLOR_FROM_HEX(0xB80011).CGColor;
    [self.view addSubview:self.loginOutButton];
    [self.loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).with.offset(LineY(40));
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(LineW(324), LineH(44)));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)loginOutButtonClick:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    alert.titleColor = UICOLOR_FROM_HEX(0x000000);
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    cancelAction.textColor = UICOLOR_FROM_HEX(Color777777);
    UIAlertAction *clernAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GGT_LoginViewController *loginVc = [[GGT_LoginViewController alloc] init];
        [UserDefaults() setObject:@"no" forKey:@"login"];
        [UserDefaults() setObject:@"" forKey:@"userToken"];
        [UserDefaults() synchronize];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVc];
        self.view.window.rootViewController = nav;
    }];
    clernAction.textColor = UICOLOR_FROM_HEX(ColorC40016);
    [alert addAction:cancelAction];
    [alert addAction:clernAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGT_SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selfCell"];
    if(cell == nil){
        cell = [[GGT_SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selfCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellLeftLabel.text = self.dataArray[indexPath.row];
    //选择开关
    if(indexPath.row == 0){
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(self.tableView.width-LineW(72), LineY(8.5), LineW(51), LineH(31))];
        [cell addSubview:sw];
        sw.on = YES;
    }
    if(indexPath.row == 1){
        cell.cellRightLabel.text = [NSString stringWithFormat:@"%.2fM",[self folderSize]];
    }
    if(indexPath.row == 4){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.cellRightLabel.text = [NSString stringWithFormat:@"v%@",app_Version];
        cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH(), 0, 0);
    }
    //箭头
    if(indexPath.row != 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LineH(48);
}
#pragma mark --  计算缓存和清除缓存
#pragma mark 计算缓存大小
// 缓存大小
- (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%@",cachePath);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0 /1024.0;
    
    return sizeM;
}
#pragma mark 清除缓存
- (void)removeCache{
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    //    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                //                [MBProgressHUD showMessage:@"" toView:self.view];
                GGT_SettingTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.cellRightLabel.text = [NSString stringWithFormat:@"0.0M"];
                
            } else {
                
                NSLog(@"清除失败");
                
            }
        }
    }
}
@end
