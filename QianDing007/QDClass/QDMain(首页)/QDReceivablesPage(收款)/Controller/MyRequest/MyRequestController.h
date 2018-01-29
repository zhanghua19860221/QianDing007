//
//  MyRequestController.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRequestController : UIViewController<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>

@property (strong , nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (assign, nonatomic) NSInteger page; //!< 数据页数.表示下次请求第几页的数据.

@end
