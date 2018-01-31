//
//  NewsModel.h
//  QianDing007
//
//  Created by 张华 on 18/1/21.
//  Copyright © 2018年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (strong ,nonatomic) NSString *title;  //消息类型
@property (strong ,nonatomic) NSString *money;  //金钱
@property (strong ,nonatomic) NSString *content;//消息内容
@property (strong ,nonatomic) NSString *extra;  //失败原因
@property (strong ,nonatomic) NSString *time;   //消息时间



@end
