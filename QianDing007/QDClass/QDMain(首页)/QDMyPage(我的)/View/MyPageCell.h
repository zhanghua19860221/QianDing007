//
//  MyPageCell.h
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageModel.h"
@interface MyPageCell : UITableViewCell

@property(strong , nonatomic) UIImageView *iconView;
@property(strong , nonatomic) UILabel *firstLabel;
@property(strong , nonatomic) UILabel *secondLabel;
@property(strong , nonatomic) UIButton *directionBtn;

-(void)addDataSourceView:(MyPageModel*)model;

@end
