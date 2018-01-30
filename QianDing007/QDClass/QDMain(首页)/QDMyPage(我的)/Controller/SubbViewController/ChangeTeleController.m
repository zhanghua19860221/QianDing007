//
//  ChangeTeleController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ChangeTeleController.h"
#import "NextChangeTeleController.h"
@interface ChangeTeleController (){
    
    UITextField *ct_oldTeleField;  //输入旧手机号
    UITextField *ct_getCodeField;  //设置验证码
    NSString    *ct_sess_id     ;  //记录验证码接口返回的sess_id
}


@end

@implementation ChangeTeleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ctCreateNavgation];
    [self ctCreateSubview];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)ctCreateSubview{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    
    ct_oldTeleField = [[UITextField alloc] init];
    ct_oldTeleField.placeholder = @"输入旧手机号";
    ct_oldTeleField.delegate = self;
    ct_oldTeleField.font = [UIFont systemFontOfSize:18];
    [ct_oldTeleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:ct_oldTeleField];
    [ct_oldTeleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.equalTo(line).offset(10);
        make.right.equalTo(line).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
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
    
    ct_getCodeField = [[UITextField alloc] init];
    ct_getCodeField.placeholder = @"验证码";
    ct_getCodeField.delegate = self;
    ct_getCodeField.font = [UIFont systemFontOfSize:18];
    [ct_getCodeField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:ct_getCodeField];
    [ct_getCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLORFromRGB(0xe10000);
    [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ctGetCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    [nextBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    nextBtn.layer.masksToBounds = YES ;
    nextBtn.layer.cornerRadius = 25;
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
}

/**
 获取验证码
 */
- (void)ctGetCodeBtnClick:(UIButton*)btn{
    
    BOOL isPhone = [shareDelegate isChinaMobile:ct_oldTeleField.text];
    if (!isPhone) {
        [self ctShowAlert:@"请输入正确的手机号码。"];

        return;
    }
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    [btn startCountDownTime:60 withCountDownBlock:^{
        
        NSDictionary *dic = @{@"phone":ct_oldTeleField.text};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:SMS_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",[shareDelegate logDic:responseObject]);
            
           //本地保存用户 sess_id 数据
            NSString *sess_id = [responseObject objectForKey:@"sess_id"];
            [[shareDelegate shareNSUserDefaults] setObject:sess_id forKey:@"change_sess_id"];
            
            //移除菊花进度条
            [[shareDelegate shareZHProgress] removeFromSuperview];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
        }];
    }];

    
}


/**
 点击下一步按钮点击事件


 */
- (void)nextBtnClick:(UIButton *)btn{
    btn.backgroundColor = COLORFromRGB(0xe10000);
    
    BOOL isPhone = [shareDelegate isChinaMobile:ct_oldTeleField.text];
    if (!isPhone) {
        [self ctShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }
    //获取用户 登录标志 数据
    NSString *loginSession = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    //获取用户 sess_id 数据
    NSString *sess_id = [[shareDelegate shareNSUserDefaults] objectForKey:@"change_sess_id"];
        if (sess_id == NULL) {
        sess_id = @"";
    }
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    

        NSDictionary *dic = @{@"phone":ct_oldTeleField.text,
                              @"auth_session":loginSession,
                              @"captcha":ct_getCodeField.text,
                              @"sess_id":sess_id
                              
                              };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:CHANGE_PHONE_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",[shareDelegate logDic:responseObject]);
            
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                //本地保存用户 sess_id 数据
                NSString *tokenSMS = [responseObject objectForKey:@"token"];
                [[shareDelegate shareNSUserDefaults] setObject:tokenSMS forKey:@"tokenSMS"];
                
                NextChangeTeleController *nextVc = [[NextChangeTeleController alloc] init];
                [self.navigationController pushViewController:nextVc animated:YES];
                
            }else{
            
                [self ctShowAlert:responseObject[@"info"]];
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
- (void)ctCreateNavgation{
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
- (void)ctShowAlert:(NSString *)warning{
    
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
#pragma **************UITextFieldDelegate**********************

/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    
    
}
/**
 询问输入框是否可以结束编辑 (键盘是否可以收回)
 
 */
- (BOOL)textFieldShouldEndEditing:( UITextField*)textField{
    
    return YES;
}
/**
 当前输入框结束编辑时触发 (键盘收回之后触发)
 
 */
- (void)textFieldDidEndEditing:( UITextField *)textField{
    
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
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
 点击空白收回弹出框
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
