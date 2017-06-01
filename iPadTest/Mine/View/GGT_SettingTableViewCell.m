//
//  GGT_SettingTableViewCell.m
//  iPadTest
//
//  Created by Talk GoGo on 2017/6/1.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_SettingTableViewCell.h"

@implementation GGT_SettingTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initCell];
    }
    return self;
}
-(void)initCell
{
    self.cellLeftLabel = [[UILabel alloc] init];
    self.cellLeftLabel.font = Font(18);
    self.cellLeftLabel.textColor = UICOLOR_FROM_HEX(Color3D3D3D);
    [self.contentView addSubview:self.cellLeftLabel];
    [self.cellLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(LineX(20));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(LineH(25));
    }];
    self.cellRightLabel = [[UILabel alloc] init];
    self.cellRightLabel.textColor = UICOLOR_FROM_HEX(Color777777);
    self.cellRightLabel.font = Font(16);
    [self.contentView addSubview:self.cellRightLabel];
    [self.cellRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-LineX(5));
        make.height.mas_equalTo(LineH(22));
        make.centerY.equalTo(self.contentView.mas_centerY);
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
