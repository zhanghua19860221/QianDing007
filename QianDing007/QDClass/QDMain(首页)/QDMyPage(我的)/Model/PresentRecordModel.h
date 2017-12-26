//
//  PresentRecordModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentRecordModel : NSObject
@property (strong , nonatomic) NSString *orderStr;    //订单号
@property (strong , nonatomic) NSString *accountStr;  //账户
@property (strong , nonatomic) NSString *moneyStr;    //提现金额
@property (strong , nonatomic) NSString *stateStr;    //提现状态
@property (strong , nonatomic) NSString *timeStr;     //提现时间

@end
