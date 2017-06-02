//
//  GGT_SelfInfoTableViewCell.m
//  iPadTest
//
//  Created by 何建新 on 2017/6/2.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_SelfInfoTableViewCell.h"

@implementation GGT_SelfInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initCellView];
    }
    return self;
}
-(void)initCellView
{
    self.selfLabel = [[UILabel alloc] init];
    self.selfLabel.textColor = UICOLOR_FROM_HEX(Color3D3D3D);
    self.selfLabel.font = Font(18);
    [self.contentView addSubview:self.selfLabel];
    [self.selfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(LineX(20));
    }];
    self.selfSubLabel = [[UILabel alloc] init];
    self.selfSubLabel.textColor = UICOLOR_FROM_HEX(Color777777);
    self.selfSubLabel.font = Font(16);
    [self.contentView addSubview:self.selfSubLabel];
    [self.selfSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
    }];
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    self.lineView = lineView;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
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
