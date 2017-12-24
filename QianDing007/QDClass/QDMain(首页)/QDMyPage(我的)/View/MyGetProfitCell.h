//
//  MyGetProfitCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyGetProfitModel.h"
@interface MyGetProfitCell : UITableViewCell
@property (strong , nonatomic) UILabel *timeLabel;     //时间
@property (strong , nonatomic) UILabel *userLabel;     //商家名称
@property (strong , nonatomic) UILabel *getMoneyLabel; //收款
@property (strong , nonatomic) UILabel *getMoneyLabelOne;//收款
@property (strong , nonatomic) UIImageView *iconImage; //等级头像
@property (strong , nonatomic) UILabel *levelLabel;    //会员等级
@property (strong , nonatomic) UILabel *profitLabel;   //分润
@property (strong , nonatomic) UILabel *profitLabelOne;  //分润


-(void)addDataSourceView:(MyGetProfitModel*)model;
@end
