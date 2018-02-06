//
//  MyGetProfitCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyGetProfitCell.h"

@implementation MyGetProfitCell

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
    
    _timeLabel= [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    [_timeLabel setTextColor:COLORFromRGB(0x999999)];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH/2.0);
    }];
    
    
    _levelLabel= [[UILabel alloc] init];
    _levelLabel.font = [UIFont systemFontOfSize:14];
    _levelLabel.textAlignment = NSTextAlignmentRight;
    [_levelLabel setTextColor:COLORFromRGB(0x999999)];
    [self.contentView addSubview:_levelLabel];
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLabel.mas_centerY);
        make.left.equalTo(self.contentView).offset(SC_WIDTH-80);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(14);
        
    }];
    
    _iconImage= [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_levelLabel.mas_centerY);
        make.right.equalTo(_levelLabel.mas_left);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        
    }];
    
    _userLabel= [[UILabel alloc] init];
    _userLabel.font = [UIFont systemFontOfSize:16];
    _userLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_userLabel];
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(16);
    }];
    
    _getMoneyLabel= [[UILabel alloc] init];
    _getMoneyLabel.font = [UIFont systemFontOfSize:16];
    _getMoneyLabel.text = @"收款：";
    _getMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_getMoneyLabel];
    [_getMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
    }];
    
    _getMoneyLabelOne= [[UILabel alloc] init];
    _getMoneyLabelOne.font = [UIFont systemFontOfSize:16];
    _getMoneyLabelOne.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_getMoneyLabelOne];
    [_getMoneyLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_getMoneyLabel.mas_centerY);
        make.left.equalTo(_getMoneyLabel.mas_right);
        make.width.mas_equalTo(_userLabel.mas_width);
        make.height.mas_equalTo(16);
    }];
    
    _profitLabelOne= [[UILabel alloc] init];
    _profitLabelOne.font = [UIFont systemFontOfSize:16];
    _profitLabelOne.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_profitLabelOne];
    [_profitLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_getMoneyLabel.mas_centerY);
        make.right.equalTo(_levelLabel.mas_right);
        make.width.mas_equalTo(_levelLabel.mas_width);
        make.height.mas_equalTo(16);
    }];
    
    _profitLabel= [[UILabel alloc] init];
    _profitLabel.font = [UIFont systemFontOfSize:16];
    _profitLabel.text = @"分润：";
    _profitLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_profitLabel];
    [_profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_profitLabelOne.mas_centerY);
        make.right.equalTo(_profitLabelOne.mas_left);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        
    }];
    

    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-1);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SC_WIDTH-15);
        
    }];
    
}
-(void)addDataSourceView:(MyGetProfitModel*)model{
    
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd  HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    NSString *tempTime = [stampFormatter stringFromDate:stampDate2];
    
    
    _timeLabel.text = tempTime;
    _userLabel.text = model.supplier_name;
    
    
    
    NSString *moneyLabelOne = [NSString stringWithFormat:@"%@元",model.collect];
    _getMoneyLabelOne.text = moneyLabelOne;
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:moneyLabelOne];
    
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(0, secondLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:range];
    // 为label添加Attributed
    [_getMoneyLabelOne setAttributedText:noteStr];
    
    
    
    _levelLabel.text = model.supplier_level_name;
    
    _profitLabelOne.text = model.distribute;
    // 创建Attributed
    NSMutableAttributedString *noteStrOne = [[NSMutableAttributedString alloc] initWithString:model.distribute];
    // 需要改变的最后一个文字的位置
    NSUInteger secondLocOne = noteStrOne.length-1;
    // 需要改变的区间
    NSRange rangeOne = NSMakeRange(0, secondLocOne);
    // 改变颜色
    [noteStrOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
    // 为label添加Attributed
    [_profitLabelOne setAttributedText:noteStrOne];

    if ([model.supplier_level isEqualToString:@"1"]) {
        [_iconImage setImage:[UIImage imageNamed:@"普通会员"]];

    }else if ([model.supplier_level isEqualToString:@"2"]){
        [_iconImage setImage:[UIImage imageNamed:@"银牌会员44*44"]];

    }else if ([model.supplier_level isEqualToString:@"3"]){
        [_iconImage setImage:[UIImage imageNamed:@"金牌会员44*44"]];

    }else if ([model.supplier_level isEqualToString:@"4"]){
        [_iconImage setImage:[UIImage imageNamed:@"钻石会员44*44"]];

    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
