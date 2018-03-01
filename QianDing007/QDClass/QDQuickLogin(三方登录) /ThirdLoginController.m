//
//  ThirdLoginController.m
//  QianDing007
//
//  Created by 张华 on 2018/2/24.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "ThirdLoginController.h"
#import "RootViewController.h"
#import "RegisterLoginController.h"
@interface ThirdLoginController (){
    
    UITextField *tl_teleField;     //手机号码
    UITextField *tl_getCodeField;  //邀请码
    UIButton    *tl_submitBtn;     //提交按钮
   
    
}

@end

@implementation ThirdLoginController

- (void)viewDidLoad {
    [super   viewDidLoad];
    [self  createSubview];
    [self createNavgation];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);

}
/**
 创建子控件
 */
- (void)createSubview{
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"提示：第三方登录绑定手机号后如果待绑定手机号没有注册商户 那么请求此接口进行注册并绑定手机号在此第三方账号下。";
    textLabel.font = [UIFont systemFontOfSize:14];
    //文字居中显示
    textLabel.textAlignment = NSTextAlignmentLeft;
    //自动折行设置
    textLabel.lineBreakMode =NSLineBreakByWordWrapping;
    [textLabel setNumberOfLines:0];
    
    [textLabel setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.right.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_offset(70);
    }];
    
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    tl_teleField = [[UITextField alloc] init];
    tl_teleField.placeholder = @"请输入手机号";
    tl_teleField.delegate = self;
    [tl_teleField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    tl_teleField.font = [UIFont systemFontOfSize:18];
    [tl_teleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:tl_teleField];
    [tl_teleField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    tl_getCodeField = [[UITextField alloc] init];
    tl_getCodeField.placeholder = @"请输入验证码";
    tl_getCodeField.delegate = self;
    tl_getCodeField.font = [UIFont systemFontOfSize:18];
    [tl_getCodeField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:tl_getCodeField];
    [tl_getCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLORFromRGB(0xe10000);
    [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tlGetCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    tl_submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tl_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [tl_submitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    tl_submitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    tl_submitBtn.layer.masksToBounds = YES;
    tl_submitBtn.layer.cornerRadius = 22/SCALE_Y;
    tl_submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [tl_submitBtn addTarget:self action:@selector(tlSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tl_submitBtn];
    [tl_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
        
    }];
    
}
//防止重复点击
- (void)changeButtonStatus{
    tl_submitBtn.enabled = YES;
    
}
/**
 提交按钮点击事件
 
 */
-(void)tlSubmitBtnClick:(UIButton*)btn{
    tl_submitBtn.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    BOOL isPhone = [shareDelegate isChinaMobile:tl_teleField.text];
    if (!isPhone) {
        [self tlShowAlertFail:@"请输入正确的手机号码。"];
        return;
        
    }
    if ([tl_getCodeField.text isEqualToString:@""]) {
        [self tlShowAlertFail:@"请输入正确的验证码。"];
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
    
    NSString *oldSessID = [[shareDelegate shareNSUserDefaults] objectForKey:@"Third_Sess_Id"];
    
    NSDictionary *tlDic =@{@"sess_id":oldSessID,
                           @"captcha":tl_getCodeField.text,
                           @"phone":tl_teleField.text,
                           
                           };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:[shareDelegate stringBuilder:BINGPHONE_URL] parameters:tlDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            //判断商户是否认证
            NSString *is_checked  = responseObject[@"checked"];
            [[shareDelegate shareNSUserDefaults] setObject:is_checked forKey:@"is_checked"];
            
            //判断商户认证类型
            NSString *temp_Account = responseObject[@"account_type"];
            [[shareDelegate shareNSUserDefaults] setObject:temp_Account forKey:@"account_type"];
            
            //is_agency判断是否为代理商
            NSString *is_agency  = responseObject[@"is_agency"];
            [[shareDelegate shareNSUserDefaults] setObject:is_agency forKey:@"is_agency"];
            
            //本地保存用户头像NSData数据
            NSString *logoString = [responseObject objectForKey:@"logo"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:logoString]];
            [[shareDelegate shareNSUserDefaults] setObject:data forKey:@"LOGO"];
            
            //本地保存用户 登录标志 数据
            NSString *loginSession = [responseObject objectForKey:@"auth_session"];
            [[shareDelegate shareNSUserDefaults] setObject:loginSession forKey:@"auth_session"];
            
            //本地保存用户 手机号 数据
            NSString *logPhone = [responseObject objectForKey:@"phone"];
            [[shareDelegate shareNSUserDefaults] setObject:logPhone forKey:@"phone"];
            
            //本地保存商户名称
            NSString *merchantName = [responseObject objectForKey:@"name"];
            [[shareDelegate shareNSUserDefaults] setObject:merchantName forKey:@"merchantName"];
            
            //获取融云token
            NSString *userRongToken = [responseObject objectForKey:@"rongtoken"];
            [[shareDelegate shareNSUserDefaults] setObject:userRongToken forKey:@"RongToken"];
            //链接融云
            [self landRongCloud:userRongToken];
            RootViewController *home = [[RootViewController alloc] init];
            [self.navigationController pushViewController:home animated:YES];
            
            
        }else if([responseObject[@"status"] isEqualToString:@"2"]){
            
            NSString *thirdSessID = responseObject[@"safe_token"];
            [[shareDelegate shareNSUserDefaults] setObject:thirdSessID forKey:@"Third_Safe_token"];
            
            RegisterLoginController *registerLogin = [[RegisterLoginController alloc] init];
            registerLogin.teleNum = tl_teleField.text;
            [self.navigationController pushViewController:registerLogin animated:YES];
            
        }else{
            
            [self tlShowAlertFail:responseObject[@"info"]];
            
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}

/**
 链接融云
 
 */
-(void)landRongCloud:(NSString *)token{
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"链接成功: %@", userId);
        [shareDelegate sharedManager].b_userID = userId;
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"链接失败 %ld", (long)status);
        
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
    
}
/**
 获取验证码
 
 */
- (void)tlGetCodeBtnClick:(UIButton*)btn{
    
    BOOL isPhone = [shareDelegate isChinaMobile:tl_teleField.text];
    if (!isPhone) {
        [self tlShowAlertFail:@"请输入正确的手机号码。"];
        return;
        
    }
    
    NSString *oldSessID = [[shareDelegate shareNSUserDefaults] objectForKey:@"Third_Sess_Id"];

    [btn startCountDownTime:60 withCountDownBlock:^{
        NSDictionary *dic = @{@"phone":tl_teleField.text,
                              @"sess_id":oldSessID
                              
                              };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:[shareDelegate stringBuilder:SMS_URL] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            [self tlShowAlertFail:responseObject[@"info"]];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
    }];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"绑定手机号";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    
}
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    if (![tl_teleField.text isEqualToString:@""]&&![tl_getCodeField.text isEqualToString:@""]) {
        
        tl_submitBtn.backgroundColor = COLORFromRGB(0xe10000);
    }else{
        
        tl_submitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    }
    
}

/**
 当输入框文字发生变化时触发 ( 只有通过键盘输入时 , 文字改变 , 触发 )
 
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
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
/**
 警示 提示框
 */
- (void)tlShowAlertFail:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              
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
