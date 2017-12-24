//
//  UserListCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UserListCell.h"

@implementation UserListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
    }
    return self;
}
-(void)configCell{
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    [_userNameLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
    }];

    _mebIconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_mebIconView];
    [_mebIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userNameLabel.mas_centerY);
        make.left.mas_equalTo(SC_WIDTH-104);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        
    }];
    
    _mebLevelLabel = [[UILabel alloc] init];
    _mebLevelLabel.font = [UIFont systemFontOfSize:14];
    _mebLevelLabel.textAlignment = NSTextAlignmentLeft;
    [_mebLevelLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_mebLevelLabel];
    [_mebLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_userNameLabel.mas_centerY);
        make.left.equalTo(_mebIconView.mas_right).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
            
    }];

    _teleLabel = [[UILabel alloc] init];
    _teleLabel.font = [UIFont systemFontOfSize:16];
    _teleLabel.text = @"手        机：";
    _teleLabel.textAlignment = NSTextAlignmentLeft;
    [_teleLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_teleLabel];
    [_teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(16);
    }];
    
    _teleLabelOne = [[UILabel alloc] init];
    _teleLabelOne.font = [UIFont systemFontOfSize:16];
    _teleLabelOne.textAlignment = NSTextAlignmentLeft;
    [_teleLabelOne setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_teleLabelOne];
    [_teleLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_teleLabel.mas_centerY);
        make.left.equalTo(_teleLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(16);
    }];
    
    _allMoneyLabel = [[UILabel alloc] init];
    _allMoneyLabel.font = [UIFont systemFontOfSize:16];
    _allMoneyLabel.text = @"总  收  款：";
    _allMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [_allMoneyLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_allMoneyLabel];
    [_allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_teleLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(16);
    }];
    _allMoneyLabelOne = [[UILabel alloc] init];
    _allMoneyLabelOne.font = [UIFont systemFontOfSize:16];
    _allMoneyLabelOne.textAlignment = NSTextAlignmentLeft;
    [_allMoneyLabelOne setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_allMoneyLabelOne];
    [_allMoneyLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_allMoneyLabel.mas_centerY);
        make.left.equalTo(_allMoneyLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(16);
    }];
    
    _openTimeLabel = [[UILabel alloc] init];
    _openTimeLabel.font = [UIFont systemFontOfSize:16];
    _openTimeLabel.text = @"开通时间：";
    _openTimeLabel.textAlignment = NSTextAlignmentLeft;
    [_openTimeLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_openTimeLabel];
    [_openTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allMoneyLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(16);
    }];
    
    _openTimeLabelOne = [[UILabel alloc] init];
    _openTimeLabelOne.font = [UIFont systemFontOfSize:16];
    _openTimeLabelOne.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_openTimeLabelOne];
    [_openTimeLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_openTimeLabel.mas_centerY);
        make.left.equalTo(_openTimeLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(16);
    }];

    
}
-(void)addDataSourceView:(UserListModel*)model{
    
    _userNameLabel.text = model.userNameStr;
    _teleLabelOne.text  = model.teleStr;
    _allMoneyLabelOne.text = model.allMoneyStr;
    _openTimeLabelOne.text = model.openTimeStr;
    _mebLevelLabel.text = model.mebLevelStr;
    [_mebIconView setImage:[UIImage imageNamed:model.mebIconStr]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
