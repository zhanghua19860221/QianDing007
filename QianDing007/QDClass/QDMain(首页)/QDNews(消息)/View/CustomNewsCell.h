//
//  CustomNewsCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"


@interface CustomNewsCell : UITableViewCell
@property (strong , nonatomic) UILabel *timeDay;   //消息发送时间（天）
@property (strong , nonatomic) UILabel *timeMonth; //消息发送时间（月）
@property (strong , nonatomic) UILabel *extra;     //消息类型
@property (strong , nonatomic) UILabel *title;     //消息内容
@property (strong , nonatomic) UILabel *content;   //错误原因
@property (strong , nonatomic) UILabel *timeHour;  //消息发送时间（时 分 秒）
@property (strong , nonatomic) NSString *money;    //消息金钱(暂时多余)
@property (strong , nonatomic) UIView  *basicView;
-(void)addDataSourceToCell:(NewsModel *)model;

@end
