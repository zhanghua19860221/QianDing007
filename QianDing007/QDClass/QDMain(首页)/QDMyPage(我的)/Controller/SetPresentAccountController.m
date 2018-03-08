//
//  SetPresentAccountController.m
//  QianDing007
//
//  Created by 张华 on 17/12/25.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "SetPresentAccountController.h"
#import "PresentAccountController.h"
@interface SetPresentAccountController (){
    
    UITextField *bankNumbField;   //银行卡号
    UITextField *openAccountField;//开户人
    UITextField *openBankField;   //开户银行
    UITextField *branchBankField; //支行名称
    
    UIButton *sa_subMitBtn;//确认按钮

}

@end

@implementation SetPresentAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubView];
    
    self.view.backgroundColor = COLORFromRGB(0xffffff);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);


    
}
- (void)createSubView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(self.view).offset(84);
        }else{
            make.top.equalTo(self.view).offset(64);
            
        }
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
    bankNumLabel.text = @"银行卡号";
    [self.view addSubview:bankNumLabel];
    [bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.bottom.equalTo(line).offset(-17);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);

    }];
    bankNumbField = [[UITextField alloc] init];
    bankNumbField.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:bankNumbField];
    bankNumbField.delegate = self;
    bankNumbField.placeholder = @"（必填）";
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
    openAccountLabel.text = @"开  户  人";
    [self.view addSubview:openAccountLabel];
    [openAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineOne);
        make.bottom.equalTo(lineOne).offset(-17);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    openAccountField = [[UITextField alloc] init];
    [self.view addSubview:openAccountField];
    openAccountField.textAlignment = NSTextAlignmentRight;
    openAccountField.delegate = self;
    openAccountField.placeholder = @"（必填）";
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
    openBankLabel.text = @"开户银行";
    [self.view addSubview:openBankLabel];
    [openBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineTwo);
        make.bottom.equalTo(lineTwo).offset(-17);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    openBankField = [[UITextField alloc] init];
    [self.view addSubview:openBankField];
    openBankField.textAlignment = NSTextAlignmentRight;
    openBankField.delegate = self;
    openBankField.placeholder = @"（必填）";
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
    
//    UILabel *branchBankLabel = [[UILabel alloc] init];
//    branchBankLabel.text = @"支行名称";
//    [self.view addSubview:branchBankLabel];
//    [branchBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(lineThird);
//        make.bottom.equalTo(lineThird).offset(-17);
//        make.width.mas_equalTo(70);
//        make.height.mas_equalTo(16);
//
//    }];
//    branchBankField = [[UITextField alloc] init];
//    [self.view addSubview:branchBankField];
//    branchBankField.delegate = self;
//    branchBankField.textAlignment = NSTextAlignmentRight;
//    branchBankField.placeholder = @"输入支行名称";
//    [branchBankField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(branchBankLabel.mas_centerY);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(SC_WIDTH-70);
//    }];

    
    sa_subMitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sa_subMitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sa_subMitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    sa_subMitBtn.backgroundColor = COLORFromRGB(0xe10000);
    sa_subMitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    sa_subMitBtn.layer.masksToBounds = YES;
    sa_subMitBtn.layer.cornerRadius = 5;
    [sa_subMitBtn addTarget:self action:@selector(writeCompletion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sa_subMitBtn];
    [sa_subMitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);

    }];
};
- (void)saChangeButtonStatus{
    sa_subMitBtn.enabled = YES;

}
/**
 点击确认按钮事件
 */
- (void)writeCompletion{
    //防止重复点击
    sa_subMitBtn.enabled = NO;
    [self performSelector:@selector(saChangeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    if ([bankNumbField.text isEqualToString:@""]||![shareDelegate checkCardNo:bankNumbField.text]) {
        [self saShowAlert:@"银行卡号输入不正确。"];
        
        return;
    }
    
    if ([openAccountField.text isEqualToString:@""]||![shareDelegate deptNameInputShouldChinese:openAccountField.text]||![shareDelegate isStringLengthName:openAccountField.text]) {
        [self saShowAlert:@"请输不可为空的、11个字以内的纯中文收款人名称。"];
        
        return;
    }
    if ([openAccountField.text isEqualToString:@""]) {
        
        [self saShowAlert:@"开户银行不可为空。"];
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
    
    [manager POST:[shareDelegate stringBuilder:SAVESETBANKINFO_URL] parameters:saDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            [self saShowAlertSuccese:responseObject[@"info"]];
            
        }else{
            [self saShowAlert:responseObject[@"info"]];
            
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
- (void)createNavgation{
    self.navigationItem.title = @"提现账户设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    CUSTOMBACKCONCTORLLER(leftBackClick,self,self.view,@"返回箭头红色",20,20)


}
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
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
/**
 警示 提示框
 */
- (void)saShowAlert:(NSString *)warning{
    
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
 警示 提示框
 */
- (void)saShowAlertSuccese:(NSString *)warning{
    
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
