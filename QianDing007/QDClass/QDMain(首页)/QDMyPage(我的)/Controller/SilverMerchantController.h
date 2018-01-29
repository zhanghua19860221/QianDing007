//
//  SilverMerchantController.h
//  QianDing007
//
//  Created by 张华 on 18/1/25.
//  Copyright © 2018年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SilverMerchantController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (assign, nonatomic) NSInteger page; //!< 数据页数.表示下次请求第几页的数据.

@end
