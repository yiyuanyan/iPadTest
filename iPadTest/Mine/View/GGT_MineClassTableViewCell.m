//
//  GGT_MineClassTableViewCell.m
//  iPadTest
//
//  Created by 何建新 on 2017/6/3.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineClassTableViewCell.h"

@implementation GGT_MineClassTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initClassCell];
    }
    return self;
}
-(void)initClassCell
{
    self.classLeftLabel = [[UILabel alloc] init];
    self.classLeftLabel.font = Font(18);
    self.classLeftLabel.textColor = UICOLOR_FROM_HEX(Color3D3D3D);
    [self.classLeftLabel sizeToFit];
    [self.contentView addSubview:self.classLeftLabel];
    [self.classLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.height.mas_equalTo(25);
    }];
    self.classRightLabel = [[UILabel alloc] init];
    self.classRightLabel.font = Font(16);
    self.classRightLabel.textColor = UICOLOR_FROM_HEX(Color777777);
    [self.classRightLabel sizeToFit];
    [self.contentView addSubview:self.classRightLabel];
    [self.classRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(22);
    }];
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.height.mas_equalTo(1);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
