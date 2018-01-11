//
//  RecordMoneyModel.h
//  QianDing007
//
//  Created by 张华 on 18/1/10.
//  Copyright © 2018年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordMoneyModel : NSObject
@property (strong , nonatomic) NSString *channel_flag;//付款方式
@property (strong , nonatomic) NSString *effective;   //实收
@property (strong , nonatomic) NSString *order_no;    //付款订单代理付款账户
@property (strong , nonatomic) NSString *pay_time;    //付款时间
@property (strong , nonatomic) NSString *payment;     //付款金额
@property (strong , nonatomic) NSString *tran_result; //付款状态
@property (strong , nonatomic) NSString *tran_desc;   //收款人账户


@end
