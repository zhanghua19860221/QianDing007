//
//  MyPage.h
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPage : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *tableView;

@end
