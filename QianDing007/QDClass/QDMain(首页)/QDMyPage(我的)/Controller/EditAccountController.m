//
//  EditAccountController.m
//  QianDing007
//
//  Created by 张华 on 17/12/25.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "EditAccountController.h"

@interface EditAccountController (){

    UITextField *bankNumbField;   //银行卡号
    UITextField *openAccountField;//开户人
    UITextField *openBankField;   //开户银行
    UITextField *branchBankField; //支行名称
    UITextField *codeTextField;   //验证码输入框
    UILabel     *telePhone;       //预留手机号label
    UIButton    *ea_submitBtn;       //确定按钮

}

@end

@implementation EditAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self eaCreateNavgation];
    [self eaCreateSubView];
    [self eaGetDateSource];

    self.view.backgroundColor = COLORFromRGB(0xffffff);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    
}
- (void)eaGetDateSource{
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSDictionary *paDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:GETBANKINFO_URL parameters:paDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            bankNumbField.text = responseObject[@"bank_info"];
            openAccountField.text = responseObject[@"bank_user"];
            openBankField.text = responseObject[@"bank_name"];
            
        }else{
            [self eaShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)eaCreateSubView{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(10);
        
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *bankNumLabel = [[UILabel alloc] init];
    bankNumLabel.text = @"银行卡号：";
    bankNumLabel.font = [UIFont systemFontOfSize:16];
    [bankNumLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:bankNumLabel];
    [bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.bottom.equalTo(line).offset(-17);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(16);
        
    }];
    bankNumbField = [[UITextField alloc] init];
    bankNumbField.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:bankNumbField];
    bankNumbField.font = [UIFont systemFontOfSize:16];
    [bankNumbField setTextColor:COLORFromRGB(0x333333)];
    bankNumbField.delegate = self;
    bankNumbField.placeholder = @"输入银行卡号";
    [bankNumbField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bankNumLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SC_WIDTH-70);
    }];
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *openAccountLabel = [[UILabel alloc] init];
    openAccountLabel.text = @"开  户  人：";
    openAccountLabel.font = [UIFont systemFontOfSize:16];
    [openAccountLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:openAccountLabel];
    [openAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineOne);
        make.bottom.equalTo(lineOne).offset(-17);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(16);
        
    }];
    openAccountField = [[UITextField alloc] init];
    [self.view addSubview:openAccountField];
    openAccountField.font = [UIFont systemFontOfSize:16];
    [openAccountField setTextColor:COLORFromRGB(0x333333)];
    openAccountField.textAlignment = NSTextAlignmentRight;
    openAccountField.delegate = self;
    openAccountField.placeholder = @"输入开户人";
    [openAccountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(openAccountLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SC_WIDTH-70);
    }];
    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *openBankLabel = [[UILabel alloc] init];
    openBankLabel.text = @"开户银行：";
    openBankLabel.font = [UIFont systemFontOfSize:16];
    [openBankLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:openBankLabel];
    [openBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineTwo);
        make.bottom.equalTo(lineTwo).offset(-17);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(16);
        
    }];
    openBankField = [[UITextField alloc] init];
    [self.view addSubview:openBankField];
    openBankField.font = [UIFont systemFontOfSize:16];
    [openBankField setTextColor:COLORFromRGB(0x333333)];
    openBankField.textAlignment = NSTextAlignmentRight;
    openBankField.delegate = self;
    openBankField.placeholder = @"输入开户银行";
    [openBankField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(openBankLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SC_WIDTH-70);
    }];
    
