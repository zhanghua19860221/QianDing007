//
//  PresentRecordCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentRecordModel.h"
@interface PresentRecordCell : UITableViewCell
@property (strong , nonatomic) UILabel *orderLabel;    //订单号
@property (strong , nonatomic) UILabel *accountLabel;  //账户
@property (strong , nonatomic) UILabel *moneyLabel;    //提现金额
@property (strong , nonatomic) UIImageView *stateView; //提现状态视图
@property (strong , nonatomic) UILabel *timeLabel;     //提现时间
-(void)addDataSourceView:(PresentRecordModel*)model;

@end
