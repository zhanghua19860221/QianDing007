//
//  MyRequestModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequestModel : NSObject
@property (strong , nonatomic) NSString *userName;      //用户姓名
@property (strong , nonatomic) NSString *userTelePhone; //手机号
@property (strong , nonatomic) NSString *merchantName;  //商户名称
@property (strong , nonatomic) NSString *address;       //地址
@property (strong , nonatomic) NSString *activationTime;//激活时间
@property (strong , nonatomic) NSString *receivables;   //收款
@property (strong , nonatomic) NSString *list;          //订单

@end
