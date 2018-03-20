//
//  ManageMoneyController.m
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ManageMoneyController.h"
#import "PresentAccountController.h"
#import "PresentRecordController.h"
#import "SetPresentAccountController.h"

@interface ManageMoneyController (){
    
    UIView      *topView;//顶部视图
    UITextField *moneyTextField;//提现金额
    UITextField *imageTextField;//图片验证码
    UITextField *teleTextField; //手机验证码
    UILabel *labelMoneyOne;//输入金额提示
    UILabel *labelMoney;//数据请求可提现金额
    float     tempMoney;    //记录总金额
    UILabel  *moneyFont; //箭头上方输入框联动金额
    UIButton *submitBtn;//数据提交按钮
    NSString *isSubmitInfo;//记录是否提交过银行卡信息

}

@end

@implementation ManageMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mmGetDateSource];
    [self mmCreateNavgation];
    [self mmCreateTopView];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //修改状态栏颜色 为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}
- (void)mmGetDateSource{
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSDictionary *mmDic =@{@"auth_session":oldSession};
    
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:GETMONEYSUBMIT_URL] parameters:mmDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            labelMoney.text =[NSString stringWithFormat:@"账户可提现金额%@元",responseObject[@"money"]];
            tempMoney = [responseObject[@"money"] floatValue];
            isSubmitInfo = responseObject[@"has_bank_info"];
            
        }else{
            [self mmShowAlert:responseObject[@"info"]];
            
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)mmCreateTopView{
    
    topView = [[UIView alloc] init];
    topView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(self.view).offset(84);
        }else{
            make.top.equalTo(self.view).offset(64);
            
        }
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(160/SCALE_Y);
    }];
    
    UIImageView *moneyIconView = [[UIImageView alloc] init];
    [moneyIconView setImage:[UIImage imageNamed:@"余额图标"]];
    [topView addSubview:moneyIconView];
    [moneyIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(20/SCALE_Y);
        make.left.equalTo(topView).offset(50/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(75);
    }];

    
    UIImageView *bankIconView = [[UIImageView alloc] init];
    [bankIconView setImage:[UIImage imageNamed:@"银行卡图标"]];
    [topView addSubview:bankIconView];
    [bankIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(20/SCALE_Y);
        make.right.equalTo(topView).offset(-50/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(75);
    }];
    
    moneyFont = [[UILabel alloc] init];
    moneyFont.text = @"";
    moneyFont.font = [UIFont systemFontOfSize:16];
    [moneyFont setTextColor:COLORFromRGB(0xff3e3e)];
    moneyFont.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:moneyFont];
    [moneyFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(40/SCALE_Y);
        make.left.equalTo(moneyIconView.mas_right);
        make.right.equalTo(bankIconView.mas_left);
        make.height.mas_equalTo(16);

    }];
    
    UIImageView *directionImage = [[UIImageView alloc] init];
    [directionImage setImage:[UIImage imageNamed:@"箭头"]];
    [topView addSubview:directionImage];
    [directionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyFont.mas_bottom).offset(10/SCALE_Y);
        make.left.equalTo(moneyIconView.mas_right).offset(10);
        make.right.equalTo(bankIconView.mas_left).offset(-10);
        make.height.mas_equalTo(10);
        
    }];
    
    labelMoney = [[UILabel alloc] init];
    labelMoney.text = @"0";
    labelMoney.font = [UIFont systemFontOfSize:16];
    [labelMoney setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:labelMoney];
    [labelMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyIconView.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(topView).offset(15);
        make.width.mas_equalTo(SC_WIDTH-150);
        make.height.mas_equalTo(16);
    }];
    
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonOne setImage:[UIImage imageNamed:@"提现账户"] forState:UIControlStateNormal];
    [self.view addSubview:buttonOne];
    [buttonOne addTarget:self action:@selector(toPresentAccount) forControlEvents:UIControlEventTouchUpInside];
    [buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(-30);
        make.right.equalTo(topView).offset(-80);
        make.width.height.mas_equalTo(60);
        
    }];
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:[UIImage imageNamed:@"提现记录"] forState:UIControlStateNormal];
    [self.view addSubview:buttonTwo];
    [buttonTwo addTarget:self action:@selector(toPresentRecode) forControlEvents:UIControlEventTouchUpInside];
    [buttonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(-30);
        make.right.equalTo(topView).offset(-10);
        make.width.height.mas_equalTo(60);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(80/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    moneyTextField = [[UITextField alloc] init];
    [self.view addSubview:moneyTextField];
    moneyTextField.delegate = self;
    moneyTextField.placeholder = @"请输入提现金额";
    [moneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.bottom.equalTo(line.mas_bottom).offset(-5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SC_WIDTH-50);
    }];

    labelMoneyOne = [[UILabel alloc] init];
    labelMoneyOne.text = @"金额不能小于100元";
    labelMoneyOne.textAlignment = NSTextAlignmentRight;
    [labelMoneyOne setTextColor:COLORFromRGB(0x999999)];
    labelMoneyOne.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labelMoneyOne];
    [labelMoneyOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-25);
        make.bottom.equalTo(line.mas_bottom).offset(-5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(125);
    }];
    
