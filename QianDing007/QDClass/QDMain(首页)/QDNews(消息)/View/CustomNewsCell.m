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
    _timeDay.textAlignment = NSTextAlignmentCenter;
    _timeDay.font = [UIFont systemFontOfSize:16];
    [_timeDay setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_timeDay];
    [_timeDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_offset(33);
        make.height.mas_offset(16);
    }];
    
    _timeMonth = [[UILabel alloc] init];
    _timeMonth.text = @"12月";
    _timeMonth.textAlignment = NSTextAlignmentCenter;
    _timeMonth.font = [UIFont systemFontOfSize:14];
    [_timeMonth setTextColor:COLORFromRGB(0x999999)];
    [self.contentView addSubview:_timeMonth];
    [_timeMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeDay.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_offset(33);
        make.height.mas_offset(14);
    }];
    
    
    _basicView = [[UIView alloc] init];
    _basicView.backgroundColor = [UIColor whiteColor];
    _basicView.layer.masksToBounds = YES;
    _basicView.layer.cornerRadius = 10;
    _basicView.frame = CGRectZero;
    [self.contentView addSubview:_basicView];
    [_basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(_timeDay.mas_right).offset(10);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];

    
    _stateCollect = [[UILabel alloc] init];
    _stateCollect.text = @"商户认证失败。";
    _stateCollect.numberOfLines = 0;
    [_stateCollect setTextColor:COLORFromRGB(0x333333)];
    _stateCollect.font = [UIFont systemFontOfSize:16];
    [_basicView addSubview:_stateCollect];
    [_stateCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_basicView).offset(15);
        make.left.equalTo(_basicView).offset(10);
        make.width.mas_equalTo(280/SCALE_X);
        make.height.mas_equalTo(16);
    }];
    
    _reasonFail = [[UILabel alloc] init];
    _reasonFail.font = [UIFont systemFontOfSize:12];
    [_basicView addSubview:_reasonFail];
    _reasonFail.frame = CGRectZero;
    _reasonFail.numberOfLines = 0;
    [_reasonFail setTextColor:COLORFromRGB(0x999999)];
    [_reasonFail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stateCollect.mas_bottom).offset(10);
        make.left.equalTo(_basicView).offset(10);
        make.height.mas_equalTo(12);
    }];

    
    
    _timeHour = [[UILabel alloc] init];
    _timeHour.text = @"11:22:30";
    _timeHour.font = [UIFont systemFontOfSize:12];
    [_timeHour setTextColor:COLORFromRGB(0x999999)];
    _timeHour.frame = CGRectZero;
    [_basicView addSubview:_timeHour];
    [_timeHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_basicView.mas_bottom).offset(-15);
        make.left.equalTo(_basicView).offset(10);
        make.width.mas_equalTo(280/SCALE_X);
        make.height.mas_equalTo(12);
        
    }];


}
-(void)addDataSourceToCell:(NewsModel *)model{

    _timeDay.text = model.newsDay;
    _timeMonth.text = model.newsMonth;
    _stateCollect.text = model.newsInfo;
    float stateHeight =[shareDelegate labelHeightText:model.newsInfo Font:16 Width:280/SCALE_X];
    [_stateCollect mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(stateHeight+1);
        
    }];
    _reasonFail.text = model.newsReasonFail;
    
    int stataInt = [model.newsReasonFail intValue];
    switch (stataInt) {
        case 0:{
                _reasonFail.text = model.newsReasonFail;
                _reasonFail.text = @"原因：0000xxx0000";
                float reasonHeight = [shareDelegate labelHeightText:model.newsReasonFail Font:12 Width:280/SCALE_X];
            
                [_reasonFail mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(reasonHeight);
                        
                }];
        
        }
            break;
        case 1:{
            [self changeLayOut];
        
        }
            break;
        case 2:{
            [self changeLayOut];
            _basicView.backgroundColor = COLORFromRGB(0xfeb42f);
            [_stateCollect setTextColor:COLORFromRGB(0xffffff)];
            [_timeHour setTextColor:COLORFromRGB(0xffffff)];
            
        }
            break;
        case 3:{
            [self changeLayOut];
            _basicView.backgroundColor = COLORFromRGB(0x2fbffe);
            [_stateCollect setTextColor:COLORFromRGB(0xffffff)];
            [_timeHour setTextColor:COLORFromRGB(0xffffff)];

        }
            break;
        case 4:{
            [self changeLayOut];
            
            // 创建Attributed
            NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc] initWithString:model.newsInfo];
            // 需要改变的最后一个文字的位置
            NSUInteger secondLocOne = [[strOne string] rangeOfString:@"公"].location;
            // 需要改变的区间
            NSRange rangeOne = NSMakeRange(2, secondLocOne);
            // 改变颜色
            [strOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
            // 为label添加Attributed
            [_stateCollect setAttributedText:strOne];
            
        }
            break;
        case 5:{
            [self changeLayOut];
            // 创建Attributed
            NSMutableAttributedString *noteStrOne = [[NSMutableAttributedString alloc] initWithString:model.newsInfo];
            // 需要改变的最后一个文字的位置
            NSUInteger secondLocOne = [[noteStrOne string] rangeOfString:@"公"].location;
            // 需要改变的区间
            NSRange rangeOne = NSMakeRange(2, secondLocOne);
            // 改变颜色
            [noteStrOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
            // 为label添加Attributed
            [_stateCollect setAttributedText:noteStrOne];
        }
            break;
        default:
            break;
    }
    _timeHour.text = model.newsTime;
    [_basicView layoutIfNeeded];

    
}
- (void)changeLayOut{
    [_reasonFail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
        
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
