//
//  ForntTabelCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ForntTabelCell.h"

@implementation ForntTabelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
    }
    return self;
}

- (void)configCell{
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.frame = CGRectZero;
    _moneyLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    _centuryLabel = [[UILabel alloc] init];
    _centuryLabel.frame = CGRectZero;
    _centuryLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_centuryLabel];
    [_centuryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(_moneyLabel.mas_right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    
    _payLabel = [[UILabel alloc] init];
    _payLabel.frame = CGRectZero;
    _payLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_payLabel];
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.frame = CGRectZero;
    _stateLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centuryLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(_payLabel.mas_right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    UILabel * accountLabel = [[UILabel alloc] init];
    accountLabel.font = [UIFont systemFontOfSize:12];
    accountLabel.text = @"订单编号";
    [self.contentView addSubview:accountLabel];
    [accountLabel setTextColor:COLORFromRGB(0x999999)];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(63);
        
    }];
    
    _payAccountLabel = [[UILabel alloc] init];
    _payAccountLabel.frame = CGRectZero;
    _payAccountLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payAccountLabel];
    [_payAccountLabel setTextColor:COLORFromRGB(0x333333)];
    [_payAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(accountLabel.mas_centerY);
        make.left.equalTo(accountLabel.mas_right);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH-100);
        
    }];

    _payLabelone = [[UILabel alloc] init];
    _payLabelone.frame = CGRectZero;
    _payLabelone.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payLabelone];
    [_payLabelone setTextColor:COLORFromRGB(0x999999)];
    [_payLabelone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payAccountLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(63);
        
    }];
    
    _payTimeLabel = [[UILabel alloc] init];
    _payTimeLabel.frame = CGRectZero;
    _payTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payTimeLabel];
    [_payTimeLabel setTextColor:COLORFromRGB(0x333333)];
    [_payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_payLabelone.mas_centerY);
        make.left.equalTo(_payLabelone.mas_right);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH-100);
        
    }];
    

    

    _backMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    _backMoney.frame = CGRectZero;
    [_backMoney setTitle:@"退 款" forState:UIControlStateNormal];
    _backMoney.titleLabel.font = [UIFont systemFontOfSize:14];
    [_backMoney setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _backMoney.layer.borderColor = [[UIColor redColor] CGColor];
    _backMoney.layer.borderWidth = 1 ;
    [self.contentView addSubview:_backMoney];


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
-(void)addDataSourceToCell:(RecordMoneyModel*) model{
    
    NSString *payment = [NSString stringWithFormat:@"付款金额：%@",model.payment];
    _moneyLabel.text = payment;
    NSString *effective = [NSString stringWithFormat:@"实  收：%@",model.effective];
    _centuryLabel.text = effective;
    NSString *channel_flag = [NSString stringWithFormat:@"付款方式：%@",model.channel_flag];
    _payLabel.text = channel_flag;
    
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd  HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[model.pay_time intValue]];
    NSString *orderTime = [stampFormatter stringFromDate:stampDate2];
    
    if ([model.tran_result isEqualToString:@"1"]) {
        _stateLabel.text = @"状  态：已到账";
        _payLabelone.text = @"到账时间";
        _payTimeLabel.text = orderTime;

    }else if ([model.tran_result isEqualToString:@"0"]){
        _stateLabel.text = @"状  态：处理中";
        _payLabelone.text = @"付款时间";
        _payTimeLabel.text = orderTime;

    }else if ([model.tran_result isEqualToString:@"3"]){
        _stateLabel.text = @"状  态：未到账";
        _payLabelone.text = @"到账时间";
        _payTimeLabel.text = orderTime;
        
    }else if ([model.tran_result isEqualToString:@"4"]){
        _stateLabel.text = @"状  态：退票";
        _payLabelone.text = @"退款时间";
        _payTimeLabel.text = orderTime;
        
    }else if ([model.tran_result isEqualToString:@"5"]){
        _stateLabel.text = @"状  态：失败";
        _payLabelone.text = @"到账时间";
        _payTimeLabel.text = orderTime;
    }
    _payAccountLabel.text = model.order_no;
    

    
    if ([model.tran_result isEqualToString:@"0"]) {
        [_backMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(SC_WIDTH-95);
            make.bottom.equalTo(self.contentView).offset(-30);
            make.height.mas_equalTo(27);
            make.width.mas_equalTo(70);
            
        }];
    }
    
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
