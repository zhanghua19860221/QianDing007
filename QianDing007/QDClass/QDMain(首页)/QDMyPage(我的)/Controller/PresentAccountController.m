//
//  PresentAccountController.m
//  QianDing007
//
//  Created by 张华 on 17/12/25.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "PresentAccountController.h"
#import "EditAccountController.h"
@interface PresentAccountController (){

    UILabel *s_BankNumbLabel;   //银行卡号
    UILabel *s_OpenAccountLabel;//开户人
    UILabel *s_OpenBankLabel;   //开户银行
    UILabel *s_BranchBankLabel; //支行名称
    UIView  *s_MaskView;        //背景蒙板
    UITextField *codeField;     //验证码


}
@end

@implementation PresentAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paCreateNavgation];
    [self paCreateSubView];
    [self paCreateReMoveView];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    [self paGetDateSource];


}
- (void)paGetDateSource{
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
    
    [manager POST:[shareDelegate stringBuilder:GETBANKINFO_URL] parameters:paDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            s_BankNumbLabel.text = responseObject[@"bank_info"];
            s_OpenAccountLabel.text = responseObject[@"bank_user"];
            s_OpenBankLabel.text = responseObject[@"bank_name"];

        }else{

        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)paCreateReMoveView{
    
    s_MaskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    s_MaskView.hidden = YES;
    s_MaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:s_MaskView];
    
    
    UIView *showBJView = [[UIView alloc] init];
    showBJView.backgroundColor = COLORFromRGB(0xffffff);
    [s_MaskView addSubview:showBJView];
    showBJView.layer.masksToBounds = YES;
    showBJView.layer.cornerRadius = 4;
    [showBJView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(s_MaskView).offset(220/SCALE_Y);
        make.left.equalTo(s_MaskView).offset(15);
        make.right.equalTo(s_MaskView).offset(-15);
        make.height.mas_equalTo(219);

    
    }];
    
    
    NSString *replaceStr = @"验证码已发送到登录手机号13333333322请注意查收.";
    int startLocation = 15;
    for (NSInteger i = 0; i < 4; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation++;
        
    }
    
    
    UILabel *showLabel = [[UILabel alloc] init];
    showLabel.text = replaceStr;
    [showLabel setTextColor:COLORFromRGB(0x333333)];
    showLabel.font = [UIFont systemFontOfSize:16] ;
    showLabel.numberOfLines = 0;
    showLabel.textAlignment = NSTextAlignmentLeft;
    [showBJView addSubview:showLabel];
    CGRect rect = [showLabel.text boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showBJView).offset(30);
        make.left.equalTo(showBJView).offset(30);
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(rect.size.height);
    
    }];
    
    codeField = [[UITextField alloc] init];
    [showBJView addSubview:codeField];
    codeField.delegate = self;
    codeField.backgroundColor = COLORFromRGB(0xf9f9f9);
    codeField.textAlignment = NSTextAlignmentCenter;
    codeField.placeholder = @"输入验证码";
    [codeField setTextColor:COLORFromRGB(0xd1d1d1)];
    [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showLabel.mas_bottom).offset(20);
        make.left.equalTo(showBJView).offset(30/SCALE_X);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(190);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"倒计时50S" forState:UIControlStateNormal];
    [button setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [showBJView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeField.mas_centerY);
        make.right.equalTo(showBJView).offset(-30/SCALE_X);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(50);

    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [showBJView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeField.mas_bottom).offset(20);
        make.right.equalTo(showBJView).offset(-30/SCALE_X);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(25);
        
        
        
    }];
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [showBJView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sureBtn.mas_centerY);
        make.right.equalTo(sureBtn.mas_left).offset(-30/SCALE_X);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(25);
    
    }];

}


/**
 删除弹出框确认删除按钮点击事件
 */
- (void)sureBtnClick{

    
    s_MaskView.hidden = YES;


}
/**
 删除弹出框取消删除按钮点击事件
 */
- (void)cancleBtnClick{
    
    s_MaskView.hidden = YES;

    
}
- (void)paCreateSubView{
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
    bankNumLabel.text = @"银行卡号";
    [self.view addSubview:bankNumLabel];
    [bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.bottom.equalTo(line).offset(-17);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    s_BankNumbLabel = [[UILabel alloc] init];
    s_BankNumbLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:s_BankNumbLabel];
    s_BankNumbLabel.text = self.dataArray[0];
    [s_BankNumbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bankNumLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(16);
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
    s_OpenAccountLabel = [[UILabel alloc] init];
    [self.view addSubview:s_OpenAccountLabel];
    s_OpenAccountLabel.textAlignment = NSTextAlignmentRight;
    s_OpenAccountLabel.text = self.dataArray[1];
    [s_OpenAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(openAccountLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(16);
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
    s_OpenBankLabel = [[UILabel alloc] init];
    [self.view addSubview:s_OpenBankLabel];
    s_OpenBankLabel.textAlignment = NSTextAlignmentRight;
    s_OpenBankLabel.text = self.dataArray[2];
    [s_OpenBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(openBankLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(16);
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
//    s_BranchBankLabel = [[UILabel alloc] init];
//    [self.view addSubview:s_BranchBankLabel];
//    s_BranchBankLabel.textAlignment = NSTextAlignmentRight;
//    s_BranchBankLabel.text = self.dataArray[3];
//    [s_BranchBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.equalTo(branchBankLabel.mas_centerY);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(SC_WIDTH-70);
//    }];

    
//    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//    [deleteBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
//    deleteBtn.backgroundColor = COLORFromRGB(0xe10000);
//    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    deleteBtn.layer.masksToBounds = YES;
//    deleteBtn.layer.cornerRadius = 5;
//    [deleteBtn addTarget:self action:@selector(deleteAccount) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:deleteBtn];
//    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineTwo.mas_bottom).offset(100);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        make.height.mas_equalTo(50);
//
//    }];
};
/**
 创建导航栏
 */
- (void)paCreateNavgation{
    
    self.navigationItem.title = @"提现账户";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    [leftButton setImage:[UIImage imageNamed:@"返回箭头红色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40,40);
    [rightButton setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
/**
 导航栏左侧按钮
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 点击删除按钮事件

 */
- (void)deleteAccount{
    
    s_MaskView.hidden = NO;
    
}

/**
 导航栏右侧按钮
 */
- (void)rightBackClick{
    
    EditAccountController *editVc = [[EditAccountController alloc] init];
    [self.navigationController pushViewController:editVc animated:YES];
    
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
//    [bankNumbField resignFirstResponder];
//    [openAccountField resignFirstResponder];
//    [openBankField resignFirstResponder];
//    [branchBankField resignFirstResponder];
    
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
