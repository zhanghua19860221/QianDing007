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
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xffffff);

    
}
- (void)createSubView{
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
    bankNumbField = [[UITextField alloc] init];
    bankNumbField.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:bankNumbField];
    bankNumbField.delegate = self;
    bankNumbField.placeholder = @"输入银行卡号";
    [bankNumbField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    openAccountField = [[UITextField alloc] init];
    [self.view addSubview:openAccountField];
    openAccountField.textAlignment = NSTextAlignmentRight;
    openAccountField.delegate = self;
    openAccountField.placeholder = @"输入开户人";
    [openAccountField mas_makeConstraints:^(MASConstraintMaker *make) {
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
    openBankField = [[UITextField alloc] init];
    [self.view addSubview:openBankField];
    openBankField.textAlignment = NSTextAlignmentRight;
    openBankField.delegate = self;
    openBankField.placeholder = @"输入开户银行";
    [openBankField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(openBankLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH-70);
    }];
    
    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *branchBankLabel = [[UILabel alloc] init];
    branchBankLabel.text = @"支行名称";
    [self.view addSubview:branchBankLabel];
    [branchBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineThird);
        make.bottom.equalTo(lineThird).offset(-17);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    branchBankField = [[UITextField alloc] init];
    [self.view addSubview:branchBankField];
    branchBankField.delegate = self;
    branchBankField.textAlignment = NSTextAlignmentRight;
    branchBankField.placeholder = @"输入支行名称";
    [branchBankField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(branchBankLabel.mas_centerY);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(SC_WIDTH-70);
    }];

    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [okBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    okBtn.backgroundColor = COLORFromRGB(0xe10000);
    okBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    okBtn.layer.masksToBounds = YES;
    okBtn.layer.cornerRadius = 5;
    [okBtn addTarget:self action:@selector(writeCompletion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);

    }];
};

/**
 点击确认按钮事件
 */
- (void)writeCompletion{
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:0];
    [mutableArray addObject:bankNumbField.text];
    [mutableArray addObject:openAccountField.text];
    [mutableArray addObject:openBankField.text];
    [mutableArray addObject:branchBankField.text];

    PresentAccountController *account = [[PresentAccountController alloc] init];
    account.dataArray = mutableArray;
    [self.navigationController pushViewController:account animated:YES];
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"提现账户设置";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回箭头红色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
