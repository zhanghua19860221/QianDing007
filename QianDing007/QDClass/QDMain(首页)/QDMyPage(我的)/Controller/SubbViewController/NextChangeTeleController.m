//
//  NextChangeTeleController.m
//  QianDing007
//
//  Created by 张华 on 18/1/3.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "NextChangeTeleController.h"
#import "SecuritySetController.h"
@interface NextChangeTeleController (){
    
    UITextField *nct_newTeleField;  //验证新手机号
    UITextField *nct_getCodeField;  //设置验证码
    NSString    *nct_sess_id     ;  //记录验证码接口返回的sess_id
}


@end

@implementation NextChangeTeleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nctCreateNavgation];
    [self nctCreateSubview];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    
    
}
- (void)nctCreateSubview{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    
    nct_newTeleField = [[UITextField alloc] init];
    nct_newTeleField.placeholder = @"验证新手机号";
    nct_newTeleField.delegate = self;
    nct_newTeleField.font = [UIFont systemFontOfSize:18];
    [nct_newTeleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:nct_newTeleField];
    [nct_newTeleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom).offset(-16/SCALE_Y);
        make.left.equalTo(line).offset(10);
        make.right.equalTo(line).offset(-10);
        make.height.mas_equalTo(18);
        
    }];
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    nct_getCodeField = [[UITextField alloc] init];
    nct_getCodeField.placeholder = @"验证码";
    nct_getCodeField.delegate = self;
    nct_getCodeField.font = [UIFont systemFontOfSize:18];
    [nct_getCodeField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:nct_getCodeField];
    [nct_getCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom).offset(-16/SCALE_Y);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(18);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLORFromRGB(0xf9cccc);
    [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nctGetCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = 3;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.right.equalTo(lineOne);
        make.height.mas_equalTo(40/SCALE_Y);
        make.width.mas_equalTo(140/SCALE_X);
        
        
    }];
    
    
    UIButton *n_SubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [n_SubmitBtn setTitle:@"确认" forState:UIControlStateNormal];
    n_SubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    [n_SubmitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    n_SubmitBtn.layer.masksToBounds = YES ;
    n_SubmitBtn.layer.cornerRadius = 25;
    [self.view addSubview:n_SubmitBtn];
    [n_SubmitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [n_SubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
}

/**
 获取验证码
 */
- (void)nctGetCodeBtnClick:(UIButton*)btn{
    
    
    BOOL isPhone = [shareDelegate isChinaMobile:nct_newTeleField.text];
    if (!isPhone) {
        [self nctShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }
    NSDictionary *dic = @{@"phone":nct_newTeleField.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:SMS_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        nct_sess_id = [responseObject objectForKey:@"sess_id"];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}


- (void)submitBtnClick:(UIButton *)btn{
    btn.backgroundColor = COLORFromRGB(0xe10000);
    
    BOOL isPhone = [shareDelegate isChinaMobile:nct_newTeleField.text];
    if (!isPhone) {
        [self nctShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    

    NSDictionary *nctDic =@{@"phone":nct_newTeleField.text,
                           @"captcha":nct_getCodeField.text,
                           @"auth_session":oldSession,
                           @"sess_id":nct_sess_id
                           
                           };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:MODIFY_PHONE_URL parameters:nctDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        NSString *auth_session = [responseObject objectForKey:@"auth_session"];
        [[shareDelegate shareNSUserDefaults] setObject:auth_session forKey:@"auth_session"];
        
        BOOL isSuccess = [[responseObject objectForKey:@"info"] isEqualToString:@"修改成功"];
        if (isSuccess) {
            [self nctShowAlert:@"修改成功"];
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[SecuritySetController class]]) {
                    SecuritySetController*A = (SecuritySetController*)controller;
                    [self.navigationController popToViewController:A animated:YES];
                }
            }

        }else{
            [self nctShowAlert:[responseObject objectForKey:@"info"]];
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}


/**
 创建导航栏
 */
- (void)nctCreateNavgation{
    self.navigationItem.title = @"更换手机号";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标黑色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 警示 弹出框
 */
- (void)nctShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
