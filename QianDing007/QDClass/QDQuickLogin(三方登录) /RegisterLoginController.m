//
//  RegisterLoginController.m
//  QianDing007
//
//  Created by 张华 on 2018/2/27.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "RegisterLoginController.h"
#import "LoginMain.h"
@interface RegisterLoginController (){
    UITextField *rl_selectField;       //记录当前编辑的输入框
    NSString    *rl_sess_id;           //请求验证码时获取
    UITextField *rl_inviteField;       //邀请码
    UILabel     *rl_teleLabel;         //电话号码
    UITextField *rl_setPassWordField;  //设置密码
    UITextField *rl_againPassWordField;//确认密码
    UILabel     *rl_promptLabel;       //提示文本
    UIButton    *rl_SubmitBtn;         //提交按钮
}

@end

@implementation RegisterLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createInfoText];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardhide:) name:UIKeyboardWillHideNotification object:nil];
    
}
/**
 创建信息输入框
 */
- (void)createInfoText{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rl_promptLabel.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    
    rl_inviteField = [[UITextField alloc] init];
    rl_inviteField.text = @"";
    rl_inviteField.delegate = self;
    rl_inviteField.placeholder = @"请输入邀请码(选填)";
    rl_inviteField.font = [UIFont systemFontOfSize:18];
    [rl_inviteField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rl_inviteField];
    [rl_inviteField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    rl_teleLabel = [[UILabel alloc] init];
    rl_teleLabel.text = self.teleNum;
    rl_teleLabel.font = [UIFont systemFontOfSize:18];
    [rl_teleLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rl_teleLabel];
    [rl_teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    rl_setPassWordField = [[UITextField alloc] init];
    rl_setPassWordField.delegate = self;
    rl_setPassWordField.secureTextEntry = YES;
    rl_setPassWordField.placeholder = @"请设置6至18位数字、字母组合密码";
    rl_setPassWordField.font = [UIFont systemFontOfSize:18];
    [rl_setPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rl_setPassWordField];
    [rl_setPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom);
        make.left.equalTo(lineTwo).offset(10);
        make.right.equalTo(lineTwo).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    rl_againPassWordField = [[UITextField alloc] init];
    rl_againPassWordField.placeholder = @"请确认密码";
    rl_againPassWordField.delegate = self;
    rl_againPassWordField.secureTextEntry = YES;
    rl_againPassWordField.font = [UIFont systemFontOfSize:18];
    [rl_againPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rl_againPassWordField];
    [rl_againPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThird.mas_bottom);
        make.left.equalTo(lineThird).offset(10);
        make.right.equalTo(lineThird).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];


    rl_SubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rl_SubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rl_SubmitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    rl_SubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    rl_SubmitBtn.layer.masksToBounds = YES;
    rl_SubmitBtn.layer.cornerRadius = 22/SCALE_Y;
    rl_SubmitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [rl_SubmitBtn addTarget:self action:@selector(rlSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rl_SubmitBtn];
    [rl_SubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
        
    }];
    
}
//防止重复点击
- (void)changeButtonStatus{
    rl_SubmitBtn.enabled = YES;
    
}
/**
 注册提交按钮
 */
-(void)rlSubmitBtnClick:(UIButton*)btn{
    
    rl_SubmitBtn.enabled = NO;
    //防止重复点击
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];
    
    btn.backgroundColor = COLORFromRGB(0xe10000);

    BOOL isoK = [shareDelegate judgePassWordLegal:rl_setPassWordField.text];
    if (!isoK) {
        [self rlShowAlertFail:@"请设置6至18位数字、字母组合密码."];
        return;
        
    }
    if (![rl_setPassWordField.text isEqualToString:rl_againPassWordField.text]) {
        [self rlShowAlertFail:@"两次密码输入不相同，请重新输入。"];
        return;
        
    }
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSessID = [[shareDelegate shareNSUserDefaults] objectForKey:@"Third_Sess_Id"];
    NSString *safeToken = [[shareDelegate shareNSUserDefaults] objectForKey:@"Third_Safe_token"];

    if (oldSessID == NULL) {
        [self rlShowAlertFail:@"请获取正确的验证码"];
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        return;
    }

    NSString * passWord_md5 = [MyMD5 md5:rl_againPassWordField.text];
    NSDictionary *rlDic =@{@"phone":rl_teleLabel.text,
                           @"password":passWord_md5,
                           @"invite":rl_inviteField.text,
                           @"sess_id":oldSessID,
                           @"safe_token":safeToken
                           
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:[shareDelegate stringBuilder:REGISTERTHIRDLOGIN_URL] parameters:rlDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self rlShowAlertSuccess:@"注册成功"];
            
        }else{
            [self rlShowAlertFail:responseObject[@"info"]];
            
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
/**
 获取验证码
 */
- (void)rlGetCodeBtnClick:(UIButton*)btn{

    [btn startCountDownTime:60 withCountDownBlock:^{
        NSDictionary *dic = @{@"phone":rl_teleLabel.text};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:[shareDelegate stringBuilder:SMS_URL] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            rl_sess_id = [responseObject objectForKey:@"sess_id"];
            [[shareDelegate shareNSUserDefaults] setObject:rl_sess_id forKey:@"register_sess_id"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
    }];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"注册";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    rl_promptLabel = [[UILabel alloc] init];
    rl_promptLabel.text = @"提示：商户邀请码为手机号，代理商邀请码在手机号码前加\“ a \”。";
    rl_promptLabel.font = [UIFont systemFontOfSize:14];
    //文字居中显示
    rl_promptLabel.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    rl_promptLabel.lineBreakMode =NSLineBreakByWordWrapping;
    [rl_promptLabel setNumberOfLines:0];
    
    [rl_promptLabel setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:rl_promptLabel];
    [rl_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view).offset(40/SCALE_X);
        make.right.equalTo(self.view).offset(-40/SCALE_X);
        make.height.mas_offset(100/SCALE_Y);
    }];
    
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 警示 提示框
 */
- (void)rlShowAlertFail:(NSString *)warning{
    
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
/**
 成功 提示框
 */
- (void)rlShowAlertSuccess:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
       //组册成功返回登录页面
       for (UIViewController *controller in self.navigationController.viewControllers) {
                 if ([controller isKindOfClass:[LoginMain class]]) {
                         [self.navigationController popToViewController:controller animated:YES];
                }
        }
     }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)keyBoardshow:(NSNotification*)notification{
    
    NSDictionary * info = [notification userInfo];
    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
    double keyboardHeight=keyboardRect.size.height;//键盘的高度
    CGRect frame =  CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT);
    frame.origin.y -= 50;
    self.view.frame=frame;
    
    if ( (rl_selectField.frame.origin.y + keyboardHeight + 100) >= ([[UIScreen mainScreen] bounds].size.height)){
        frame.origin.y -= 50;
        self.view.frame=frame;
    }
    
}

- (void)keyBoardhide:(NSNotification*)notification{
    
    CGFloat  duration = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0,SC_WIDTH, SC_HEIGHT);
    }];
    
    
}
#pragma **************UITextFieldDelegate**********************

/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    rl_selectField = textField;
    
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
    
    NSString *two = rl_setPassWordField.text;
    NSString *three = rl_againPassWordField.text;
    if (![two isEqualToString:@""]&&![three isEqualToString:@""]) {
        rl_SubmitBtn.backgroundColor = COLORFromRGB(0xe10000);
        
    }else{
        
        rl_SubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    };
    
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //移除通知
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidHideNotification    object:nil];
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
