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
    
    _payAccountLabel = [[UILabel alloc] init];
    _payAccountLabel.frame = CGRectZero;
    _payAccountLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payAccountLabel];
    [_payAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH-30/SCALE_X);
        
    }];
    
    _payTimeLabel = [[UILabel alloc] init];
    _payTimeLabel.frame = CGRectZero;
    _payTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payTimeLabel];
    [_payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payAccountLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH-30/SCALE_X);
        
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
    if ([model.tran_result isEqualToString:@"1"]) {
        _stateLabel.text = @"状态：处理成功";

    }else if ([model.tran_result isEqualToString:@"0"]){
        _stateLabel.text = @"状态：处理中";

    }else if ([model.tran_result isEqualToString:@"3"]){
        _stateLabel.text = @"状态：收款账号为null";
        
    }else if ([model.tran_result isEqualToString:@"4"]){
        _stateLabel.text = @"状态：退票";
        
    }else if ([model.tran_result isEqualToString:@"5"]){
        _stateLabel.text = @"状态：失败";
        
    }
    NSString *order_no = [NSString stringWithFormat:@"订单编号：%@",model.order_no];
    _payAccountLabel.text = order_no;
    
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[model.pay_time intValue]];
    NSString *orderTime = [stampFormatter stringFromDate:stampDate2];
    
    
    NSString *pay_time = [NSString stringWithFormat:@"付款时间：%@",orderTime];
    _payTimeLabel.text = pay_time;

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
