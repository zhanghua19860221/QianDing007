//
//  UpProfitCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UpProfitCell.h"
@implementation UpProfitCell

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
    
    _iconImage= [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.mas_equalTo(SC_WIDTH-52);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        
    }];
    
    _userLabel= [[UILabel alloc] init];
    _userLabel.font = [UIFont systemFontOfSize:16];
    _userLabel.textAlignment = NSTextAlignmentLeft;
    [_userLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_userLabel];
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(16);
    }];
    
    _oldLevelLabel= [[UILabel alloc] init];
    _oldLevelLabel.font = [UIFont systemFontOfSize:16];
    _oldLevelLabel.text = @"原级别：";
    _oldLevelLabel.textAlignment = NSTextAlignmentLeft;
    [_oldLevelLabel setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_oldLevelLabel];
    [_oldLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(16);

    }];
    _oldLevelLabelOne= [[UILabel alloc] init];
    _oldLevelLabelOne.font = [UIFont systemFontOfSize:16];
    _oldLevelLabelOne.textAlignment = NSTextAlignmentLeft;
    [_oldLevelLabelOne setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_oldLevelLabelOne];
    [_oldLevelLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_oldLevelLabel.mas_centerY);
        make.left.equalTo(_oldLevelLabel.mas_right);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];

    _payStr= [[UILabel alloc] init];
    _payStr.font = [UIFont systemFontOfSize:16];
    _payStr.textAlignment = NSTextAlignmentLeft;
    _payStr.text = @"支    付：";
    [self.contentView addSubview:_payStr];
    [_payStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldLevelLabel.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(16);
    }];

    
    _payStrOne= [[UILabel alloc] init];
    _payStrOne.font = [UIFont systemFontOfSize:16];
    _payStrOne.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_payStrOne];
    [_payStrOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_payStr.mas_centerY);
        make.left.equalTo(_payStr.mas_right);
        make.width.mas_equalTo(_oldLevelLabelOne.mas_width);
        make.height.mas_equalTo(16);
        
    }];

    
    _upStrLabel= [[UILabel alloc] init];
    _upStrLabel.font = [UIFont systemFontOfSize:16];
    _upStrLabel.textAlignment = NSTextAlignmentLeft;
    _upStrLabel.text = @"升级为：";
    [self.contentView addSubview:_upStrLabel];
    [_upStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_oldLevelLabel.mas_centerY);
        make.left.mas_equalTo(SC_WIDTH-153);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(16);
        
    }];
    
    _upStrLabelOne= [[UILabel alloc] init];
    _upStrLabelOne.font = [UIFont systemFontOfSize:16];
    _upStrLabelOne.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_upStrLabelOne];
    [_upStrLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_upStrLabel.mas_centerY);
        make.left.equalTo(_upStrLabel.mas_right);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
    }];
   
    _profitLabel= [[UILabel alloc] init];
    _profitLabel.font = [UIFont systemFontOfSize:16];
    _profitLabel.text = @"分    润：";
    _profitLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_profitLabel];
    [_profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_payStr.mas_centerY);
        make.left.mas_equalTo(SC_WIDTH-153);
        make.width.height.equalTo(_payStr);
        
    }];
    
    _profitLabelOne= [[UILabel alloc] init];
    _profitLabelOne.font = [UIFont systemFontOfSize:16];
    _profitLabelOne.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_profitLabelOne];
    [_profitLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_profitLabel.mas_centerY);
        make.left.mas_equalTo(_profitLabel.mas_right);
        make.width.mas_equalTo(_upStrLabelOne.mas_width);
        make.height.mas_equalTo(16);
        
    }];

}
-(void)addDataSourceView:(MyProfitModel*)model{
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[model.timeStr intValue]];
    NSString *tempTime = [stampFormatter stringFromDate:stampDate2];

    _timeLabel.text = tempTime;
    
    _userLabel.text = model.userStr;
    _oldLevelLabelOne.text = model.oldLevelStr;
    _payStrOne.text = model.payStr;
    
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:model.payStr];
    
    // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(0, secondLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:range];
    // 为label添加Attributed
    [_payStrOne setAttributedText:noteStr];
    
    
    _upStrLabelOne.text = model.upStr;
    _profitLabelOne.text = model.profitStr;

    
    // 创建Attributed
    NSMutableAttributedString *noteStrOne = [[NSMutableAttributedString alloc] initWithString:model.profitStr];
    // 需要改变的最后一个文字的位置
    NSUInteger secondLocOne = [[noteStrOne string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange rangeOne = NSMakeRange(0, secondLocOne);
    // 改变颜色
    [noteStrOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
    // 为label添加Attributed
    [_profitLabelOne setAttributedText:noteStrOne];
    [_iconImage setImage:[UIImage imageNamed:@"椭圆1"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
