//
//  MiddleViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MiddleViewController.h"
#import "ForntTabelCell.h"
#import "RecordMoneyModel.h"

@interface MiddleViewController (){
    UILabel *mid_yesterdayLabel;//昨日收益
    UILabel *mid_totalLabel; //历史收益
    UIView  *mid_headView;//统计头视图
}

@end

@implementation MiddleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self allGetUrlDataSource];
    [self midCreateTopView];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}
- (void)allGetUrlDataSource{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *midDic =@{@"auth_session":oldSession,
                           @"type":@"handled"
                           };

    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:RECEIVEACCOUNT_URL,(long)1];
    
    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:urlStr] parameters:midDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"-2"]){
            
            [shareDelegate returnLoginController:responseObject[@"info"] UINavigationController:self.navigationController UIViewController:self];
            
        }
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        NSString *has_list = responseObject[@"has_list"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            
            //yesterday_amount 昨日收益
            mid_yesterdayLabel.text = responseObject[@"yesterday_amount"];
            //UILabel *total_amount 历史收益
            mid_totalLabel.text = responseObject[@"total_amount"];

            if ([has_list isEqualToString:@"0"]) {
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView setImage:[UIImage imageNamed:@"暂无1"]];
                [self.view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(100);
                    make.left.equalTo(self.view).offset((SC_WIDTH-115)/2.0);
                    make.width.mas_equalTo(125);
                    make.height.mas_equalTo(115);
                    
                }];
                //移除菊花进度条
                [[shareDelegate shareZHProgress] removeFromSuperview];
                return;
                
            }else{
                
                NSArray *tempArray = responseObject[@"list"];
                
                for (NSDictionary *midDic in tempArray) {
                    RecordMoneyModel *model = [[RecordMoneyModel alloc]init];
                    [model setValuesForKeysWithDictionary:midDic];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
         }
        }else{
            
            [self midShowAlert:responseObject[@"info"]];
        }
        [[shareDelegate shareZHProgress] removeFromSuperview];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        
    }];
    
}

/**
 懒加载数组
 */
- (NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}
/**
 懒加载tableview
 
 */
- (UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:self.tableView];
        _tableView.separatorStyle = NO;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight =0;
        _tableView.estimatedSectionFooterHeight =0;
        
        _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            if (SC_HEIGHT == 812) {
                make.height.mas_offset(SC_HEIGHT-138);

            }else{
                make.height.mas_offset(SC_HEIGHT-114);

            }
        }];
        

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            
            [self updateData];
        }];

        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self updateData];
        }];
        //修改刷新动画的位置
        _tableView.mj_header.frame = CGRectMake(-SC_WIDTH/3.0*2-30/SCALE_X,-50, SC_WIDTH/2.0, 50);
        _tableView.mj_footer.frame = CGRectMake(-SC_WIDTH/3.0*2-30/SCALE_X,50, SC_WIDTH/2.0, 50);
    }
    return _tableView;
}
/**
 
 停止刷新
 **/
-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
/*
 更新数据.
 数据更新后,会自动更新视图.
 */

- (void)updateData{
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSDictionary *midDic =@{@"auth_session":oldSession,
                            @"type":@"handled"
                            };
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:RECEIVEACCOUNT_URL,(long)self.page++];

    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:urlStr] parameters:midDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self endRefresh];
        if (2 == self.page) { // 说明是在重新请求数据.
            self.dataArray = nil;
        }

        NSString *has_list = responseObject[@"has_list"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]){
            
            if (![has_list isEqualToString:@"0"] && self.page != 1) {
                
                NSArray *responseArticles = responseObject[@"list"];
                
                for (NSDictionary *midDic in responseArticles) {
                    
                    RecordMoneyModel *model = [[RecordMoneyModel alloc]init];
                    [model setValuesForKeysWithDictionary:midDic];
                    [self.dataArray addObject:model];
                    
                }
                
            }
        }else{
            
            [self midShowAlert:responseObject[@"info"]];
        }
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        [self endRefresh];
        
    }];
    
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    ForntTabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[ForntTabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceToCell:self.dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 166;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];

}
/**
 创建统计视图
 
 */
- (void)midCreateTopView{
    
    mid_headView = [[UIView alloc] init];
    mid_headView.backgroundColor = COLORFromRGB(0xffffff);
    mid_headView.frame = CGRectMake(0, 0, SC_WIDTH, 86);
    self.tableView.tableHeaderView = mid_headView;

    
    mid_yesterdayLabel = [[UILabel alloc] init];
    mid_yesterdayLabel.textAlignment = NSTextAlignmentCenter;
    [mid_yesterdayLabel setTextColor:COLORFromRGB(0xe10000)];
    mid_yesterdayLabel.font = [UIFont systemFontOfSize:22];
    [mid_headView addSubview:mid_yesterdayLabel];
    [mid_yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mid_headView).offset(20);
        make.left.equalTo(mid_headView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(22);
        
    }];
    UILabel *yesterdayLabel = [[UILabel alloc] init];
    yesterdayLabel.text = @"昨日收款";
    yesterdayLabel.textAlignment = NSTextAlignmentCenter;
    [yesterdayLabel setTextColor:COLORFromRGB(0x999999)];
    yesterdayLabel.font = [UIFont systemFontOfSize:14];
    [mid_headView addSubview:yesterdayLabel];
    [yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mid_yesterdayLabel.mas_bottom).offset(10);
        make.left.equalTo(mid_headView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(14);
        
    }];
    
    mid_totalLabel = [[UILabel alloc] init];
    mid_totalLabel.textAlignment = NSTextAlignmentCenter;
    [mid_totalLabel setTextColor:COLORFromRGB(0xe10000)];
    mid_totalLabel.font = [UIFont systemFontOfSize:22];
    [mid_headView addSubview:mid_totalLabel];
    [mid_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mid_headView).offset(20);
        make.left.equalTo(mid_yesterdayLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(22);
        
    }];
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = @"历史收款";
    totalLabel.textAlignment = NSTextAlignmentCenter;
    [totalLabel setTextColor:COLORFromRGB(0x999999)];
    totalLabel.font = [UIFont systemFontOfSize:14];
    [mid_headView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mid_totalLabel.mas_bottom).offset(10);
        make.left.equalTo(mid_yesterdayLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(14);
        
    }];
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [mid_headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mid_headView.mas_bottom).offset(-1);
        make.left.right.equalTo(mid_headView);
        make.height.mas_equalTo(1);
        
    }];
    
    
}

/**
 警示 弹出框
 */
- (void)midShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
