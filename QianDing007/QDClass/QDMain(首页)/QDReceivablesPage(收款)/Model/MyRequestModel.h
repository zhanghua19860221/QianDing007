//
//  MyRequestModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequestModel : NSObject
@property (strong , nonatomic) NSString *userNameStr;      //用户姓名
@property (strong , nonatomic) NSString *userTeleStr; //手机号
@property (strong , nonatomic) NSString *merchantNameStr;  //商户名称
@property (strong , nonatomic) NSString *addressStr;       //地址
@property (strong , nonatomic) NSString *activationTimeStr;//激活时间
@property (strong , nonatomic) NSString *receivablesStr;   //收款
@property (strong , nonatomic) NSString *listStr;          //订单

@end
