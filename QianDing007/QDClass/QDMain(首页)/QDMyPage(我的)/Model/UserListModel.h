//
//  UserListModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserListModel : NSObject
@property (strong , nonatomic) NSString *name;          //商家名称
@property (strong , nonatomic) NSString *phone;         //商家电话
@property (strong , nonatomic) NSString *cash_sum;      //总收款
@property (strong , nonatomic) NSString *create_time;   //开通时间
@property (strong , nonatomic) NSString *supplier_level;//会员等级
@property (strong , nonatomic) NSString *level_name;   //开通时间


@end
