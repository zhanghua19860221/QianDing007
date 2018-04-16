//
//  SilverMerchantController.m
//  QianDing007
//
//  Created by 张华 on 18/1/25.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "SilverMerchantController.h"
#import "UserListModel.h"
#import "UserListCell.h"

@interface SilverMerchantController ()

@end

@implementation SilverMerchantController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scGetUrlDataSource];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)scGetUrlDataSource{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *ulDic =@{@"auth_session":oldSession,
                           @"supplier_level":@"2"

                           };
    
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    NSString * urlStr = [NSString stringWithFormat:USERLIST_URL,(long)1];

    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:urlStr] parameters:ulDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        NSString *has_data = responseObject[@"has_data"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            
            if ([has_data isEqualToString:@"0"]) {
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView setImage:[UIImage imageNamed:@"暂无1"]];
                [self.view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(150);
                    make.left.equalTo(self.view).offset((SC_WIDTH-115)/2.0);
                    make.width.mas_equalTo(125);
                    make.height.mas_equalTo(115);
                    
                }];
                //移除菊花进度条
                [[shareDelegate shareZHProgress] removeFromSuperview];
                return;
                
            }else{
                
                NSArray *tempArray = responseObject[@"supplier_data"];
                
                for (NSDictionary *allDic in tempArray) {
                    UserListModel *model = [[UserListModel alloc]init];
                    [model setValuesForKeysWithDictionary:allDic];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
                
            }
            
        }else{
            
            [self allShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
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
        [self.view addSubview:_tableView];
        _tableView.separatorStyle = NO;
        
        //去除上啦加载数据屏幕弹动问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight =0;
        _tableView.estimatedSectionFooterHeight =0;
        
        _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            if (SC_HEIGHT == 812) {
                make.height.mas_offset(SC_HEIGHT-148);
                
            }else{
                make.height.mas_offset(SC_HEIGHT-124);
                
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
    
    NSDictionary *ulDic =@{@"auth_session":oldSession,
                           @"supplier_level":@"2"
                           
                           };
    
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:USERLIST_URL,(long)self.page++];

    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:urlStr] parameters:ulDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self endRefresh];
        if (2 == self.page) { // 说明是在重新请求数据.
            self.dataArray = nil;
        }
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        NSString *has_data = responseObject[@"has_data"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            
            if (![has_data isEqualToString:@"0"] && self.page != 1) {
                
                NSArray *tempArray = responseObject[@"supplier_data"];
                
                for (NSDictionary *allDic in tempArray) {
                    UserListModel *model = [[UserListModel alloc]init];
                    [model setValuesForKeysWithDictionary:allDic];
                    [self.dataArray addObject:model];
                }
            }
        }else{
            
            [self allShowAlert:responseObject[@"info"]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        [self endRefresh];
        
    }];
    
}
/**
 警示 弹出框
 */
- (void)allShowAlert:(NSString *)warning{
    
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
#pragma *************UITableViewDelegate*************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"tableViewCellIdentifier";
    UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UserListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addDataSourceView:self.dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 169/SCALE_Y;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
