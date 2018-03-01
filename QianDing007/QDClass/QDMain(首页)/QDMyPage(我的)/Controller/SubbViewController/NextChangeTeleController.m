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
    button.backgroundColor = COLORFromRGB(0xe10000);
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
    n_SubmitBtn.backgroundColor = COLORFromRGB(0xe10000);
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
    //获取用户 sess_id 数据
    NSString *sess_id = [[shareDelegate shareNSUserDefaults] objectForKey:@"change_sess_id"];
    
    [btn startCountDownTime:60 withCountDownBlock:^{
        
        NSDictionary *dic = @{@"phone":nct_newTeleField.text,
                              @"sess_id":sess_id
                              };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:[shareDelegate stringBuilder:SMS_URL] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
//            NSLog(@"%@",[shareDelegate logDic:responseObject]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
        }];
    
    }];
 
}


- (void)submitBtnClick:(UIButton *)btn{
    btn.backgroundColor = COLORFromRGB(0xe10000);
    
    BOOL isPhone = [shareDelegate isChinaMobile:nct_newTeleField.text];
    if (!isPhone) {
        [self nctShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }
    //获取用户 sess_id 数据
    NSString *sess_id = [[shareDelegate shareNSUserDefaults] objectForKey:@"change_sess_id"];
    if (sess_id == NULL) {
        sess_id = @"";
    }
    
    NSString *tokenSend = [[shareDelegate shareNSUserDefaults] objectForKey:@"tokenSMS"];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];

    
    NSDictionary *nctDic =@{@"phone":nct_newTeleField.text,
                           @"captcha":nct_getCodeField.text,
                           @"auth_session":oldSession,
                           @"sess_id":sess_id,
                           @"token":tokenSend
                            
                           };
    
    NSLog(@"nctDic   === %@",nctDic);

    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:[shareDelegate stringBuilder:MODIFY_PHONE_URL] parameters:nctDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//      NSLog(@"%@",[shareDelegate logDic:responseObject]);


        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self nctShowAlert:responseObject[@"info"]];
            NSString *auth_session = [responseObject objectForKey:@"auth_session"];
            [[shareDelegate shareNSUserDefaults] setObject:auth_session forKey:@"auth_session"];
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[SecuritySetController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            [self nctShowAlert:[responseObject objectForKey:@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        
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
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma *******************UITextFieldDelegate*****************************
/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
 
}
/**
 询问输入框是否可以结束编辑 ( 键盘是否可以收回)
 
 */
- (BOOL)textFieldShouldEndEditing:( UITextField*)textField{
    
    return YES;
}

/**
 当前输入框结束编辑时触发 (键盘收回之后触发)
 
 */
- (void)textFieldDidEndEditing:( UITextField *)textField{
    
    NSLog(@"当前输入框结束编辑时触发");
}
/**
 当输入框文字发生变化时触发 ( 只有通过键盘输入时 , 文字改变 , 触发 )
 
 */
- (BOOL)textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string{
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    
    //非空格判断
    if (![string isEqualToString:tem]) {
        
        return NO;
    }
    
    return YES;
}
/**
 控制当前输入框是否能被编辑
 
 */
- (BOOL)textFieldShouldBeginEditing:( UITextField *)textField{
    
    return YES;
}

/**
 控制输入框清除按钮是否有效 (yes, 有 ;no, 没有)
 
 */
- (BOOL)textFieldShouldClear:( UITextField*)textField{
    
    return YES;
}

/**
 返回按钮
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

/**
 点击空白处隐藏键盘
 
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
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
