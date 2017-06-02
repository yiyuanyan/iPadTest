//
//  GGT_MineSplitViewController.m
//  iPadTest
//
//  Created by Talk GoGo on 2017/5/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineSplitViewController.h"
#import "GGT_MineLeftViewController.h"
#import "GGT_MineRightViewController.h"
#import "BaseViewController.h"
@interface GGT_MineSplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation GGT_MineSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    GGT_MineLeftViewController *leftVc = [[GGT_MineLeftViewController alloc] init];
    GGT_MineRightViewController *rightVc = [[GGT_MineRightViewController alloc] init];
    BaseNavigationController *detailNav = [[BaseNavigationController alloc] initWithRootViewController:rightVc];
    self.viewControllers = @[leftVc,detailNav];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
