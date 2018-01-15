//
//  MyLevelCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyLevelCell.h"
#import "BuyLevelController.h"
#import "MyRequestController.h"

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
    _mebList.text = @"满足下列条件后升级";
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
    [_requestUseBtn addTarget:self action:@selector(requestUseBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    [_buyLevelBtn addTarget:self action:@selector(buyLevelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    _buyPice  = model.mebBuyMoney;
    _buyLevel = model.mebLevel;
    _mebLevel.text = model.mebLevel;
    _mebRate.text = model.mebRate;
    _mebMoney.text = [NSString stringWithFormat:@"收款总额达到%@元",model.mebMoney];
    _mebRequest.text = [NSString stringWithFormat:@"总共邀请%@名商家并成功激活后",model.mebRequest];
    _mebBuyMoney.text = [NSString stringWithFormat:@"%@元购买",model.mebBuyMoney];
    
    if ([model.mebLevel isEqualToString:@"银牌商户"]) {
        [_firstView setImage:[UIImage imageNamed:@"银牌会员提示水印"]];
        [_secondView setImage:[UIImage imageNamed:@"银牌会员提示水印"]];
        [_thirdView   setImage:[UIImage imageNamed:@"银牌会员提示水印"]];
    }else if([model.mebLevel isEqualToString:@"金牌商户"]){
        [_firstView setImage:[UIImage imageNamed:@"金牌会员提示水印"]];
        [_secondView setImage:[UIImage imageNamed:@"金牌会员提示水印"]];
        [_thirdView   setImage:[UIImage imageNamed:@"金牌会员提示水印"]];
        [_requestUseBtn setTitleColor:COLORFromRGB(0xfbaa69) forState:UIControlStateNormal];
        _requestUseBtn.layer.borderColor = [COLORFromRGB(0xfbaa69) CGColor];
        [_buyLevelBtn setTitleColor:COLORFromRGB(0xfbaa69) forState:UIControlStateNormal];
        _buyLevelBtn.layer.borderColor = [COLORFromRGB(0xfbaa69) CGColor];
    
    }else if([model.mebLevel isEqualToString:@"钻石商户"]){
        [_firstView setImage:[UIImage imageNamed:@"钻石会员提示水印"]];
        [_secondView setImage:[UIImage imageNamed:@"钻石会员提示水印"]];
        [_thirdView   setImage:[UIImage imageNamed:@"钻石会员提示水印"]];
        [_requestUseBtn setTitleColor:COLORFromRGB(0x9b77a5) forState:UIControlStateNormal];
        _requestUseBtn.layer.borderColor = [COLORFromRGB(0x9b77a5) CGColor];
        [_buyLevelBtn setTitleColor:COLORFromRGB(0x9b77a5) forState:UIControlStateNormal];
        _buyLevelBtn.layer.borderColor = [COLORFromRGB(0x9b77a5) CGColor];
        
    }
    [_levelView setImage:[UIImage imageNamed:model.levelView]];

}
- (void)requestUseBtn:(UIButton*)btn{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    MyRequestController *VC = [[MyRequestController alloc] init];
    [tempAppDelegate.mainNav pushViewController:VC animated:YES];
}
/**
 购买按钮点击事件

 */
-(void)buyLevelBtnClick:(UIButton*)btn{
    
    _maskView = [[UIView alloc] init];
    UIApplication *ap = [UIApplication sharedApplication];
    [ap.keyWindow addSubview:_maskView];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ap.keyWindow);
        make.left.equalTo(ap.keyWindow);
        make.right.equalTo(ap.keyWindow);
        make.bottom.equalTo(ap.keyWindow);
        
    }];
    
    UIImageView *firstView = [[UIImageView alloc] init];
    firstView.backgroundColor = [UIColor blackColor];
    firstView.alpha = 0.5;
    [_maskView addSubview:firstView];
    
    UIImageView *secondView = [[UIImageView alloc] init];
    secondView.backgroundColor = COLORFromRGB(0xffffff);
    [_maskView addSubview:secondView];
    secondView.userInteractionEnabled = YES;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_maskView);
        make.bottom.equalTo(secondView.mas_top);
        make.left.right.equalTo(_maskView);
        
    }];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_maskView);
        make.left.right.equalTo(_maskView);
        make.height.mas_equalTo(370);
        
    }];
    
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"购买确认信息";
    topLabel.font = [UIFont systemFontOfSize:18];
    topLabel.textAlignment = NSTextAlignmentLeft;
    [topLabel setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView).offset(16);
        make.left.equalTo(secondView).offset(130/SCALE_X);
        make.width.mas_equalTo(180/SCALE_X);
        make.height.mas_equalTo(18);
        
        
    }];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeMaskView) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topLabel.mas_centerY);
        make.right.equalTo(secondView).offset(-15);
        make.width.height.mas_equalTo(25/SCALE_Y);
        
        
    }];
    UIImageView *firstLine = [[UIImageView alloc] init];
    firstLine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [secondView addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(16);
        make.left.equalTo(secondView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *buyModeLabel = [[UILabel alloc] init];
    buyModeLabel.text = @"购买方式";
    buyModeLabel.font = [UIFont systemFontOfSize:16];
    buyModeLabel.textAlignment = NSTextAlignmentLeft;
    [buyModeLabel setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:buyModeLabel];
    
    [buyModeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLine.mas_bottom).offset(52);
        make.left.equalTo(secondView).offset(50/SCALE_X);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(16);

    }];
    
    UIButton * weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChatBtn setImage:[UIImage imageNamed:@"支付未选中"] forState:UIControlStateNormal];
    [weChatBtn setImage:[UIImage imageNamed:@"支付选中"] forState:UIControlStateSelected];
    weChatBtn.selected = YES;
    weChatBtn.tag = 190;
    _selectBtn = weChatBtn;
    [weChatBtn addTarget:self action:@selector(payTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:weChatBtn];
    
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLine.mas_bottom).offset(30);
        make.left.equalTo(buyModeLabel.mas_right).offset(25/SCALE_X);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        
    }];
    
    UILabel *weChatLabelOne = [[UILabel alloc] init];
    weChatLabelOne.text = @"微信支付";
    weChatLabelOne.font = [UIFont systemFontOfSize:14];
    weChatLabelOne.textAlignment = NSTextAlignmentLeft;
    [weChatLabelOne setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:weChatLabelOne];
    
    [weChatLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weChatBtn.mas_centerY);
        make.left.equalTo(weChatBtn.mas_right).offset(15/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
        
    }];
    
    UILabel *weChatLabelTwo = [[UILabel alloc] init];
    weChatLabelTwo.text = @"微信支付";
    weChatLabelTwo.font = [UIFont systemFontOfSize:14];
    weChatLabelTwo.textAlignment = NSTextAlignmentLeft;
    [weChatLabelTwo setTextColor:COLORFromRGB(0x666666)];
    [secondView addSubview:weChatLabelTwo];
    
    [weChatLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weChatBtn.mas_centerY);
        make.left.equalTo(weChatLabelOne.mas_right).offset(10/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
        
    }];

    UIButton * aliPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aliPayBtn setImage:[UIImage imageNamed:@"支付未选中"] forState:UIControlStateNormal];
    [aliPayBtn setImage:[UIImage imageNamed:@"支付选中"] forState:UIControlStateSelected];
    [secondView addSubview:aliPayBtn];
    aliPayBtn.tag = 191;
    [aliPayBtn addTarget:self action:@selector(payTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [aliPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weChatBtn.mas_bottom).offset(15);
        make.left.equalTo(buyModeLabel.mas_right).offset(25/SCALE_X);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        
    }];
    
    
    UILabel *aliPayLabelOne = [[UILabel alloc] init];
    aliPayLabelOne.text = @"支付宝";
    aliPayLabelOne.font = [UIFont systemFontOfSize:14];
    aliPayLabelOne.textAlignment = NSTextAlignmentLeft;
    [aliPayLabelOne setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:aliPayLabelOne];
    
    [aliPayLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(aliPayBtn.mas_centerY);
        make.left.equalTo(aliPayBtn.mas_right).offset(15/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
        
    }];
    
    UILabel *aliPayLabelTwo = [[UILabel alloc] init];
    aliPayLabelTwo.text = @"蚂蚁金服";
    aliPayLabelTwo.font = [UIFont systemFontOfSize:14];
    aliPayLabelTwo.textAlignment = NSTextAlignmentLeft;
    [aliPayLabelTwo setTextColor:COLORFromRGB(0x666666)];
    [secondView addSubview:aliPayLabelTwo];
    
    [aliPayLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(aliPayBtn.mas_centerY);
        make.left.equalTo(aliPayLabelOne.mas_right).offset(10/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(14);
        
    }];
    
    UIImageView *secondLine = [[UIImageView alloc] init];
    secondLine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [secondView addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliPayBtn.mas_bottom).offset(30);
        make.left.equalTo(secondView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *buyInfoLabel = [[UILabel alloc] init];
    buyInfoLabel.text = @"购买信息";
    buyInfoLabel.font = [UIFont systemFontOfSize:16];
    buyInfoLabel.textAlignment = NSTextAlignmentLeft;
    [buyInfoLabel setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:buyInfoLabel];

    [buyInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLine.mas_bottom).offset(44);
        make.left.equalTo(secondView).offset(50/SCALE_X);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(16);
        
    }];

    
    UILabel *buyMoneyOne = [[UILabel alloc] init];
    buyMoneyOne.text = @"购买金额:";
    buyMoneyOne.font = [UIFont systemFontOfSize:14];
    buyMoneyOne.textAlignment = NSTextAlignmentLeft;
    [buyMoneyOne setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:buyMoneyOne];
    [buyMoneyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLine.mas_bottom).offset(30);
        make.left.equalTo(buyInfoLabel.mas_right).offset(25/SCALE_X);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(14);
        
    }];

    UILabel *buyMoneyTwo = [[UILabel alloc] init];
    buyMoneyTwo.text = _buyPice;
    buyMoneyTwo.font = [UIFont systemFontOfSize:14];
    buyMoneyTwo.textAlignment = NSTextAlignmentLeft;
    [buyMoneyTwo setTextColor:COLORFromRGB(0xe10000)];
    [secondView addSubview:buyMoneyTwo];
    [buyMoneyTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyMoneyOne.mas_centerY);
        make.left.equalTo(buyMoneyOne.mas_right).offset(5/SCALE_X);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(14);
        
    }];
    

    UILabel *buyLevelOne = [[UILabel alloc] init];
    buyLevelOne.text = @"购买级别:";
    buyLevelOne.font = [UIFont systemFontOfSize:14];
    buyLevelOne.textAlignment = NSTextAlignmentLeft;
    [buyLevelOne setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:buyLevelOne];
    
    [buyLevelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyMoneyOne.mas_bottom).offset(15);
        make.left.equalTo(buyInfoLabel.mas_right).offset(25/SCALE_X);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(14);
        
    }];
    
    UILabel *buyLevelTwo = [[UILabel alloc] init];
    buyLevelTwo.text = self.mebLevel.text;
    buyLevelTwo.font = [UIFont systemFontOfSize:14];
    buyLevelTwo.textAlignment = NSTextAlignmentLeft;
    [buyLevelTwo setTextColor:COLORFromRGB(0x333333)];
    [secondView addSubview:buyLevelTwo];
    
    [buyLevelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyLevelOne.mas_centerY);
        make.left.equalTo(buyLevelOne.mas_right).offset(5/SCALE_X);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(14);
        
    }];
    
    UIButton *comitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comitBtn.backgroundColor = COLORFromRGB(0xe10000);
    comitBtn.layer.masksToBounds = YES;
    comitBtn.layer.cornerRadius = 3;
    [comitBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    [comitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [secondView addSubview:comitBtn];
    [comitBtn addTarget:self action:@selector(comitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [comitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyLevelTwo.mas_bottom).offset(30);
        make.left.equalTo(secondView).offset(15);
        make.right.equalTo(secondView).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
}
- (void)comitBtnClick:(UIButton *)button{
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *level = nil;
    if ([_buyLevel isEqualToString:@"银牌商户"]) {
        level = @"2";
    }else if ([_buyLevel isEqualToString:@"金牌商户"]){
        level = @"3";
    }else if ([_buyLevel isEqualToString:@"钻石商户"]){
        level = @"4";

    }
    NSDictionary *buyDic =@{@"auth_session":oldSession,
                              @"level":level
                              };
    NSString *url = @"http://101.201.117.15/qd_api/index.php?ctl=qd_panyment&act=orderForm&r_type=1";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:url parameters:buyDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject === %@",[shareDelegate logDic:responseObject]);
        NSString *signedString = responseObject[@"response"];
        NSString *appScheme = @"alisdkdemo";

        [[AlipaySDK defaultService] payOrder:signedString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
/**
 选择支付方式按钮点击事件
 */
- (void)payTypeClick:(UIButton*)btn{
        
    if (_selectBtn!=btn) {
        _selectBtn.selected=NO;
        btn.selected=YES;
        _selectBtn=btn;
    }
    switch (btn.tag) {
        case 190:
            
            break;
        case 191:
            
            break;
        default:
            break;
    }

}
- (void)closeMaskView{
    _maskView.hidden = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
