//
//  PresentRecordController.m
//  QianDing007
//
//  Created by 张华 on 17/12/25.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "PresentRecordController.h"
#import "PresentRecordCell.h"
#import "PresentRecordModel.h"
@interface PresentRecordController (){

    UILabel *pr_nameLabel;//顶部视图数据label
    NSString *pr_totalMoney ;//提现金额

}

@end

@implementation PresentRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prCreateNavgation];
    [self prGetDateSource];
    
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)prGetDateSource{
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSDictionary *prDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:GETRECORDINFO_URL,(long)1];

    [manager POST:[shareDelegate stringBuilder:urlStr] parameters:prDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString *have_list = responseObject[@"have_list"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            
        pr_nameLabel.text = [NSString stringWithFormat:@"已提现：%@元",responseObject[@"total_submit_money"]];
            
            if ([have_list isEqualToString:@"0"]) {
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView setImage:[UIImage imageNamed:@"暂无1"]];
                [self.view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.view.mas_centerY).offset(-30);
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.width.mas_equalTo(125);
                    make.height.mas_equalTo(115);
                }];
                //移除菊花进度条
                [[shareDelegate shareZHProgress] removeFromSuperview];
                return;
                
            }else{
                NSArray *tempArray = responseObject[@"submit_list"];
                for (NSDictionary *dic in tempArray) {
                     PresentRecordModel *model = [[PresentRecordModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
            }
        }else{
            [self prShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
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
        _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(114);
            make.left.right.equalTo(self.view);
            make.height.mas_offset(SC_HEIGHT-114);
            
        }];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self updateData];
            
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self updateData];
            
        }];
    }

    return _tableView;
}
/**
 创建导航栏
 */
- (void)prCreateNavgation{
    UIView *topImageView = [[UIView alloc] init];
    topImageView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(114);
        
    }];
    
    UIButton *leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBackBtn setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [topImageView addSubview:leftBackBtn];
    [leftBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView).offset(28.5);
        make.left.equalTo(topImageView).offset(15);
        make.height.mas_equalTo(23);
        make.width.mas_equalTo(13);

    }];
    UIButton *leftBackMaskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topImageView addSubview:leftBackMaskBtn];
    [leftBackMaskBtn addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBackMaskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftBackBtn);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
        
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"提现记录";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    [topImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImageView.mas_centerX);
        make.centerY.equalTo(leftBackBtn.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];

    pr_nameLabel = [[UILabel alloc] init];
    pr_nameLabel.text = @"";
    pr_nameLabel.font = [UIFont systemFontOfSize:16];
    pr_nameLabel.textAlignment = NSTextAlignmentLeft;
    [pr_nameLabel setTextColor:COLORFromRGB(0xffffff)];
    [topImageView addSubview:pr_nameLabel];
    [pr_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topImageView.mas_bottom);
        make.left.equalTo(topImageView).offset(25);
        make.width.mas_equalTo(SC_WIDTH-100);
        make.height.mas_equalTo(50);
 
    }];
    
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
    NSDictionary *prDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:GETRECORDINFO_URL,(long)self.page++];
    
    [manager POST:[shareDelegate stringBuilder:urlStr] parameters:prDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self endRefresh];
        if (2 == self.page) { // 说明是在重新请求数据.
            self.dataArray = nil;
        }
        
        NSString *have_list = responseObject[@"have_list"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            
            pr_nameLabel.text = [NSString stringWithFormat:@"已提现：%@元",responseObject[@"total_submit_money"]];
            
            if (![have_list isEqualToString:@"0"]&& self.page != 1) {
            
                NSArray *tempArray = responseObject[@"submit_list"];
                for (NSDictionary *dic in tempArray) {
                    PresentRecordModel *model = [[PresentRecordModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
            }
        }else{
            [self prShowAlert:responseObject[@"info"]];
        }
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self endRefresh];
        
    }];
}
/**
 导航栏左侧按钮
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    PresentRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[PresentRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceView:self.dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 165/SCALE_Y;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
  警示 提示框
  */
- (void)prShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              
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
