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
    _moneyLabel.text = @"付款金额：234.00";
    _moneyLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_moneyLabel];
    
    _centuryLabel = [[UILabel alloc] init];
    _centuryLabel.frame = CGRectZero;
    _centuryLabel.text = @"实  收：230.00";
    _centuryLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_centuryLabel];
    
    _payLabel = [[UILabel alloc] init];
    _payLabel.frame = CGRectZero;
    _payLabel.text = @"付款方式：微信";
    _payLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_payLabel];
    
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.frame = CGRectZero;
    _stateLabel.text = @"状态：处理中";
    _stateLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_stateLabel];
    
    _payAccountLabel = [[UILabel alloc] init];
    _payAccountLabel.frame = CGRectZero;
    _payAccountLabel.text = @"付款账户：000XXX";
    _payAccountLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payAccountLabel];
    
    _payTimeLabel = [[UILabel alloc] init];
    _payTimeLabel.frame = CGRectZero;
    _payTimeLabel.text = @"付款时间：000XXX";
    _payTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_payTimeLabel];
    

    

    _backMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    _backMoney.frame = CGRectZero;
    [_backMoney setTitle:@"退 款" forState:UIControlStateNormal];
    _backMoney.titleLabel.font = [UIFont systemFontOfSize:14];
    [_backMoney setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _backMoney.layer.borderColor = [[UIColor redColor] CGColor];
    _backMoney.layer.borderWidth = 1 ;
    [self.contentView addSubview:_backMoney];


}
-(void)addDataSourceToCell:(NSString*) backStr{


    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    [_centuryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(_moneyLabel.mas_right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centuryLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(_payLabel.mas_right);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    [_payAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];
    
    [_payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payAccountLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        
    }];

    if ([backStr isEqualToString:@"处理中"]) {
        
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
