//
//  News.h
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) UITableView *tableView;
@property (strong ,nonatomic) NSMutableArray *dataArray;//消息数组

@end
