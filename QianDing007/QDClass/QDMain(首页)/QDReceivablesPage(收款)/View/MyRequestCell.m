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
    
    _supplier_name = [[UILabel alloc] init];
    _supplier_name.font = [UIFont systemFontOfSize:16];
    _supplier_name.textAlignment = NSTextAlignmentLeft;
    [_supplier_name setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_supplier_name];
    [_supplier_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(16);

    }];
    
    _name = [[UILabel alloc] init];
    _name.font = [UIFont systemFontOfSize:16];
    _name.textAlignment = NSTextAlignmentLeft;
    [_name setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_name];
//    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_supplier_name.mas_centerY);
//        make.left.equalTo(_supplier_name.mas_right).offset(10);
//        make.width.mas_equalTo(70);
//        make.height.mas_equalTo(16);
//        
//    }];
    
   UILabel *userTele = [[UILabel alloc] init];
    userTele.font = [UIFont systemFontOfSize:16];
    userTele.text = @"手机号码：";
    userTele.textAlignment = NSTextAlignmentLeft;
    [userTele setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:userTele];
    [userTele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_supplier_name.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(16);
        
    }];
    
    _phone = [[UILabel alloc] init];
    _phone.font = [UIFont systemFontOfSize:16];
    _phone.textAlignment = NSTextAlignmentLeft;
    [_phone setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_phone];
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _address = [[UILabel alloc] init];
    _address.font = [UIFont systemFontOfSize:16];
    _address.textAlignment = NSTextAlignmentLeft;
    [_address setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_address];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _pass_date = [[UILabel alloc] init];
    _pass_date.font = [UIFont systemFontOfSize:16];
    _pass_date.textAlignment = NSTextAlignmentLeft;
    [_pass_date setTextColor:COLORFromRGB(0x666666)];
    [self.contentView addSubview:_pass_date];
    [_pass_date mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _supplier_num = [[UILabel alloc] init];
    _supplier_num.font = [UIFont systemFontOfSize:16];
    _supplier_num.textAlignment = NSTextAlignmentLeft;
    [_supplier_num setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_supplier_num];
    [_supplier_num mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _supplier_count = [[UILabel alloc] init];
    _supplier_count.font = [UIFont systemFontOfSize:16];
    _supplier_count.textAlignment = NSTextAlignmentLeft;
    [_supplier_count setTextColor:COLORFromRGB(0x333333)];
    [self.contentView addSubview:_supplier_count];
    [_supplier_count mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _supplier_name.text = model.supplier_name;
    _name.text = model.name;
    _phone.text = model.phone;
    _address.text = model.address;
    _pass_date.text = model.pass_date;
    NSString *numStr = [NSString stringWithFormat:@"%@元",model.supplier_num];
    
    _supplier_num.text = numStr;
    
    //创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:numStr];
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(0, secondLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xffa800) range:range];
    // 为label添加Attributed
    [_supplier_num setAttributedText:noteStr];
    
    NSString *countStr = [NSString stringWithFormat:@"%@笔",model.supplier_count];
    _supplier_count.text = countStr;
    // 创建Attributed
    NSMutableAttributedString *noteStrOne = [[NSMutableAttributedString alloc] initWithString:countStr];
    // 需要改变的最后一个文字的位置
    NSUInteger secondLocOne = [[noteStrOne string] rangeOfString:@"笔"].location;
    // 需要改变的区间
    NSRange rangeOne = NSMakeRange(0, secondLocOne);
    // 改变颜色
    [noteStrOne addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0x00c6c8) range:rangeOne];
    // 为label添加Attributed
    [_supplier_count setAttributedText:noteStrOne];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
