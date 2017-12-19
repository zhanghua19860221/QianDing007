//
//  ForntTabelCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForntTabelCell : UITableViewCell

@property (strong , nonatomic) UILabel *moneyLabel;//应收金额
@property (strong , nonatomic) UILabel *centuryLabel;//实收金额
@property (strong , nonatomic) UILabel *payLabel;//付款方式
@property (strong , nonatomic) UILabel *stateLabel;//处理状态
@property (strong , nonatomic) UILabel *payAccountLabel;//付款账户
@property (strong , nonatomic) UILabel *payTimeLabel;//付款时间
@property (strong , nonatomic) UIButton *backMoney;//退款
@property (strong , nonatomic) NSString *stateMoney;//判断是否有退款按钮
-(void)addDataSourceToCell:(NSString*) backMoney;



@end
