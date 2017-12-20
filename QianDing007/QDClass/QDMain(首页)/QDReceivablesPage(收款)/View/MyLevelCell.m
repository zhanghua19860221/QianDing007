//
//  MyLevelCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyLevelCell.h"

@implementation MyLevelCell
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

    _mebLevel = [[UILabel alloc] init];
    [_mebLevel setTextColor:COLORFromRGB(0x333333)];
    _mebLevel.textAlignment = NSTextAlignmentLeft;
    _mebLevel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_mebLevel];
    
    _mebRate = [[UILabel alloc] init];
    [_mebRate setTextColor:COLORFromRGB(0xe10000)];
    _mebRate.textAlignment = NSTextAlignmentLeft;
    _mebRate.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_mebRate];
    
    _spaceLine = [[UIImageView alloc] init];
    [_spaceLine setImage:[UIImage imageNamed:@"分割线"]];
    [self.contentView addSubview:_spaceLine];
    
    _mebList = [[UILabel alloc] init];
    [_mebList setTextColor:COLORFromRGB(0x333333)];
    _mebList.textAlignment = NSTextAlignmentLeft;
    _mebList.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_mebList];
    
    _mebMoney = [[UILabel alloc] init];
    [_mebMoney setTextColor:COLORFromRGB(0x666666)];
    _mebMoney.textAlignment = NSTextAlignmentLeft;
    _mebMoney.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_mebMoney];
    
    _mebRequest = [[UILabel alloc] init];
    [_mebRequest setTextColor:COLORFromRGB(0x666666)];
    _mebRequest.textAlignment = NSTextAlignmentLeft;
    _mebRequest.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_mebRequest];
    
    _mebBuyMoney = [[UILabel alloc] init];
    [_mebBuyMoney setTextColor:COLORFromRGB(0x666666)];
    _mebBuyMoney.textAlignment = NSTextAlignmentLeft;
    _mebBuyMoney.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_mebBuyMoney];
    
    _levelView = [[UIImageView alloc] init];
    [self.contentView addSubview:_levelView];
    
    _firstView = [[UIImageView alloc] init];
    [self.contentView addSubview:_firstView];
    
    _secondView = [[UIImageView alloc] init];
    [self.contentView addSubview:_secondView];
    
    _thirdView = [[UIImageView alloc] init];
    [self.contentView addSubview:_thirdView];
    
    _requestUseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_requestUseBtn setTitle:@"邀请商家" forState:UIControlStateNormal];
    [_requestUseBtn setTitleColor:COLORFromRGB(0x5c83e2) forState:UIControlStateNormal];
    _requestUseBtn.layer.masksToBounds = YES;
    _requestUseBtn.layer.cornerRadius = 5;
    _requestUseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _requestUseBtn.layer.borderColor = [COLORFromRGB(0x5c83e2) CGColor];
    _requestUseBtn.layer.borderWidth = 1;
    [self.contentView addSubview:_requestUseBtn];
    
    _buyLevelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyLevelBtn setTitle:@"购买" forState:UIControlStateNormal];
    [_buyLevelBtn setTitleColor:COLORFromRGB(0x5c83e2) forState:UIControlStateNormal];
    _buyLevelBtn.layer.masksToBounds = YES;
    _buyLevelBtn.layer.cornerRadius = 5;
    _buyLevelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _buyLevelBtn.layer.borderColor = [COLORFromRGB(0x5c83e2) CGColor];
    _buyLevelBtn.layer.borderWidth = 1;
    [self.contentView addSubview:_buyLevelBtn];
    
    [_levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.height.mas_equalTo(22);
    }];
    [_mebLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_levelView.mas_centerY);
        make.left.equalTo(_levelView.mas_right).offset(5);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
    }];
    [_mebRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mebLevel.mas_centerY);
        make.left.equalTo(_mebLevel.mas_right).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
    [_spaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_levelView.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(self.contentView).offset(15/SCALE_X);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    [_mebList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_levelView.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(25/SCALE_X);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(16);
        
    }];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mebMoney.mas_centerY);
        make.left.equalTo(self.contentView).offset(25/SCALE_X);
        make.height.width.mas_equalTo(9);
        
    }];
    [_mebMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mebList.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(_firstView.mas_right).offset(5);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(SC_WIDTH-50);
        
    }];
    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mebRequest.mas_centerY);
        make.left.equalTo(self.contentView).offset(25/SCALE_X);
        make.height.width.mas_equalTo(9);
        
    }];
    [_mebRequest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mebMoney.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(_secondView.mas_right).offset(5);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(SC_WIDTH-50);
        
    }];
    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_mebBuyMoney.mas_centerY);
        make.left.equalTo(self.contentView).offset(25/SCALE_X);
        make.height.width.mas_equalTo(9);
    
    }];
    [_mebBuyMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mebRequest.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(_thirdView.mas_right).offset(5);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(SC_WIDTH-50);
    }];
    [_requestUseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-20/SCALE_Y);
        make.left.equalTo(self.contentView).offset(30/SCALE_X);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(110/SCALE_X);
    }];
    [_buyLevelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_requestUseBtn.mas_centerY);
        make.right.equalTo(self.contentView).offset(-30/SCALE_X);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(110/SCALE_X);

    }];
    
}
- (void)addDataToCell:(MyLeveLModel*)model{
    _mebLevel.text = model.mebLevel;
    _mebRate.text = model.mebRate;
    _mebList.text = model.mebList;
    _mebMoney.text = model.mebMoney;
    _mebRequest.text = model.mebRequest;
    _mebBuyMoney.text = model.mebBuyMoney;
    if ([model.mebLevel isEqualToString:@"银牌会员"]) {
        [_firstView setImage:[UIImage imageNamed:@"银牌会员提示水印"]];
        [_secondView setImage:[UIImage imageNamed:@"银牌会员提示水印"]];
        [_thirdView   setImage:[UIImage imageNamed:@"银牌会员提示水印"]];
    }else if([model.mebLevel isEqualToString:@"金牌会员"]){
        [_firstView setImage:[UIImage imageNamed:@"金牌会员提示水印"]];
        [_secondView setImage:[UIImage imageNamed:@"金牌会员提示水印"]];
        [_thirdView   setImage:[UIImage imageNamed:@"金牌会员提示水印"]];
        [_requestUseBtn setTitleColor:COLORFromRGB(0xfbaa69) forState:UIControlStateNormal];
        _requestUseBtn.layer.borderColor = [COLORFromRGB(0xfbaa69) CGColor];
        [_buyLevelBtn setTitleColor:COLORFromRGB(0xfbaa69) forState:UIControlStateNormal];
        _buyLevelBtn.layer.borderColor = [COLORFromRGB(0xfbaa69) CGColor];
    
    }else if([model.mebLevel isEqualToString:@"钻石会员"]){
        [_firstView setImage:[UIImage imageNamed:@"钻石会员提示水印"]];
        [_secondView setImage:[UIImage imageNamed:@"钻石会员提示水印"]];
        [_thirdView   setImage:[UIImage imageNamed:@"钻石会员提示水印"]];
        [_requestUseBtn setTitleColor:COLORFromRGB(0x9b77a5) forState:UIControlStateNormal];
        _requestUseBtn.layer.borderColor = [COLORFromRGB(0x9b77a5) CGColor];
        [_buyLevelBtn setTitleColor:COLORFromRGB(0x9b77a5) forState:UIControlStateNormal];
        _buyLevelBtn.layer.borderColor = [COLORFromRGB(0x9b77a5) CGColor];
        
    }
    [_levelView setImage:[UIImage imageNamed:model.levelView]];

    
//    @property (strong , nonatomic) UIButton *requestUseBtn;//邀请商家
//    @property (strong , nonatomic) UIButton *buyLevelBtn;  //购买等级

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
