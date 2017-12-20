//
//  CustomRequestView.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CustomRequestView.h"

@implementation CustomRequestView
- (id)initView:(MyRequestModel*)model{
    self = [super init];
    if (self) {
        [self  addDataToView:model];
    }
    return self;
}
- (void)addDataToView:(MyRequestModel*)model{
    
//    @property (strong , nonatomic) UILabel *userName;      //用户姓名
//    @property (strong , nonatomic) UILabel *userTelePhone; //手机号
//    @property (strong , nonatomic) UILabel *_merchantName;  //商户名称
//    @property (strong , nonatomic) UILabel *_address;       //地址
//    @property (strong , nonatomic) UILabel *_activationTime;//激活时间
//    @property (strong , nonatomic) UILabel *_receivables;   //收款
//    @property (strong , nonatomic) UILabel *_list;          //订单
    
    _userName = [[UILabel alloc] init];
    _userName.text = model.userName;
    [self addSubview:_userName];
    
    _userTelePhone = [[UILabel alloc] init];
    _userTelePhone.text = model.userTelePhone;
    [self addSubview:_userTelePhone];
    
    _merchantName = [[UILabel alloc] init];
    _merchantName.text = model.merchantName;
    [self addSubview:_merchantName];
    
    _address = [[UILabel alloc] init];
    _address.text = model.address;
    [self addSubview:_address];
    
    _activationTime = [[UILabel alloc] init];
    _activationTime.text = model.activationTime;
    [self addSubview:_activationTime];
    
    _receivables = [[UILabel alloc] init];
    _receivables.text = model.receivables;
    [self addSubview:_receivables];
    
    _list = [[UILabel alloc] init];
    _list.text = model.list;
    [self addSubview:_list];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20/SCALE_Y);
        make.left.equalTo(self).offset(20/SCALE_X);
        make.right.equalTo(self);
        make.height.mas_equalTo(14);
    }];
    [_userTelePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).offset(13);
        make.left.equalTo(self).offset(20/SCALE_X);
        make.right.equalTo(self);
        make.height.mas_equalTo(14);
    }];
    [_merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userTelePhone.mas_bottom).offset(13);
        make.left.equalTo(self).offset(20/SCALE_X);
        make.right.equalTo(self);
        make.height.mas_equalTo(14);
    }];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_merchantName.mas_bottom).offset(13);
        make.left.equalTo(self).offset(20/SCALE_X);
        make.right.equalTo(self);
        make.height.mas_equalTo(14);
    }];
    [_activationTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_address.mas_bottom).offset(13);
        make.left.equalTo(self).offset(20/SCALE_X);
        make.right.equalTo(self);
        make.height.mas_equalTo(14);
    }];
    [_receivables mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20/SCALE_Y);
        make.left.equalTo(self).offset(40/SCALE_X);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(100);

    }];
    [_list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_receivables.mas_centerY);
        make.right.equalTo(self).offset(-40/SCALE_X);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(100);
        
    }];
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
