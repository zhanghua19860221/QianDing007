//
//  MydelegateViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MydelegateViewController.h"
#import "ProfitController.h"
#import "RequestUserController.h"
#import "UserListController.h"
#import "ManageMoneyController.h"
@interface MydelegateViewController (){
    UIView *topView;     //欢迎视图
    UIView * firstView;  //第一个模块视图
    UIView * secondView; //第er个模块视图
    UILabel *labelName ;//代理商名字
}

@end

@implementation MydelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mpGetUrlInfoData];
    [self mdCreateTopView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xe10000);
    
    //修改状态栏颜色 为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}
- (void)mpGetUrlInfoData{
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *smDic =@{@"auth_session":oldSession};
    
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:MYDELEGATE_URL] parameters:smDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            NSString *day =[NSString stringWithFormat:@"%@天",responseObject[@"day"]];
            NSString *agency_distribute =[NSString stringWithFormat:@"%@", responseObject[@"agency_distribute"]];
            NSString *avg_distribute =[NSString stringWithFormat:@"%@",responseObject[@"avg_distribute"]];

            NSArray *array = @[day,agency_distribute,avg_distribute];
            [self mdCreateFirstView:array];
            [self mdCreateSecondView];
            //商户名称
            labelName.text = [NSString stringWithFormat:@"%@",responseObject[@"name"]];
        }else if ([responseObject[@"status"] isEqualToString:@"-2"]){
            
            [shareDelegate returnLoginController:responseObject[@"info"] UINavigationController:self.navigationController UIViewController:self];
            
        }else{
        
            [self mdShowAlert:responseObject[@"info"]];
        
        
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}
/**
 创建九宫格视图
 */
- (void)mdCreateSecondView{
    
    
    
    NSArray *iconArray = @[@"邀请商家",@"商户列表",@"资金管理",@"分润"];
    NSArray *titleArray = @[@"邀请商家",@"商户列表",@"资金管理",@"分润明细"];
    
    
    secondView = [[UIView alloc] init];
    secondView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(320);
    }];
    
    float width = 50/SCALE_X;
    float height = 50/SCALE_X;
    for (int i = 0; i<iconArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(70/SCALE_X+i%2*(width+135/SCALE_X),40+i/2*(height+100),width,height);
        [secondView addSubview:button];
        button.tag = 220+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *typeLabel = [[UILabel alloc] init];
        typeLabel.text = titleArray[i];
        typeLabel.font = [UIFont systemFontOfSize:16];
        [typeLabel setTextColor:COLORFromRGB(0x333333)];
        typeLabel.textAlignment = NSTextAlignmentCenter;
        typeLabel.frame = CGRectMake(58/SCALE_X+i%2*(width+135/SCALE_X), button.frame.origin.y+60+15,70,16);
        [secondView addSubview:typeLabel];
        
    }
}

/**
 九宫格按钮点击事件
 */
- (void)btnClick:(UIButton*)btn{
    switch (btn.tag) {
        case 220:{
            RequestUserController *requestVC = [[RequestUserController alloc] init];
            [self.navigationController pushViewController:requestVC animated:YES];

        }
            break;
        case 221:{
            UserListController *userListVc = [[UserListController alloc] init];
            [self.navigationController pushViewController:userListVc animated:YES];
        }
            break;
        case 222:{
            
            ManageMoneyController *moneyVc = [[ManageMoneyController alloc] init];
            [self.navigationController pushViewController:moneyVc animated:YES];
            
        }
            
            break;
        case 223:{
        
            ProfitController *prvc = [[ProfitController alloc] init];
            [self.navigationController pushViewController:prvc animated:YES];
        
        }
            break;
            
        default:
            break;
    }


}

/**
 创建统计视图
 */
- (void)mdCreateFirstView:(NSArray*)textArray{
    
    NSArray *nameArray = @[@"成为代理商",@"总共获益",@"日均获益"];
    firstView = [[UIView alloc] init];
    firstView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(100/SCALE_Y);
    }];
    UILabel *tempLabel = nil;
    
    for(int i=0;i<textArray.count;i++){
        UILabel *redLabel = [[UILabel alloc] init];
        redLabel.text = textArray[i];
        redLabel.font = [UIFont systemFontOfSize:16];
        [redLabel setTextColor:COLORFromRGB(0xe10000)];
        redLabel.textAlignment = NSTextAlignmentCenter;
        [firstView addSubview:redLabel];
        
        [redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView).offset(30/SCALE_Y);
            if (tempLabel) {
                make.left.equalTo(tempLabel.mas_right);
            }else{
                make.left.equalTo(firstView);
            }
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(SC_WIDTH/3.0);
        }];
        
        UILabel *blackLabel = [[UILabel alloc] init];
        blackLabel.text = nameArray[i];
        blackLabel.font = [UIFont systemFontOfSize:14];
        [blackLabel setTextColor:COLORFromRGB(0x666666)];
        blackLabel.textAlignment = NSTextAlignmentCenter;
        [firstView addSubview:blackLabel];
        
        [blackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(redLabel.mas_bottom).offset(10);
            make.centerX.equalTo(redLabel.mas_centerX);
            make.height.mas_equalTo(14);
            make.width.equalTo(redLabel.mas_width);
    
        }];
        
        tempLabel = redLabel;
    }

}
/**
 创建顶部导航栏 视图
 */
- (void)mdCreateTopView{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (SC_HEIGHT == 812) {
        imageView.frame = CGRectMake(0, 0, SC_WIDTH, 44);

    }else{
        imageView.frame = CGRectMake(0, 0, SC_WIDTH, 20);

    }
    imageView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:imageView];
    
    topView= [[UIView alloc] init];
    topView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(self.view).offset(44);

        }else{
            make.top.equalTo(self.view).offset(20);

        }
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(94);
        
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(11);
        make.left.equalTo(topView).offset(15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backBtn);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的代理";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView);
        make.centerX.equalTo(topView.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"您好! ";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [nameLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom).offset(-20);
        make.left.equalTo(topView).offset(21);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        
    }];
    
    
    labelName = [[UILabel alloc] init];
    labelName.font = [UIFont systemFontOfSize:16];
    labelName.textAlignment = NSTextAlignmentLeft;
    [labelName setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:labelName];
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom).offset(-20);
        make.left.equalTo(nameLabel.mas_right);
        make.right.mas_equalTo(topView).offset(-21);
        make.height.mas_equalTo(16);

    }];
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //修改状态栏颜色 为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 弹出框
 */
- (void)mdShowAlert:(NSString *)warning{
    
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
