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
@property (strong , nonatomic) UILabel *name;          //用户姓名
@property (strong , nonatomic) UILabel *phone;         //手机号
@property (strong , nonatomic) UILabel *supplier_name; //商户名称
@property (strong , nonatomic) UILabel *address;       //地址
@property (strong , nonatomic) UILabel *pass_date;     //激活时间
@property (strong , nonatomic) UILabel *supplier_num;  //收款
@property (strong , nonatomic) UILabel *supplier_count;//订单


-(void)addDataSourceToCell:(MyRequestModel*) model;
@end
