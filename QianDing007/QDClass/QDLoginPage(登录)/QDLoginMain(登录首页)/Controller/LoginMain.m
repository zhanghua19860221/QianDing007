//
//  LoginMain.m
//  QianDing007
//
//  Created by 张华 on 17/12/11.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "LoginMain.h"
#import "GetPassWord.h"
#import "RegisterController.h"
#import "RootViewController.h"
@interface LoginMain (){
    UITextField *lg_selectTextField  ;//记录当前编辑的输入框
    UIButton *lg_selectBtn  ;//记录选中的按钮

    
    UIImageView *lg_logoImageView;//logo图标
    UIButton *lg_loginBtn;//登录按钮
    UIButton *lg_getPassWordBtn;//找回密码
    UIButton *lg_registerBtn;//注册
    UIButton *lg_teleImageView;//手机视图
    UIButton *lg_passImageView;//密码锁视图
    UITextField *lg_teleField; //账号输入文本
    UITextField *lg_passField; //密码输入文本
    UIImageView *lg_line;  //第一条线
    UIImageView *lg_lineOne; //第二条线

}
@end

@implementation LoginMain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lgCreateLogoView];
    [self lgCreateLoginTextView];
    [self lgCreateLoginBtn];
    [self lgCreateGetPassWordBtn];

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardhide:) name:UIKeyboardWillHideNotification object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

/**
 创建logo视图
 */
- (void)lgCreateLogoView{
    
    
    lg_logoImageView = [[UIImageView alloc] init];
    lg_logoImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lg_logoImageView];
    [lg_logoImageView setImage:[UIImage imageNamed:@"LOGO"]];
    [lg_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(100/SCALE_Y);
        make.height.mas_equalTo(110/SCALE_Y);
        make.width.mas_equalTo(110/SCALE_X);
        
    }];
}

/**
 创建帐号密码输入时图
 */
- (void)lgCreateLoginTextView{
    lg_line = [[UIImageView alloc] init];
    lg_line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lg_line];
    [lg_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lg_logoImageView.mas_bottom).offset(120/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);

    }];
    lg_teleImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_teleImageView setImage:[UIImage imageNamed:@"手机未选中"] forState:UIControlStateNormal];
    [lg_teleImageView setImage:[UIImage imageNamed:@"手机选中"] forState:UIControlStateSelected];
    [self.view addSubview:lg_teleImageView];
    [lg_teleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lg_line.mas_bottom).offset(-15);
        make.left.equalTo(lg_line);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(14);

    }];
    
    lg_teleField = [[UITextField alloc] init];
    lg_teleField.placeholder = @"输入登陆手机号";
    lg_teleField.delegate = self;
    lg_teleField.tag = 51;
    //取消输入框首字母默认大写功能
    [lg_teleField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [lg_teleField setAutocorrectionType:UITextAutocorrectionTypeNo];
    lg_teleField.textAlignment = NSTextAlignmentLeft;
    lg_teleField.font = [UIFont systemFontOfSize:18];
    [lg_teleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:lg_teleField];
    [lg_teleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lg_teleImageView.mas_centerY).offset(1);
        make.left.equalTo(lg_teleImageView.mas_right).offset(10);
        make.right.equalTo(lg_line);
        make.height.mas_equalTo(25);
        
    }];
    
    
    lg_lineOne = [[UIImageView alloc] init];
    lg_lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lg_lineOne];
    [lg_lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lg_line.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    lg_passImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_passImageView setImage:[UIImage imageNamed:@"密码未选中"] forState:UIControlStateNormal];
    [lg_passImageView setImage:[UIImage imageNamed:@"密码选中"] forState:UIControlStateSelected];
    [self.view addSubview:lg_passImageView];
    [lg_passImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lg_lineOne.mas_bottom).offset(-15);
        make.left.equalTo(lg_lineOne);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(14);
        
    }];
    
    lg_passField = [[UITextField alloc] init];
    lg_passField.placeholder = @"密码为6到18位数字、字母组合";
    lg_passField.delegate = self;
    lg_passField.tag = 61;
    lg_passField.secureTextEntry = YES;
    [lg_passField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [lg_passField setAutocorrectionType:UITextAutocorrectionTypeNo];
    lg_passField.textAlignment = NSTextAlignmentLeft;
    lg_passField.font = [UIFont systemFontOfSize:18];
    [lg_passField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:lg_passField];
    [lg_passField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lg_passImageView.mas_centerY).offset(1);
        make.left.equalTo(lg_passImageView.mas_right).offset(10);
        make.right.equalTo(lg_lineOne);
        make.height.mas_equalTo(25);
        
    }];
    
}
/**
 创建登录按钮
 */
