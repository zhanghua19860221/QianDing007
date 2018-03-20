//
//  ChangePassWordController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ChangePassWordController.h"

@interface ChangePassWordController (){
    
    UITextField *cp_oldPassWordField;  //输入旧密码
    UITextField *cp_NewPassWordField;  //设置新密码
    UITextField *cp_againPassWordField;//确认新密码
    UIButton    *cp_SubmitBtn;         //提交按钮

}

@end

@implementation ChangePassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self cpCreateNavgation];
    [self cpCreateSubview];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);

}

- (void)cpCreateSubview{

    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(self.view).offset(84+50/SCALE_Y);
            
        }else{
            make.top.equalTo(self.view).offset(64+50/SCALE_Y);

        }
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    cp_oldPassWordField = [[UITextField alloc] init];
    cp_oldPassWordField.placeholder = @"输入旧密码";
    cp_oldPassWordField.delegate = self;
    //取消输入框首字母默认大写功能
    [cp_oldPassWordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    cp_oldPassWordField.secureTextEntry = YES;
    cp_oldPassWordField.font = [UIFont systemFontOfSize:18];
    [cp_oldPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:cp_oldPassWordField];
    [cp_oldPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.equalTo(line).offset(10);
        make.right.equalTo(line).offset(-10);
        make.height.mas_equalTo(50);
        
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
    cp_NewPassWordField = [[UITextField alloc] init];
    cp_NewPassWordField.placeholder = @"设置新密码";
    cp_NewPassWordField.delegate = self;
    cp_NewPassWordField.secureTextEntry = YES;
    cp_NewPassWordField.font = [UIFont systemFontOfSize:18];
    [cp_NewPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:cp_NewPassWordField];
    [cp_NewPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(50);
        
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

    cp_againPassWordField = [[UITextField alloc] init];
    cp_againPassWordField.placeholder = @"确认新密码";
    cp_againPassWordField.delegate = self;
    cp_againPassWordField.secureTextEntry = YES;
    cp_againPassWordField.font = [UIFont systemFontOfSize:18];
    [cp_againPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:cp_againPassWordField];
    [cp_againPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom);
        make.left.equalTo(lineTwo).offset(10);
        make.right.equalTo(lineTwo).offset(-10);
        make.height.mas_equalTo(50);
        
    }];

    cp_SubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cp_SubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [cp_SubmitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    cp_SubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    cp_SubmitBtn.layer.masksToBounds = YES;
    cp_SubmitBtn.layer.cornerRadius = 22/SCALE_Y;
    cp_SubmitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cp_SubmitBtn addTarget:self action:@selector(cpSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cp_SubmitBtn];
    [cp_SubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
        
    }];

}
/**
 提交按钮
 */
- (void)cpSubmitBtnClick:(UIButton*)btn{
    

    
    BOOL isoK = [shareDelegate judgePassWordLegal:cp_NewPassWordField.text];
    if (!isoK) {
        [self cpShowAlertFail:@"请设置6至18位数字、字母组合密码."];
        return;
        
    }
    if (![cp_NewPassWordField.text isEqualToString:cp_againPassWordField.text]) {
        [self cpShowAlertFail:@"两次密码输入不相同，请重新输入。"];
        return;
        
    }
    
        NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
        NSString *telePhone  = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    
        NSString *oldPassWord = [MyMD5 md5:cp_oldPassWordField.text];
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    
    NSString * cpNewPassWord_md5 = [MyMD5 md5:cp_NewPassWordField.text];
    NSDictionary *cpDic =@{@"phone":telePhone,
                           @"old_password":oldPassWord,
                           @"new_password":cpNewPassWord_md5,
                           @"auth_session":oldSession
                           
                           };
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:RESET_PWD_URL] parameters:cpDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self cpShowAlertSuccess:@"修改成功"];
            
        }else{
            [self cpShowAlertFail:[responseObject objectForKey:@"info"]];
            
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
- (void)cpCreateNavgation{
    
    self.navigationItem.title = @"修改密码";
    CUSTOMBACKCONCTORLLER(leftBackClick,self,self.view,@"返回图标黑色",12,20)

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
- (void)cpShowAlertFail:(NSString *)warning{
    
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
 警示 弹出框
 */
- (void)cpShowAlertSuccess:(NSString *)warning{
    
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


    NSString *one = cp_oldPassWordField.text;
    NSString *two = cp_NewPassWordField.text;
    NSString *three = cp_againPassWordField.text;

    
    if (![one isEqualToString:@""]&&![two isEqualToString:@""]&&![three isEqualToString:@""]) {
        cp_SubmitBtn.backgroundColor = COLORFromRGB(0xe10000);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.view.backgroundColor = [UIColor orangeColor];

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
