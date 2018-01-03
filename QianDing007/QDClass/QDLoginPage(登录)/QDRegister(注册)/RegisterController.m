//
//  RegisterController.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController (){

    NSString    *zc_sess_id;              //请求验证码时获取
    UITextField *zc_inviteField;       //邀请码
    UITextField *zc_teleField;         //电话号码
    UITextField *zc_setPassWordField;  //设置密码
    UITextField *zc_againPassWordField;//确认密码
    UITextField *zc_getCodeField;      //验证码
    UILabel     *zc_promptLabel;       //提示文本
}

@end

@implementation RegisterController

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
    
    
}
/**
 创建信息输入框
 */
- (void)createInfoText{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zc_promptLabel.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);

    }];

    
    zc_inviteField = [[UITextField alloc] init];
    zc_inviteField.text = @"";
    zc_inviteField.delegate = self;
    zc_inviteField.placeholder = @"请输入邀请码(选填)";
    zc_inviteField.font = [UIFont systemFontOfSize:18];
    [zc_inviteField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:zc_inviteField];
    [zc_inviteField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    zc_teleField = [[UITextField alloc] init];
    zc_teleField.placeholder = @"请输入手机号";
    zc_teleField.delegate = self;
    zc_teleField.font = [UIFont systemFontOfSize:18];
    [zc_teleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:zc_teleField];
    [zc_teleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom).offset(-16/SCALE_Y);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(18);
        
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
    zc_setPassWordField = [[UITextField alloc] init];
    zc_setPassWordField.delegate = self;
    zc_setPassWordField.secureTextEntry = YES;
    zc_setPassWordField.placeholder = @"请设置6至18位数字、字母组合密码";
    zc_setPassWordField.font = [UIFont systemFontOfSize:18];
    [zc_setPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:zc_setPassWordField];
    [zc_setPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom).offset(-16/SCALE_Y);
        make.left.equalTo(lineTwo).offset(10);
        make.right.equalTo(lineTwo).offset(-10);
        make.height.mas_equalTo(18);
        
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
    
    zc_againPassWordField = [[UITextField alloc] init];
    zc_againPassWordField.placeholder = @"请确认密码";
    zc_againPassWordField.delegate = self;
    zc_againPassWordField.secureTextEntry = YES;
    zc_againPassWordField.font = [UIFont systemFontOfSize:18];
    [zc_againPassWordField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:zc_againPassWordField];
    [zc_againPassWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThird.mas_bottom).offset(-16/SCALE_Y);
        make.left.equalTo(lineThird).offset(10);
        make.right.equalTo(lineThird).offset(-10);
        make.height.mas_equalTo(18);
        
    }];
    
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    zc_getCodeField = [[UITextField alloc] init];
    zc_getCodeField.placeholder = @"请输入验证码";
    zc_getCodeField.delegate = self;
    zc_getCodeField.font = [UIFont systemFontOfSize:18];
    [zc_getCodeField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:zc_getCodeField];
    [zc_getCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFour.mas_bottom).offset(-16/SCALE_Y);
        make.left.equalTo(lineFour).offset(10);
        make.right.equalTo(lineFour).offset(-10);
        make.height.mas_equalTo(18);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLORFromRGB(0xe10000);
    [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(zcGetCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = 3;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFour.mas_bottom);
        make.right.equalTo(lineFour);
        make.height.mas_equalTo(40/SCALE_Y);
        make.width.mas_equalTo(140/SCALE_X);

        
        }];

    UIButton *zcSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zcSubmitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [zcSubmitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    zcSubmitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    zcSubmitBtn.layer.masksToBounds = YES;
    zcSubmitBtn.layer.cornerRadius = 22/SCALE_Y;
    zcSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [zcSubmitBtn addTarget:self action:@selector(zcSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zcSubmitBtn];
    [zcSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
        
    }];
    
}

/**
 注册提交按钮
 */
-(void)zcSubmitBtnClick:(UIButton*)btn{
    btn.backgroundColor = COLORFromRGB(0xe10000);
    

    BOOL isPhone = [shareDelegate isChinaMobile:zc_teleField.text];
    if (!isPhone) {
        [self zcShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }

    BOOL isoK = [shareDelegate judgePassWordLegal:zc_setPassWordField.text];
    if (!isoK) {
        [self zcShowAlert:@"请设置6至18位数字、字母组合密码."];
        return;
        
    }

    if (![zc_setPassWordField.text isEqualToString:zc_againPassWordField.text]) {
        [self zcShowAlert:@"两次密码输入不相同，请重新输入。"];
        return;
        
        }

    NSString * temp_id = [[shareDelegate shareNSUserDefaults] stringForKey:@"sess_id"];
    NSString * passWord_md5 = [MyMD5 md5:zc_againPassWordField.text];
    NSDictionary *zcDic =@{@"phone":zc_teleField.text,
                         @"password":passWord_md5,
                         @"captcha":zc_getCodeField.text,
                         @"invite":zc_inviteField.text,
                         @"sess_id":temp_id
                           
                         };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:REGISTER_URL parameters:zcDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
/**
 获取验证码
 */
- (void)zcGetCodeBtnClick:(UIButton*)btn{
    
    NSDictionary *dic = @{@"phone":zc_teleField.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
        [manager POST:SMS_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
         
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        zc_sess_id = [responseObject objectForKey:@"sess_id"];
        [[shareDelegate shareNSUserDefaults] setObject:zc_sess_id forKey:@"sess_id"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
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
    

    zc_promptLabel = [[UILabel alloc] init];
    zc_promptLabel.text = @"提示：商户邀请码为手机号，代理商邀请码在手机号码前加0。";
    zc_promptLabel.font = [UIFont systemFontOfSize:14];
    //文字居中显示
    zc_promptLabel.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    zc_promptLabel.lineBreakMode =NSLineBreakByWordWrapping;
    [zc_promptLabel setNumberOfLines:0];
    
    [zc_promptLabel setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:zc_promptLabel];
    [zc_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
 警示 弹出框
 */
- (void)zcShowAlert:(NSString *)warning{

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
    
//    if (textField.tag == 379) {
//        BOOL isPhone = [shareDelegate isChinaMobile:textField.text];
//        if (!isPhone) {
//            [self showAlert:@"请输入正确的手机号码。"];
//        }
//    }
//    
//    if (textField.tag == 380) {
//        
//        BOOL isoK = [shareDelegate judgePassWordLegal:textField.text];
//        if (!isoK) {
//            [self showAlert:@"请设置6至18位数字、字母组合密码."];
//        }else{
//            oldPassWordStr = textField.text;
//        }
//    }
//    
//    if (textField.tag == 381) {
//        
//        if (![oldPassWordStr isEqualToString:textField.text]) {
//            [self showAlert:@"两次密码输入不相同，请重新输入。"];
//            
//        }
//    }
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
