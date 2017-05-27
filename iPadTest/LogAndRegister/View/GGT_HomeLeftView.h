//
//  GGT_HomeLeftView.h
//  iPadTest
//
//  Created by Talk GoGo on 2017/5/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonClickBlock)(UIButton *button);
@interface GGT_HomeLeftView : UIView
@property(nonatomic, copy) ButtonClickBlock buttonClickBlock;
@property(nonatomic, strong) UIView *optionsView;
@end
