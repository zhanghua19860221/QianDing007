//
//  CustomNewsCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CustomNewsCell.h"

@implementation CustomNewsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
        
    }
    return self;
}
- (void)configCell{
    
    
    _timeDay = [[UILabel alloc] init];
    _timeDay.text = @"今天";
    _timeDay.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_timeDay];
    
    _timeMonth = [[UILabel alloc] init];
    _timeMonth.text = @"12月";
    _timeMonth.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeMonth];
    
    
    _basicView = [[UIView alloc] init];
    _basicView.backgroundColor = [UIColor whiteColor];
    _basicView.layer.masksToBounds = YES;
    _basicView.layer.cornerRadius = 10/SCALE_X;
    [self.contentView addSubview:_basicView];
    
    
    _statePay = [[UILabel alloc] init];
    _statePay.text = @"商户认证失败";
    _statePay.font = [UIFont systemFontOfSize:16];
    [_basicView addSubview:_statePay];
    
    _reasonFail = [[UILabel alloc] init];
    _reasonFail.text = @"原因：0000xxx0000";
    _reasonFail.font = [UIFont systemFontOfSize:12];
    [_basicView addSubview:_reasonFail];
    
    _timeHour = [[UILabel alloc] init];
    _timeHour.text = @"11:22:30";
    _timeHour.font = [UIFont systemFontOfSize:10];
    [_basicView addSubview:_timeHour];

    [_basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(_timeDay.mas_right).offset(10);
        make.bottom.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];
    
    [_timeDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_offset(33);
        make.height.mas_offset(16);
    }];
    
    [_timeMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeDay.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_offset(33);
        make.height.mas_offset(16);
    }];
    
    [_statePay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_basicView).offset(13/SCALE_Y);
        make.left.equalTo(_basicView).offset(10);
        make.right.equalTo(_basicView);
        make.height.mas_offset(16);
    }];
    
    [_reasonFail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statePay.mas_bottom).offset(11/SCALE_Y);
        make.left.equalTo(_basicView).offset(10);
        make.right.equalTo(_basicView);
        make.height.mas_offset(12);
    }];
    
    [_timeHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reasonFail.mas_bottom).offset(11/SCALE_Y);
        make.left.equalTo(_basicView).offset(10);
        make.right.equalTo(_basicView);
        make.height.mas_offset(10);
        
    }];

    
}

-(void)addDataSourceToCell:(NSString*)timeDay timeMonth:(NSString*)timeMonth
                  statePay:(NSString*)statePay reasonFail:(NSString*)reasonFail
                  timeHour:(NSString*)timeHour{

    
    
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
