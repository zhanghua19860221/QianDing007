//
//  PresentRecordModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentRecordModel : NSObject
@property (strong , nonatomic) NSString *order_no;    //订单号
@property (strong , nonatomic) NSString *bank_account;  //账户
@property (strong , nonatomic) NSString *money;    //提现金额
@property (strong , nonatomic) NSString *is_paid;    //提现状态
@property (strong , nonatomic) NSString *time;     //提现时间

@end
