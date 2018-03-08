//
//  RootViewController.h
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITabBarController
@property (strong , nonatomic)  UIButton*selectedButton;//记录上一个button
@property (strong , nonatomic)  UIView *rc_tabberView;

@end
