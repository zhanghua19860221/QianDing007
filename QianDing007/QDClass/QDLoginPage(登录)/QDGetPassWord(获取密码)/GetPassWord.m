//
//  GetPassWord.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "GetPassWord.h"
@interface GetPassWord (){
    NSString    *rs_sess_id;           //请求验证码时获取
    UITextField *rs_teleField;         //电话号码
    UITextField *rs_newPassWordField;  //设置新密码
    UITextField *rs_againPassWordField;//确认新密码
    UITextField *rs_getCodeField;      //验证码
    UIButton *rs_SubmitBtn;             //提交按钮
    
}

@end

@implementation GetPassWord

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rsCreateNavgation];
    [self rsCreateInfoText];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);

    
}

/**
 创建信息输入框
 */
- (void)rsCreateInfoText{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
 
    rs_teleField = [[UITextField alloc] init];
    rs_teleField.placeholder = @"请输入手机号";
    rs_teleField.delegate = self;
    rs_teleField.tag = 379;
    rs_teleField.font = [UIFont systemFontOfSize:18];
    [rs_teleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rs_teleField];
    [rs_teleField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    rs_getCodeField = [[UITextField alloc] init];
    rs_getCodeField.placeholder = @"验证码";
    rs_getCodeField.delegate = self;
    rs_getCodeField.font = [UIFont systemFontOfSize:18];
    [rs_getCodeField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rs_getCodeField];
    [rs_getCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
    
        }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLORFromRGB(0xe10000);
    [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rsGetCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];

    rs_newPassWordField = [[UITextField alloc] init];
    rs_newPassWordField.delegate = self;
    rs_newPassWordField.placeholder = @"设置新密码";
    rs_newPassWordField.secureTextEntry = YES;
    rs_newPassWordField.font = [UIFont systemFontOfSize:18];
    [rs_newPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rs_newPassWordField];
    [rs_newPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
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

    rs_againPassWordField = [[UITextField alloc] init];
    rs_againPassWordField.placeholder = @"确认新密码";
    rs_againPassWordField.delegate = self;
    rs_againPassWordField.secureTextEntry = YES;
    rs_againPassWordField.font = [UIFont systemFontOfSize:18];
    [rs_againPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:rs_againPassWordField];
    [rs_againPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThird.mas_bottom);
        make.left.equalTo(lineThird).offset(10);
        make.right.equalTo(lineThird).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];

    rs_SubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rs_SubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rs_SubmitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    rs_SubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    rs_SubmitBtn.layer.masksToBounds = YES;
    rs_SubmitBtn.layer.cornerRadius = 22/SCALE_Y;
    rs_SubmitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [rs_SubmitBtn addTarget:self action:@selector(rsSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rs_SubmitBtn];
    [rs_SubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
        
    }];
    
}

/**
 获取验证码
 */
- (void)rsGetCodeBtnClick:(UIButton*)btn{
    
    BOOL isPhone = [shareDelegate isChinaMobile:rs_teleField.text];
    if (!isPhone) {
        [self gpShowAlertFail:@"请输入正确的手机号码。"];
        
        return;
    }
    [btn startCountDownTime:60 withCountDownBlock:^{
        
        NSDictionary *dic = @{@"phone":rs_teleField.text};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:[shareDelegate stringBuilder:SMS_URL] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress){
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //NSLog(@"%@",[shareDelegate logDic:responseObject]);
            rs_sess_id = [responseObject objectForKey:@"sess_id"];
            [[shareDelegate shareNSUserDefaults] setObject:rs_sess_id forKey:@"getPassWord_sess_id"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
        }];
        
        
        
    }];
}
//防止按钮重复点击
- (void)changeButtonStatus{
    rs_SubmitBtn.enabled = YES;
    
}
/**
  提交按钮
 */
- (void)rsSubmitBtnClick:(UIButton*)btn{
    
    rs_SubmitBtn.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    
    btn.backgroundColor = COLORFromRGB(0xe10000);
    BOOL isPhone = [shareDelegate isChinaMobile:rs_teleField.text];
    if (!isPhone) {
        [self gpShowAlertFail:@"请输入正确的手机号码。"];
        return;
        
    }
    
    NSString * temp_id = [[shareDelegate shareNSUserDefaults] stringForKey:@"getPassWord_sess_id"];
    if (temp_id == NULL) {
        [self gpShowAlertFail:@"请获取正确的验证码"];
        
        return;
    }
    
    BOOL isoK = [shareDelegate judgePassWordLegal:rs_newPassWordField.text];
    if (!isoK) {
        
        [self gpShowAlertFail:@"请设置6至18位数字、字母组合密码."];
        return;
        
    }
    
    if (![rs_newPassWordField.text isEqualToString:rs_againPassWordField.text]) {
        [self gpShowAlertFail:@"两次密码输入不相同，请重新输入。"];
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
    
    NSLog(@"%@",temp_id);
    NSString * rsPassWord_md5 = [MyMD5 md5:rs_againPassWordField.text];
    NSDictionary *rsDic =@{@"phone":rs_teleField.text,
                           @"password":rsPassWord_md5,
                           @"captcha":rs_getCodeField.text,
                           @"sess_id":temp_id
            
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:[shareDelegate stringBuilder:RESET_PWD_URL] parameters:rsDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//      NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self gpShowAlertSuccess:@"修改成功"];
        }else{
            [self gpShowAlertFail:responseObject[@"info"]];
            
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
- (void)rsCreateNavgation{
        self.navigationItem.title = @"找回密码";
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
 警示 提示框
 */
- (void)gpShowAlertFail:(NSString *)warning{
    
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
 提交成功 提示框
 */
- (void)gpShowAlertSuccess:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                [self.navigationController popViewControllerAnimated:YES];
                                                              
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

    
    NSString *one = rs_teleField.text;
    NSString *two = rs_getCodeField.text;
    NSString *three = rs_newPassWordField.text;
    NSString *four = rs_againPassWordField.text;

    if (![one isEqualToString:@""]&&![two isEqualToString:@""]&&![three isEqualToString:@""]&&![four isEqualToString:@""]) {
        rs_SubmitBtn.backgroundColor = COLORFromRGB(0xe10000);
        
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

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];
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