- (void)lgCreateLoginBtn{
    
    lg_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [lg_loginBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    lg_loginBtn.backgroundColor = COLORFromRGB(0xe10000);
    [lg_loginBtn addTarget:self action:@selector(lgClickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    lg_loginBtn.layer.cornerRadius = 20;
    lg_loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:lg_loginBtn];
    [lg_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lg_lineOne.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(@44);
    }];
}
//防止重复点击
- (void)changeButtonStatus{
    lg_loginBtn.enabled = YES;
    
}
/**
 
 登录按钮点击事件
 */
- (void)lgClickLoginBtn:(UIButton*)btn{
    lg_loginBtn.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    btn.backgroundColor = COLORFromRGB(0xe10000);
    BOOL isPhone = [shareDelegate isChinaMobile:lg_teleField.text];
    if (!isPhone) {
        [self lgShowAlert:@"请输入正确的手机号码。"];
        return;
    }
    BOOL isoK = [shareDelegate judgePassWordLegal:lg_passField.text];
    if (!isoK) {
        [self lgShowAlert:@"密码为6到18位数字、字母组合"];
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

    
    NSString * rsPassWord_md5 = [MyMD5 md5:lg_passField.text];
    
    NSDictionary *lgDic =@{@"phone":lg_teleField.text,
                           @"password":rsPassWord_md5,

                           };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:LOGIN_URL parameters:lgDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[shareDelegate logDic:responseObject]);

        
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

            //本地保存用户 登录密码 数据
            NSString *logPassWord = [responseObject objectForKey:@"password"];
            [[shareDelegate shareNSUserDefaults] setObject:logPassWord forKey:@"password"];
            RootViewController *home = [[RootViewController alloc] init];
            [self.navigationController pushViewController:home animated:YES];
            

        }else{
            [self lgShowAlert:responseObject[@"info"]];

        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}
- (void)lgCreateGetPassWordBtn{
    lg_getPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_getPassWordBtn setTitle:@"找回密码？" forState:UIControlStateNormal];
    [lg_getPassWordBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    lg_getPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lg_getPassWordBtn];
    [lg_getPassWordBtn addTarget:self action:@selector(getPassWord) forControlEvents:UIControlEventTouchUpInside];
    [lg_getPassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.top.mas_equalTo(lg_loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(120);
        
    }];
    lg_registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    lg_registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [lg_registerBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    [self.view addSubview:lg_registerBtn];
    [lg_registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    [lg_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        make.top.mas_equalTo(lg_loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(60);
        
    }];
    
}

/**
 push 找回密码页面
 */
-(void)getPassWord{
    GetPassWord *vc = [[GetPassWord alloc] init];
    [self.navigationController pushViewController:vc animated:YES];


}
/**
 push 注册页面
 */
- (void)toRegister{
    RegisterController *vc = [[RegisterController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
/**
 警示 弹出框
 */
- (void)lgShowAlert:(NSString *)warning{
    
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
- (void)keyBoardshow:(NSNotification*)notification{
    
    NSDictionary * info = [notification userInfo];
    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
    double keyboardHeight=keyboardRect.size.height;//键盘的高度
    CGRect frame =  CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT);
    frame.origin.y -= 50;
    self.view.frame=frame;
    
}
- (void)keyBoardhide:(NSNotification*)notification{
    CGFloat  duration = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0,SC_WIDTH, SC_HEIGHT);
    }];
    
}

#pragma *******************UITextFieldDelegate*****************************
/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    lg_selectTextField = textField;
    switch (textField.tag) {
        case 51:{
            lg_teleImageView.selected = YES;
            lg_passImageView.selected = NO;
            lg_line.backgroundColor = COLORFromRGB(0xe10000);
            lg_lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);

        }
            break;
        case 61:{
            lg_teleImageView.selected = NO;
            lg_passImageView.selected = YES;
            lg_line.backgroundColor = COLORFromRGB(0xf9f9f9);
            lg_lineOne.backgroundColor = COLORFromRGB(0xe10000);

        }
            break;
        default:
            break;
    }
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //移除请求菊花条
//    [[shareDelegate shareZHProgress] removeFromSuperview];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidHideNotification    object:nil];

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