//    UIImageView *lineOne = [[UIImageView alloc] init];
//    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
//    [self.view addSubview:lineOne];
//    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(line.mas_bottom).offset(50/SCALE_Y);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(1);
//
//    }];
//    imageTextField = [[UITextField alloc] init];
//    [self.view addSubview:imageTextField];
//    imageTextField.delegate = self;
//    imageTextField.placeholder = @"图片验证码";
//    [imageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(25);
//        make.height.mas_equalTo(18);
//        make.width.mas_equalTo(SC_WIDTH/2.0);
//        make.bottom.equalTo(lineOne.mas_bottom).offset(-10);
//    }];
//
//    UIButton *imageCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    imageCodeBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"图片验证码"]];
//    [self.view addSubview:imageCodeBtn];
//    [imageCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(100);
//        make.bottom.equalTo(lineOne.mas_bottom);
//    }];
//
//    UIImageView *lineTwo = [[UIImageView alloc] init];
//    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
//    [self.view addSubview:lineTwo];
//    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(1);
//
//    }];
//    teleTextField = [[UITextField alloc] init];
//    [self.view addSubview:teleTextField];
//    teleTextField.delegate = self;
//    teleTextField.placeholder = @"电话验证码";
//    [teleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(25);
//        make.height.mas_equalTo(18);
//        make.width.mas_equalTo(SC_WIDTH/2.0);
//        make.bottom.equalTo(lineTwo.mas_bottom).offset(-10);
//    }];
//
//    UIButton *teleCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [teleCodeBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];
//    teleCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [teleCodeBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
//    [self.view addSubview:teleCodeBtn];
//    [teleCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(100);
//        make.bottom.equalTo(lineTwo.mas_bottom);
//    }];
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    submitBtn.layer.borderColor = COLORFromRGB(0xe10000).CGColor;
    submitBtn.layer.borderWidth = 1;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 22;
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(100/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
}
- (void)changeButtonStatus{
    submitBtn.enabled = YES;

}
- (void)submitBtnClick:(UIButton*)btn{
    
    float money = 100.00;

    //防止重复点击
    submitBtn.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    if ([moneyTextField.text isEqualToString:@""]) {
        [self mmShowAlert:@"提现金额不可为空"];
        return;
    }
    float textMoney = [moneyTextField.text floatValue];
    
    if (textMoney>tempMoney) {
        [self mmShowAlert:@"可提现总金额不足"];
        return;
    }
    if (textMoney<money) {
        [self mmShowAlert:@"不可小于100元"];
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
    
    NSDictionary *mmDic =@{@"auth_session":oldSession,
                           @"money":moneyTextField.text
                           };
    
    [shareDelegate shareAFHTTPSessionManager].requestSerializer = [AFHTTPRequestSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer = [AFJSONResponseSerializer serializer];
    [shareDelegate shareAFHTTPSessionManager].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [[shareDelegate shareAFHTTPSessionManager] POST:[shareDelegate stringBuilder:POSTMONEYSUBMIT_URL] parameters:mmDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
 
            [self mmShowAlert:responseObject[@"info"]];

        }else{
            [self mmShowAlert:responseObject[@"info"]];

        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
/**
 跳转到提现账户页面
 */
- (void)toPresentAccount{
    
    if ([isSubmitInfo isEqualToString:@"1"]) {
        
        PresentAccountController *presentAccount = [[PresentAccountController alloc]init];
        [self.navigationController pushViewController:presentAccount animated:YES];
    }else{
        SetPresentAccountController *setAccount = [[SetPresentAccountController alloc]init];
        [self.navigationController pushViewController:setAccount animated:YES];
        
    }

}
/**
 跳转到提现记录页面
 */
- (void)toPresentRecode{

    PresentRecordController *recode = [[PresentRecordController alloc]init];
    [self.navigationController pushViewController:recode animated:YES];
    
}

/**
 创建导航栏
 */
- (void)mmCreateNavgation{
    
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        if (SC_HEIGHT == 812) {
            make.height.mas_equalTo(84);
        }else{
            make.height.mas_equalTo(64);

        }
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(navView).offset(55);
        }else{
            make.top.equalTo(navView).offset(31);

        }
        make.left.equalTo(navView).offset(15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"资金管理";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(navView).offset(44);
        }else{
            make.top.equalTo(navView).offset(20);

        }
        make.centerX.equalTo(navView.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    NSLog(@"当输入框开始时触发");
}
/**
 询问输入框是否可以结束编辑 ( 键盘是否可以收回)
 
 */
- (BOOL)textFieldShouldEndEditing:( UITextField*)textField{
    NSLog(@"是否可以结束编辑");

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
 
 实时获取输入框信息
 */
- (void)textFieldEditChanged:(UITextField *)textField{
    
    //当开始输入小数点时 自动补零
    if ([textField.text isEqualToString:@"."]) {
        moneyTextField.text = @"0.";
        
    }
    if ([textField.text isEqual:@"00"]) {
        moneyTextField.text = @"0";
        return;
    }
    NSArray * array=[textField.text componentsSeparatedByString:@"."];
    
    NSInteger count=[array count]-1;
    if (count > 1 ) {
        NSMutableString *tempStr =[NSMutableString stringWithString:textField.text];
        [tempStr deleteCharactersInRange:NSMakeRange((tempStr.length-1), 1)];
        moneyTextField.text = tempStr;
        
    }
    
    moneyFont.text = textField.text;

    float temp = [textField.text floatValue];
    if (temp>=100) {
        labelMoneyOne.hidden = YES;
    }else{
        labelMoneyOne.hidden = NO;
    }
    
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
- (void)mmShowAlert:(NSString *)warning{
    
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
