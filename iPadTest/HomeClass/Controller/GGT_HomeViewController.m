//
//  GGT_HomeViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_HomeViewController.h"
#import "BaseNavigationController.h"
#import "GGT_HomeLeftView.h"
#import "GGT_MineSplitViewController.h"
@interface GGT_HomeViewController ()<UIPopoverPresentationControllerDelegate>
//左侧view
@property(nonatomic, strong) GGT_HomeLeftView *leftView;
//splitView
@property(nonatomic, strong) GGT_MineSplitViewController *mineSplitVc;
//导航栏
@property(nonatomic, strong) BaseNavigationController *nav;
//当先显示的右侧控制器
@property(nonatomic, strong) UIViewController *currentVc;

@end

@implementation GGT_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initView{
    self.leftView = [[GGT_HomeLeftView alloc] init];
    self.leftView = [[GGT_HomeLeftView alloc]initWithFrame:CGRectMake(0, 0, LineW(home_leftView_width), SCREEN_HEIGHT())];
    [self.view addSubview:self.leftView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
