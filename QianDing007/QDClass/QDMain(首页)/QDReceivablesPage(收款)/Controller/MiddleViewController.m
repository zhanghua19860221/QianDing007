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
    NSMutableArray *dataArray;
    UILabel *mid_yesterdayLabel;//昨日收益
    UILabel *mid_totalLabel; //历史收益

}

@end

@implementation MiddleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self allGetUrlDataSource];
    [self createTabelView];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}
- (void)allGetUrlDataSource{
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *midDic =@{@"auth_session":oldSession,
                           @"type":@"handled"
                           };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:RECEIVEACCOUNT_URL parameters:midDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
                [imageView setImage:[UIImage imageNamed:@"暂无邀请记录"]];
                [self.view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(150);
                    make.left.equalTo(self.view).offset(SC_WIDTH/2.0-45);
                    make.width.height.mas_equalTo(90);
                }];
                //移除菊花进度条
                [[shareDelegate shareZHProgress] removeFromSuperview];
                return;
                
            }else{
                
                NSArray *tempArray = responseObject[@"list"];
                
                for (NSDictionary *midDic in tempArray) {
                    RecordMoneyModel *model = [[RecordMoneyModel alloc]init];
                    [model setValuesForKeysWithDictionary:midDic];
                    [dataArray addObject:model];
                }
                [_tableView reloadData];
         }
        }else{
            
            [self midShowAlert:responseObject[@"info"]];
        }
        [[shareDelegate shareZHProgress] removeFromSuperview];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        
    }];
    
}

-(void)createTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-124);
        
    }];
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, SC_WIDTH, 86);
    headView.backgroundColor = COLORFromRGB(0xffffff);
    _tableView.tableHeaderView = headView;
    
    mid_yesterdayLabel = [[UILabel alloc] init];
    mid_yesterdayLabel.textAlignment = NSTextAlignmentCenter;
    [mid_yesterdayLabel setTextColor:COLORFromRGB(0xe10000)];
    mid_yesterdayLabel.font = [UIFont systemFontOfSize:22];
    [headView addSubview:mid_yesterdayLabel];
    [mid_yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(20);
        make.left.equalTo(headView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(22);

    }];
    UILabel *yesterdayLabel = [[UILabel alloc] init];
    yesterdayLabel.text = @"昨日收款";
    yesterdayLabel.textAlignment = NSTextAlignmentCenter;
    [yesterdayLabel setTextColor:COLORFromRGB(0x999999)];
    yesterdayLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:yesterdayLabel];
    [yesterdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mid_yesterdayLabel.mas_bottom).offset(10);
        make.left.equalTo(headView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(14);
        
    }];
    
    mid_totalLabel = [[UILabel alloc] init];
    mid_totalLabel.textAlignment = NSTextAlignmentCenter;
    [mid_totalLabel setTextColor:COLORFromRGB(0xe10000)];
    mid_totalLabel.font = [UIFont systemFontOfSize:22];
    [headView addSubview:mid_totalLabel];
    [mid_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(20);
        make.left.equalTo(mid_yesterdayLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(22);

    }];
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = @"历史收款";
    totalLabel.textAlignment = NSTextAlignmentCenter;
    [totalLabel setTextColor:COLORFromRGB(0x999999)];
    totalLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mid_totalLabel.mas_bottom).offset(10);
        make.left.equalTo(mid_yesterdayLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(14);
        
    }];
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView.mas_bottom).offset(-1);
        make.left.right.equalTo(headView);
        make.height.mas_equalTo(1);
        
    }];
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    ForntTabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[ForntTabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceToCell:dataArray[indexPath.row]];
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
