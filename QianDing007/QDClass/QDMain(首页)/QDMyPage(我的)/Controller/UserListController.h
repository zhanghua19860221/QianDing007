//
//  UserListController.h
//  QianDing007
//
//  Created by 张华 on 17/12/23.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListController : UIViewController<UIScrollViewDelegate>

@property (strong , nonatomic) UIScrollView *scrollView;//滚动界面
@property (strong , nonatomic) UIButton *selectUserButton;//记录选中按钮

@end
