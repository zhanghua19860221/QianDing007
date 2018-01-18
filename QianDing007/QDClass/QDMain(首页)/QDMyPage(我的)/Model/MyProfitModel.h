//
//  MyProfitModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProfitModel : NSObject
@property (strong , nonatomic) NSString *time;        //时间
@property (strong , nonatomic) NSString *supplier_name;        //商家名称
@property (strong , nonatomic) NSString *level_name_old; //原级别
@property (strong , nonatomic) NSString *collect;         //支 付
@property (strong , nonatomic) NSString *level_name_new;  //升级为
@property (strong , nonatomic) NSString *distribute;      //分润


@end
