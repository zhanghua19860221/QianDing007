//
//  MyLevelCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLeveLModel.h"
@interface MyLevelCell : UITableViewCell
@property (strong , nonatomic) UILabel *mebLevel;      //会员等级
@property (strong , nonatomic) UILabel *mebRate;       //会员费率
@property (strong , nonatomic) UILabel *mebList;       //条件列表
@property (strong , nonatomic) UILabel *mebMoney;      //收款金额
@property (strong , nonatomic) UILabel *mebRequest;    //会员邀请
@property (strong , nonatomic) UILabel *mebBuyMoney;   //购买金额
@property (strong , nonatomic) UIImageView *spaceLine; //分割线
@property (strong , nonatomic) UIImageView *levelView; //等级视图
@property (strong , nonatomic) UIImageView *firstView; //列表视图
@property (strong , nonatomic) UIImageView *secondView;//列表视图
@property (strong , nonatomic) UIImageView *thirdView; //列表视图
@property (strong , nonatomic) UIButton *requestUseBtn;//邀请商家
@property (strong , nonatomic) UIButton *buyLevelBtn;  //购买等级
@property (strong , nonatomic) UIButton *selectBtn;    //购买方式默认按钮
@property (strong , nonatomic) UIView * maskView;      //购买支付视图

- (void)addDataToCell:(MyLeveLModel*)model;

@end
