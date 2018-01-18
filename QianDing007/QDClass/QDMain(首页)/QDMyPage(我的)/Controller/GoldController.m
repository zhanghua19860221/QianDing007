//
//  GoldController.m
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "GoldController.h"
#import "UserListModel.h"

@interface GoldController (){
    
    NSMutableArray *dataArray;//tableView数据
    
}


@end

@implementation GoldController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gdGetUrlDataSource];

    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)gdGetUrlDataSource{
    
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
    
    NSDictionary *ulDic =@{@"auth_session":oldSession,
                           @"supplier_level":@"3"
                           };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:USERLIST_URL parameters:ulDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        NSString *has_data = responseObject[@"has_data"];
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"1"]) {
            
            if ([has_data isEqualToString:@"0"]) {
                
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
                
                NSArray *tempArray = responseObject[@"supplier_data"];
                
                for (NSDictionary *allDic in tempArray) {
                    UserListModel *model = [[UserListModel alloc]init];
                    [model setValuesForKeysWithDictionary:allDic];
                    [dataArray addObject:model];
                }
                self.basicDataArray = dataArray;
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
