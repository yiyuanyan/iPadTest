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
    [self setNewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.3f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        if(finished){
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVc = newController;
        }else{
            self.currentVc = oldController;
        }
    }];
}
-(void)initView{
    @weakify(self);
    self.leftView = [[GGT_HomeLeftView alloc] init];
    self.leftView = [[GGT_HomeLeftView alloc]initWithFrame:CGRectMake(0, 0, LineW(home_leftView_width), SCREEN_HEIGHT())];
    [self.view addSubview:self.leftView];
    self.leftView.buttonClickBlock = ^(UIButton *button) {
        @strongify(self);
        switch (button.tag) {
            case 100:
                return;
//            {
//                if(self.currentVc == self.nav){
//                    return;
//                }else{
//                    [self replaceController:self.currentVc newController:self.nav];
//                }
//            }
                break;
            case 101:
            {
                if(self.currentVc == self.mineSplitVc){
                    return;
                }else{
                    [self replaceController:self.currentVc newController:self.mineSplitVc];
                }
            }
                break;
            default:
                break;
        }
    };
}
-(void)setNewController
{
    self.mineSplitVc = [[GGT_MineSplitViewController alloc] init];
    [self.mineSplitVc.view setFrame:CGRectMake(self.leftView.width, 0, SCREEN_WIDTH()-self.leftView.width, SCREEN_HEIGHT())];
    [self.view addSubview:self.mineSplitVc.view];
    self.currentVc = self.mineSplitVc;
}

@end
