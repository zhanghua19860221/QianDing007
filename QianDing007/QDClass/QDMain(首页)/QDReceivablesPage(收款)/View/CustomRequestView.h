//
//  CustomRequestView.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRequestModel.h"

@interface CustomRequestView : UIView
@property (strong , nonatomic) UILabel *userName;      //用户姓名
@property (strong , nonatomic) UILabel *userTelePhone; //手机号
@property (strong , nonatomic) UILabel *merchantName;  //商户名称
@property (strong , nonatomic) UILabel *address;       //地址
@property (strong , nonatomic) UILabel *activationTime;//激活时间
@property (strong , nonatomic) UILabel *receivables;   //收款
@property (strong , nonatomic) UILabel *list;          //订单
- (id)initView:(MyRequestModel*)model;


@end
