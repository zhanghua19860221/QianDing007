//
//  MyGetProfitModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGetProfitModel : NSObject
@property (strong , nonatomic) NSString *time;               //时间
@property (strong , nonatomic) NSString *supplier_name;      //商家名称
@property (strong , nonatomic) NSString *collect;            //收款金额
@property (strong , nonatomic) NSString *supplier_level;     //会员等级
@property (strong , nonatomic) NSString *supplier_level_name;//会员等级
@property (strong , nonatomic) NSString *distribute;         //分润金额



@end
