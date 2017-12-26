//
//  PresentRecordCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "PresentRecordCell.h"

@implementation PresentRecordCell

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
    UIImageView *spaceLine = [[UIImageView alloc] init];
    spaceLine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.contentView addSubview:spaceLine];
    [spaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.height.mas_equalTo(10);
        make.width.equalTo(self.contentView.mas_width);
        
    }];
    
    UILabel *order = [[UILabel alloc] init];
    order.font = [UIFont systemFontOfSize:16];
    order.text = @"订 单 号：";
    order.textAlignment = NSTextAlignmentLeft;
    [order setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:order];
    [order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spaceLine.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(80);
        
    }];
    
    _orderLabel = [[UILabel alloc] init];
    _orderLabel.font = [UIFont systemFontOfSize:16];
    _orderLabel.textAlignment = NSTextAlignmentLeft;
    [_orderLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_orderLabel];
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(order.mas_centerY);
        make.left.equalTo(order.mas_right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH-80);
        
    }];
    
    UILabel *account = [[UILabel alloc] init];
    account.font = [UIFont systemFontOfSize:16];
    account.text = @"账      号：";
    account.textAlignment = NSTextAlignmentLeft;
    [account setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:account];
    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(order.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(80);
        
    }];
    
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.font = [UIFont systemFontOfSize:16];
    _accountLabel.textAlignment = NSTextAlignmentLeft;
    [_accountLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_accountLabel];
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(account.mas_centerY);
        make.left.equalTo(account.mas_right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH-80);
        
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = [UIFont systemFontOfSize:24];
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    [_moneyLabel setTextColor:COLORFromRGB(0xe10000)];
    [self.contentView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(account.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(100);
        
    }];
    
    UILabel *money= [[UILabel alloc] init];
    money.font = [UIFont systemFontOfSize:14];
    money.textAlignment = NSTextAlignmentLeft;
    [money setTextColor:COLORFromRGB(0x333333)];
    money.text = @"提现金额";
    [self.contentView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).offset(8);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(80);
        
    }];

    _stateLabel = [[UILabel alloc] init];
    _stateLabel.font = [UIFont systemFontOfSize:16];
    _stateLabel.layer.masksToBounds = YES;
    _stateLabel.layer.cornerRadius = 3;
    _stateLabel.backgroundColor = COLORFromRGB(0xffa800);
//    _stateLabel.backgroundColor = COLORFromRGB(0x00c6c8);
//    _stateLabel.backgroundColor = COLORFromRGB(0xebebeb);

    _stateLabel.textAlignment = NSTextAlignmentCenter;
    [_stateLabel setTextColor:COLORFromRGB(0xffffff)];
    [self.contentView addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_moneyLabel.mas_centerY);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(137);
        make.height.mas_equalTo(16);
    }];

    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [_timeLabel setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(money.mas_centerY);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.right.equalTo(_stateLabel);

    }];
    
    
}
-(void)addDataSourceView:(PresentRecordModel*)model{
      _orderLabel.text = model.orderStr;
    _accountLabel.text = model.accountStr;
      _moneyLabel.text = model.moneyStr;
      _stateLabel.text = model.stateStr;
       _timeLabel.text = model.timeStr;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
