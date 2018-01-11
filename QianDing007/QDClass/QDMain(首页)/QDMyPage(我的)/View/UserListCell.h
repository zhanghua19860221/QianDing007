//
//  UserListCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"
@interface UserListCell : UITableViewCell
@property (strong , nonatomic) UILabel *userNameLabel;    //商家名称
@property (strong , nonatomic) UILabel *teleLabel;        //商家电话
@property (strong , nonatomic) UILabel *teleLabelOne;     //商家电话
@property (strong , nonatomic) UILabel *allMoneyLabel;    //总收款
@property (strong , nonatomic) UILabel *allMoneyLabelOne; //总收款
@property (strong , nonatomic) UILabel *openTimeLabel;    //开通时间
@property (strong , nonatomic) UILabel *openTimeLabelOne; //开通时间
@property (strong , nonatomic) UIImageView *mebIconView;  //会员头像
@property (strong , nonatomic) UILabel *mebLevelLabel;    //会员等级
-(void)addDataSourceView:(UserListModel*)model;

@end
