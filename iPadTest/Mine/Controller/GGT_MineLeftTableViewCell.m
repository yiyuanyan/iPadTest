//
//  GGT_MineLeftTableViewCell.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineLeftTableViewCell.h"

@implementation GGT_MineLeftTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}
-(void)setIconName:(NSString *)iconName
{
    _iconName = iconName;
    self.iconImgView.image = UIIMAGE_FROM_NAME(self.iconName);
}
-(void)initView{
    self.iconImgView = [[UIImageView alloc] init];
    self.iconImgView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(LineX(31));
        make.size.mas_equalTo(CGSizeMake(LineW(20), LineH(22)));
    }];
    
    self.leftTitleLabel = [[UILabel alloc] init];
    self.leftTitleLabel.font = Font(18);
    self.leftTitleLabel.textColor = UICOLOR_FROM_HEX(Color3D3D3D);
    [self.contentView addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.iconImgView.mas_right).with.offset(LineX(10));
        make.width.mas_equalTo(LineW(75));
        make.height.mas_equalTo(LineH(25));
        //make.size.mas_offset(CGSizeMake(LineW(72), LineH(25)));
    }];
    self.leftSubTitleLabel = [[UILabel alloc] init];
    self.leftSubTitleLabel.font = Font(14);
    self.leftSubTitleLabel.textColor = UICOLOR_FROM_HEX(Color777777);
    [self.contentView addSubview:self.leftSubTitleLabel];
    [self.leftSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-LineX(19));
        make.height.mas_equalTo(LineH(20));
    }];
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UICOLOR_FROM_HEX(ColorF2F2F2);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
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
