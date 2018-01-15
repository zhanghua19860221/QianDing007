//
//  FrontViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "FrontViewController.h"
#import "ForntTabelCell.h"

@interface FrontViewController (){
    NSMutableArray *dataArray;

}

@end

@implementation FrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fvGetUrlDataSource];
    [self createTabelView];
    // Do any additional setup after loading the view.
}
- (void)fvGetUrlDataSource{
    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [[UIApplication sharedApplication].keyWindow addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *midDic =@{@"auth_session":oldSession,
                            @"type":@"handling"
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

            if ([has_list isEqualToString:@"0"]) {
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView setImage:[UIImage imageNamed:@"暂无邀请记录"]];
                [self.view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).offset(150);
                    make.left.equalTo(self.view).offset(SC_WIDTH/2.0-45);
                    make.width.height.mas_equalTo(90);
                }];
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
            [[shareDelegate shareZHProgress] removeFromSuperview];

        }else{
            
            [self pvShowAlert:responseObject[@"info"]];
        }
        
        
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
/**
 警示 弹出框
 */
- (void)pvShowAlert:(NSString *)warning{
    
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
