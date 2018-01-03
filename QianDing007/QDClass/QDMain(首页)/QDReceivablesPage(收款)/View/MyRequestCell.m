//
//  MyRequestCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/27.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyRequestCell.h"

@implementation MyRequestCell

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

- (void)configCell{
    
    _merchantLabel = [[UILabel alloc] init];
    _merchantLabel.font = [UIFont systemFontOfSize:16];
    _merchantLabel.textAlignment = NSTextAlignmentLeft;
    [_merchantLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_merchantLabel];
    [_merchantLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(16);

    }];
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    [_userNameLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_merchantLabel.mas_centerY);
        make.left.equalTo(_merchantLabel.mas_right).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    
   UILabel *userTele = [[UILabel alloc] init];
    userTele.font = [UIFont systemFontOfSize:16];
    userTele.text = @"手机号码：";
    userTele.textAlignment = NSTextAlignmentLeft;
    [userTele setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:userTele];
    [userTele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_merchantLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(16);
        
    }];
    
    _userTeleLabele = [[UILabel alloc] init];
    _userTeleLabele.font = [UIFont systemFontOfSize:16];
    _userTeleLabele.textAlignment = NSTextAlignmentLeft;
    [_userTeleLabele setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_userTeleLabele];
    [_userTeleLabele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userTele.mas_centerY);
        make.left.equalTo(userTele.mas_right);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *address = [[UILabel alloc] init];
    address.font = [UIFont systemFontOfSize:16];
    address.text = @"地      址：";
    address.textAlignment = NSTextAlignmentLeft;
    [address setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userTele.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(16);
        
    }];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = [UIFont systemFontOfSize:16];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    [_addressLabel setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(address.mas_centerY);
        make.left.equalTo(address.mas_right);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(16);
        
    }];
    UILabel *activation = [[UILabel alloc] init];
    activation.font = [UIFont systemFontOfSize:16];
    activation.text = @"激活时间：";
    activation.textAlignment = NSTextAlignmentLeft;
    [activation setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:activation];
    [activation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(address.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(16);
        
    }];
    
    _activationLabel = [[UILabel alloc] init];
    _activationLabel.font = [UIFont systemFontOfSize:16];
    _activationLabel.textAlignment = NSTextAlignmentLeft;
    [_activationLabel setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_activationLabel];
    [_activationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(activation.mas_centerY);
        make.left.equalTo(activation.mas_right);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *receivables = [[UILabel alloc] init];
    receivables.font = [UIFont systemFontOfSize:16];
    receivables.text = @"收款：";
    receivables.textAlignment = NSTextAlignmentLeft;
    [receivables setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:receivables];
    [receivables mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(activation.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(50);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        
    }];
    
    _receivablesLabel = [[UILabel alloc] init];
    _receivablesLabel.font = [UIFont systemFontOfSize:16];
    _receivablesLabel.textAlignment = NSTextAlignmentLeft;
    [_receivablesLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_receivablesLabel];
    [_receivablesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(receivables.mas_centerY);
        make.left.equalTo(receivables.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0-100);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *list = [[UILabel alloc] init];
    list.font = [UIFont systemFontOfSize:16];
    list.text = @"订单：";
    list.textAlignment = NSTextAlignmentLeft;
    [list setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:list];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(receivables.mas_centerY);
        make.left.equalTo(self.contentView).offset(50+SC_WIDTH/2.0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        
    }];
    
    _listLabel = [[UILabel alloc] init];
    _listLabel.font = [UIFont systemFontOfSize:16];
    _listLabel.textAlignment = NSTextAlignmentLeft;
    [_listLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_listLabel];
    [_listLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(list.mas_centerY);
        make.left.equalTo(list.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0-100);
        make.height.mas_equalTo(16);
        
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
}
-(void)addDataSourceToCell:(MyRequestModel*) model{
    
    _merchantLabel.text = model.merchantNameStr;
    _userNameLabel.text = model.userNameStr;
    _userTeleLabele.text = model.userTeleStr;
    _addressLabel.text = model.addressStr;
    _activationLabel.text = model.activationTimeStr;
    _receivablesLabel.text = model.receivablesStr;
    //创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:model.receivablesStr];
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(0, secondLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xffa800) range:range];
    // 为label添加Attributed
    [_receivablesLabel setAttributedText:noteStr];
    
    
    _listLabel.text = model.listStr;
    // 创建Attributed
    NSMutableAttributedString *noteStrOne = [[NSMutableAttributedString alloc] initWithString:model.listStr];
    // 需要改变的最后一个文字的位置
    NSUInteger secondLocOne = [[noteStrOne string] rangeOfString:@"笔"].location;
    // 需要改变的区间
    NSRange rangeOne = NSMakeRange(0, secondLocOne);
    // 改变颜色
    [noteStrOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0x00c6c8) range:rangeOne];
    // 为label添加Attributed
    [_listLabel setAttributedText:noteStrOne];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
