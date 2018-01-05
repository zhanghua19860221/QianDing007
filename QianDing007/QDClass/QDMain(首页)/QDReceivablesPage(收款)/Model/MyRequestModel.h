//
//  MyRequestModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequestModel : NSObject
@property (strong , nonatomic) NSString *name;          //用户姓名
@property (strong , nonatomic) NSString *phone;         //手机号
@property (strong , nonatomic) NSString *supplier_name; //商户名称
@property (strong , nonatomic) NSString *address;       //地址
@property (strong , nonatomic) NSString *pass_date;     //激活时间
@property (strong , nonatomic) NSString *supplier_num;  //收款
@property (strong , nonatomic) NSString *supplier_count;//订单



@end
