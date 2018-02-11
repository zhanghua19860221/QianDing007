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
    _basicView.backgroundColor = COLORFromRGB(0xffffff);
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

    _title = [[UILabel alloc] init];
    _title.numberOfLines = 0;
    [_title setTextColor:COLORFromRGB(0x333333)];
    _title.font = [UIFont systemFontOfSize:16];
    [_basicView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_basicView).offset(15);
        make.left.equalTo(_basicView).offset(10);
        make.width.mas_equalTo(280/SCALE_X);
        make.height.mas_equalTo(16);
    }];

    _content = [[UILabel alloc] init];
    _content.font = [UIFont systemFontOfSize:12];
    [_basicView addSubview:_content];
    _content.frame = CGRectZero;
    _content.numberOfLines = 0;
    [_content setTextColor:COLORFromRGB(0x666666)];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(10);
        make.left.equalTo(_basicView).offset(10);
        make.height.mas_equalTo(12);
    }];

    _timeHour = [[UILabel alloc] init];
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    NSString *tempTime = [formatter stringFromDate:tempDate];
    
    
    //时间戳转化成时间
    NSDateFormatter *DDFormatter = [[NSDateFormatter alloc] init];
    [DDFormatter setDateFormat:@"dd"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *ddDate2 = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    NSString *DDTime = [DDFormatter stringFromDate:ddDate2];

    //时间戳转化成时间
    NSDateFormatter *MMFormatter = [[NSDateFormatter alloc] init];
    [MMFormatter setDateFormat:@"MM"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *MMDate2 = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    NSString *MMTime = [MMFormatter stringFromDate:MMDate2];

    _timeDay.text = DDTime;
    if ([dateTime isEqualToString:tempTime]) {
        _timeDay.text = @"今天";
    }
    _timeMonth.text = [NSString stringWithFormat:@"%@月",MMTime];
    _title.text = model.title;
    float stateHeight =[shareDelegate labelHeightText:model.title Font:16 Width:280/SCALE_X];
    [_title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(stateHeight+1);
        
    }];
    _content.text = model.content;
    
    NSString *stata = model.extra;
    
    if ([stata isEqualToString:@"auth_fail"]) {
        
            _content.text = model.content;
            float reasonHeight = [shareDelegate labelHeightText:model.content Font:12 Width:280/SCALE_X];
        
            [_content mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(reasonHeight);
        
             }];
    }else if ([stata isEqualToString:@"auth_success"]){
             [self changeLayOut];

    }else if ([stata isEqualToString:@"receive"]){
             [self changeLayOut];

    }else if ([stata isEqualToString:@"invite_auth_success"]){
             [self changeLayOut];
        
//        // 创建Attributed
//        NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc] initWithString:model.title];
//        // 需要改变的最后一个文字的位置
//        NSUInteger secondLocOne = [[strOne string] rangeOfString:@"已"].location;
//        // 需要改变的区间
//        NSRange rangeOne = NSMakeRange(6, secondLocOne-6);
//        // 改变颜色
//        [strOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
//        // 为label添加Attributed
//        [_title setAttributedText:strOne];
        
    }else if ([stata isEqualToString:@"buy_level"]){
             [self changeLayOut];

    }else if ([stata isEqualToString:@"agency_distribute_receive"]){
             [self changeLayOut];
//        // 创建Attributed
//        NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc] initWithString:model.title];
//        // 需要改变的最后一个文字的位置
//        NSUInteger secondLocOne = [[strOne string] rangeOfString:@"收"].location;
//        // 需要改变的区间
//        NSRange rangeOne = NSMakeRange(2, secondLocOne-2);
//        // 改变颜色
//        [strOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
//        // 为label添加Attributed
//        [_title setAttributedText:strOne];
        
    }else if ([stata isEqualToString:@"agency_distribute_level"]){
            [self changeLayOut];
//        // 创建Attributed
//        NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc] initWithString:model.title];
//        // 需要改变的最后一个文字的位置
//        NSUInteger secondLocOne = [[strOne string] rangeOfString:@"升"].location;
//        // 需要改变的区间
//        NSRange rangeOne = NSMakeRange(2, secondLocOne-2);
//        // 改变颜色
//        [strOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:rangeOne];
//        // 为label添加Attributed
//        [_title setAttributedText:strOne];
    }else if ([stata isEqualToString:@"agency_withdrawal_fail"]){
        [self changeLayOut];
        _basicView.backgroundColor = COLORFromRGB(0xfeb42f);
        [_title setTextColor:COLORFromRGB(0xffffff)];
        [_timeHour setTextColor:COLORFromRGB(0xffffff)];
        
    }else if ([stata isEqualToString:@"agency_withdrawal_success"]){
         [self changeLayOut];
        _basicView.backgroundColor = COLORFromRGB(0x2fbffe);
        [_title setTextColor:COLORFromRGB(0xffffff)];
        [_timeHour setTextColor:COLORFromRGB(0xffffff)];
        
    }
    
    //时间戳转化成时间
    NSDateFormatter *HHFormatter = [[NSDateFormatter alloc] init];
    [HHFormatter setDateFormat:@"HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *HHDate = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    NSString *HHTime = [HHFormatter stringFromDate:HHDate];
    _timeHour.text = HHTime;
    
    [_basicView layoutIfNeeded];

    
}
- (void)changeLayOut{
    [_content mas_updateConstraints:^(MASConstraintMaker *make) {
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
