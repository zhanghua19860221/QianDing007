//
//  ChangePassWordController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ChangePassWordController.h"

@interface ChangePassWordController (){
    
    UITextField *cp_oldPassWordField;      //输入旧密码
    UITextField *cp_NewPassWordField;  //设置新密码
    UITextField *cp_againPassWordField;//确认新密码

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
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    cp_oldPassWordField = [[UITextField alloc] init];
    cp_oldPassWordField.placeholder = @"输入旧密码";
    cp_oldPassWordField.delegate = self;
    cp_NewPassWordField.secureTextEntry = YES;
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

    UIButton *cpSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cpSubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [cpSubmitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    cpSubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    cpSubmitBtn.layer.masksToBounds = YES;
    cpSubmitBtn.layer.cornerRadius = 22/SCALE_Y;
    cpSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cpSubmitBtn addTarget:self action:@selector(cpSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cpSubmitBtn];
    [cpSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    btn.backgroundColor = COLORFromRGB(0xe10000);
    NSString *oldPassWord  = [[shareDelegate shareNSUserDefaults] objectForKey:@"password"];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *telePhone  = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    
    BOOL isoK = [shareDelegate judgePassWordLegal:cp_NewPassWordField.text];
    if (!isoK) {
        [self cpShowAlert:@"请设置6至18位数字、字母组合密码."];
        return;
        
    }
    if (![cp_NewPassWordField.text isEqualToString:cp_againPassWordField.text]) {
        [self cpShowAlert:@"两次密码输入不相同，请重新输入。"];
        return;
        
    }
    NSString * cpNewPassWord_md5 = [MyMD5 md5:cp_NewPassWordField.text];
    NSDictionary *cpDic =@{@"phone":telePhone,
                           @"old_password":oldPassWord,
                           @"new_password":cpNewPassWord_md5,
                           @"auth_session":oldSession
                           
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:RESET_PWD_URL parameters:cpDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        BOOL isSuccess = [[responseObject objectForKey:@"info"] isEqualToString:@"修改成功"];
        if (isSuccess) {
            [self cpShowAlert:@"修改成功"];
            
        }else{
            [self cpShowAlert:[responseObject objectForKey:@"info"]];
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
/**
 创建导航栏
 */
- (void)cpCreateNavgation{
    
    self.navigationItem.title = @"修改密码";
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
- (void)cpShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                    [self.navigationController popViewControllerAnimated:YES];

                                                          }];
//  UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
//                                                         handler:^(UIAlertAction * action) {
//                                                             //响应事件
//                                                             NSLog(@"action = %@", action);
//                                                         }];
    
    [alert addAction:defaultAction];
//    [alert addAction:cancelAction];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
