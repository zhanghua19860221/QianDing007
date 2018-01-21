//
//  NewsModel.h
//  QianDing007
//
//  Created by 张华 on 18/1/21.
//  Copyright © 2018年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (strong  ,  nonatomic) NSString *newsDay  ;     //消息day
@property (strong  ,  nonatomic) NSString *newsMonth;     //消息Month
@property (strong  ,  nonatomic) NSString *newsInfo;      //消息内容
@property (strong  ,  nonatomic) NSString *newsReasonFail;//消息状态
@property (strong  ,  nonatomic) NSString *newsTime;      //消息时间


@end