//    UIImageView *lineThird = [[UIImageView alloc] init];
//    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
//    [self.view addSubview:lineThird];
//    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineTwo.mas_bottom).offset(50);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view);
//        make.height.mas_equalTo(1);
//
//    }];
//
//    UILabel *branchBankLabel = [[UILabel alloc] init];
//    branchBankLabel.text = @"支行名称：";
//    branchBankLabel.font = [UIFont systemFontOfSize:16];
//    [branchBankLabel setTextColor:COLORFromRGB(0x333333)];
//    [self.view addSubview:branchBankLabel];
//    [branchBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lineThird);
//        make.bottom.equalTo(lineThird).offset(-17);
//        make.width.mas_equalTo(95);
//        make.height.mas_equalTo(16);
//
//    }];
//    branchBankField = [[UITextField alloc] init];
//    [self.view addSubview:branchBankField];
//    branchBankField.delegate = self;
//    branchBankField.font = [UIFont systemFontOfSize:16];
//    [branchBankField setTextColor:COLORFromRGB(0x333333)];
//    branchBankField.textAlignment = NSTextAlignmentRight;
//    branchBankField.placeholder = @"输入支行名称";
//    [branchBankField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(branchBankLabel.mas_centerY);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(SC_WIDTH-70);
//    }];
//
//    UIImageView *lineFour = [[UIImageView alloc] init];
//    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
//    [self.view addSubview:lineFour];
//    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineThird.mas_bottom).offset(50);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view);
//        make.height.mas_equalTo(1);
//
//    }];
//
//    UILabel *teleLabel = [[UILabel alloc] init];
//    teleLabel.text = @"预留手机号：";
//    teleLabel.font = [UIFont systemFontOfSize:16];
//    [teleLabel setTextColor:COLORFromRGB(0x333333)];
//    [self.view addSubview:teleLabel];
//    [teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lineFour);
//        make.bottom.equalTo(lineFour).offset(-17);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(16);
//    }];
//
//
//    NSString *replaceStr = @"18919921992";
//    int startLocation = 3;
//    for (NSInteger i = 0; i < 4; i++) {
//        NSRange range = NSMakeRange(startLocation, 1);
//        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
//        startLocation++;
//    }
//
//    telePhone = [[UILabel alloc] init];
//    telePhone.text = replaceStr;
//    telePhone.font = [UIFont systemFontOfSize:16];
//    [telePhone setTextColor:COLORFromRGB(0x333333)];
//    telePhone.textAlignment = NSTextAlignmentRight;
//    [self.view addSubview:telePhone];
//    [telePhone mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(teleLabel.mas_centerY);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(SC_WIDTH-120);
//
//    }];
//
//
//
//    UIImageView *lineFive = [[UIImageView alloc] init];
//    lineFive.backgroundColor = COLORFromRGB(0xf9f9f9);
//    [self.view addSubview:lineFive];
//    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineFour.mas_bottom).offset(50);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view);
//        make.height.mas_equalTo(1);
//
//    }];
//    UILabel *codeLabel = [[UILabel alloc] init];
//    codeLabel.text = @"验证码";
//    codeLabel.font = [UIFont systemFontOfSize:16];
//    [codeLabel setTextColor:COLORFromRGB(0x333333)];
//    [self.view addSubview:codeLabel];
//    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lineFive);
//        make.bottom.equalTo(lineFive).offset(-17);
//        make.width.mas_equalTo(52);
//        make.height.mas_equalTo(16);
//
//    }];
//
//    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [getCodeBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
//    getCodeBtn.backgroundColor = COLORFromRGB(0xe10000);
//    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    getCodeBtn.layer.masksToBounds = YES;
//    getCodeBtn.layer.cornerRadius = 3;
//    [getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:getCodeBtn];
//    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-15);
//        make.bottom.equalTo(lineFive);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(50);
//
//    }];
//
//    codeTextField = [[UITextField alloc] init];
//    codeTextField.font = [UIFont systemFontOfSize:16];
//    [codeTextField setTextColor:COLORFromRGB(0x333333)];
//    codeTextField.backgroundColor = COLORFromRGB(0xf9f9f9);
//    codeTextField.placeholder = @"输入验证码";
//    codeTextField.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:codeTextField];
//    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(codeLabel.mas_right);
//        make.bottom.equalTo(lineFive);
//        make.right.equalTo(getCodeBtn.mas_left);
//        make.height.mas_equalTo(50);
//
//    }];

    
    ea_submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ea_submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [ea_submitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    ea_submitBtn.backgroundColor = COLORFromRGB(0xe10000);
    ea_submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    ea_submitBtn.layer.masksToBounds = YES;
    ea_submitBtn.layer.cornerRadius = 5;
    [ea_submitBtn addTarget:self action:@selector(writeCompletion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ea_submitBtn];
    [ea_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
        
    }];
};


/**
 获取验证码按钮点击事件
 */
- (void)getCodeBtnClick{



}
- (void)eaChangeButtonStatus{
    ea_submitBtn.enabled = YES;
    
}
/**
 点击确认按钮事件
 */
- (void)writeCompletion{
    //防止重复点击
    ea_submitBtn.enabled = NO;
    [self performSelector:@selector(eaChangeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    if ([bankNumbField.text isEqualToString:@""]||![shareDelegate checkCardNo:bankNumbField.text]) {
        [self eaShowAlert:@"银行卡号输入不正确。"];
        
        return;
    }
    
    if ([openAccountField.text isEqualToString:@""]||![shareDelegate deptNameInputShouldChinese:openAccountField.text]||![shareDelegate isStringLengthName:openAccountField.text]) {
        [self eaShowAlert:@"请输不可为空的、11个字以内的纯中文收款人名称。"];
        
        return;
    }
    if ([openAccountField.text isEqualToString:@""]) {
        
        [self eaShowAlert:@"开户银行不可为空。"];
        return;
        
    }
    
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    
    NSDictionary *saDic =@{@"auth_session":oldSession,//登陆标志
                           @"bank_user":openAccountField.text, //银行卡用户名
                           @"bank_name":openBankField.text, //银行名称
                           @"bank_info":bankNumbField.text   //银行卡号
                           };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:SAVESETBANKINFO_URL parameters:saDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            [self eaShowAlertSuccese:responseObject[@"info"]];
            
        }else{
            [self eaShowAlert:responseObject[@"info"]];
            
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
- (void)eaCreateNavgation{
    
    self.navigationItem.title = @"重新编辑";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    [leftButton setImage:[UIImage imageNamed:@"返回箭头红色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    

}
/**
 导航栏左侧按钮点击事件
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma ******************UItextFieldDelegate**********************
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
/**
 返回按钮
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [bankNumbField resignFirstResponder];
    [openAccountField resignFirstResponder];
    [openBankField resignFirstResponder];
    [branchBankField resignFirstResponder];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 提示框
 */
- (void)eaShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
  
                                                          }];
    
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 修改成功 提示框
 */
- (void)eaShowAlertSuccese:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              [self.navigationController popViewControllerAnimated:YES];
                                                              
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
