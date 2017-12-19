//
//  CustomShowDataView.h
//  QianDing007
//
//  Created by 张华 on 17/12/13.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomShowDataView : UIView
@property (copy , nonatomic) NSString *firstData;
@property (copy , nonatomic) NSString *secondData;
@property (copy , nonatomic) NSString *thirdData;
@property (strong , nonatomic) UILabel *firstLabel;
@property (strong , nonatomic) UILabel *secondLabel;
@property (strong , nonatomic) UILabel *thirdLabel;
- (id)initNumber:(NSString*)first ratioMoney:(NSString*)second nameType:(NSString*)third;
@end
