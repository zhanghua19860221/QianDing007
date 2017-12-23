//
//  UpProfitCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProfitModel.h"

@interface UpProfitCell : UITableViewCell


@property (strong , nonatomic) UILabel *timeLabel;      //时间
@property (strong , nonatomic) UILabel *userLabel;      //商家名称
@property (strong , nonatomic) UILabel *oldLevelLabel;  //原级别
@property (strong , nonatomic) UILabel *oldLevelLabelOne;  //原级别
@property (strong , nonatomic) UIImageView *iconImage;  //等级头像
@property (strong , nonatomic) UILabel *payStr;         //支 付
@property (strong , nonatomic) UILabel *payStrOne;      //支 付
@property (strong , nonatomic) UILabel *upStrLabel;     //升级
@property (strong , nonatomic) UILabel *upStrLabelOne;  //升级
@property (strong , nonatomic) UILabel *profitLabel;    //分润
@property (strong , nonatomic) UILabel *profitLabelOne; //分润

-(void)addDataSourceView:(MyProfitModel*)model;

@end
