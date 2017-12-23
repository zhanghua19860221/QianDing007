//
//  MyProfitModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProfitModel : NSObject
@property (strong , nonatomic) NSString *timeStr;        //时间
@property (strong , nonatomic) NSString *userStr;        //商家名称
@property (strong , nonatomic) NSString *oldLevelStr;    //原级别
@property (strong , nonatomic) NSString *payStr;         //支 付
@property (strong , nonatomic) NSString *upStr;          //升级为
@property (strong , nonatomic) NSString *profitStr;      //分润
@property (strong , nonatomic) NSString *iconStr;        //升级头像


@end
