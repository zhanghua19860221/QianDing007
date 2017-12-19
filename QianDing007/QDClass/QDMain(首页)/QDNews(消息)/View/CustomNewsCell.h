//
//  CustomNewsCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNewsCell : UITableViewCell
@property (strong , nonatomic) UILabel *timeDay;
@property (strong , nonatomic) UILabel *timeMonth;
@property (strong , nonatomic) UILabel *statePay;
@property (strong , nonatomic) UILabel *reasonFail;
@property (strong , nonatomic) UILabel *timeHour;
@property (strong , nonatomic) UIView  *basicView;
-(void)addDataSourceToCell:(NSString*)timeDay timeMonth:(NSString*)timeMonth
                  statePay:(NSString*)statePay reasonFail:(NSString*)reasonFail
                  timeHour:(NSString*)timeHour;

@end
