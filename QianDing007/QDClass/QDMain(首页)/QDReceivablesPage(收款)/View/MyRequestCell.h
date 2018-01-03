//
//  MyRequestCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/27.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRequestModel.h"
@interface MyRequestCell : UITableViewCell
@property (strong , nonatomic) UILabel *userNameLabel;   //用户姓名
@property (strong , nonatomic) UILabel *userTeleLabele;  //手机号
@property (strong , nonatomic) UILabel *merchantLabel;   //商户名称
@property (strong , nonatomic) UILabel *addressLabel;    //地址
@property (strong , nonatomic) UILabel *activationLabel; //激活时间
@property (strong , nonatomic) UILabel *receivablesLabel;//收款
@property (strong , nonatomic) UILabel *listLabel;       //订单

-(void)addDataSourceToCell:(MyRequestModel*) model;
@end
