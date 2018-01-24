//
//  MyLevelController.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLevelCell.h"

@interface MyLevelController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong , nonatomic) UITableView *tableView;

@end
