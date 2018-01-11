//
//  BecomeDelegateController.m
//  QianDing007
//
//  Created by 张华 on 17/12/28.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "BecomeDelegateController.h"

@interface BecomeDelegateController (){

    UITextField *cityField;   //详细地址
    UITextField *nameField;   //姓名
    UITextField *teleField;   //联系电话
    UITextField *emailField;  //邮箱
    UITextField *addressField;//地址

}

@end

@implementation BecomeDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self creatSubView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    
    
}
- (void)creatSubView{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"欢迎加入钱叮，";
    label.font = [UIFont systemFontOfSize:14];
    [label setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+20/SCALE_Y);
        make.left.equalTo(self.view).offset(40/SCALE_X);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(SC_WIDTH-40/SCALE_X);

    }];
    UILabel *labelOne = [[UILabel alloc] init];
    labelOne.text = @"请填写您的信息，务必保证电话畅通，";
    labelOne.font = [UIFont systemFontOfSize:14];
    [labelOne setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:labelOne];
    [labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(12);
        make.left.equalTo(self.view).offset(40/SCALE_X);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(SC_WIDTH-40/SCALE_X);
        
    }];
    
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"我们的招商经理将会为您提供专业的服务！";
    labelTwo.font = [UIFont systemFontOfSize:14];
    [labelTwo setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:labelTwo];
    [labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelOne.mas_bottom).offset(12);
        make.left.equalTo(self.view).offset(40/SCALE_X);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(SC_WIDTH-40/SCALE_X);
        
    }];

    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelTwo.mas_bottom).offset(70/SCALE_Y);
        make.left.equalTo(self.view).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *cityLabel = [[UILabel alloc] init];
    cityLabel.font = [UIFont systemFontOfSize:16];
    cityLabel.textAlignment = NSTextAlignmentLeft;
    cityLabel.text = @"合作城市";
    [cityLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(50);
        
    }];
    cityField = [[UITextField alloc] init];
    [self.view addSubview:cityField];
    cityField.delegate = self;
    cityField.textAlignment = NSTextAlignmentLeft;
    cityField.font = [UIFont systemFontOfSize:16];
    [cityField setTextColor:COLORFromRGB(0x666666)];
    cityField.placeholder = @"城市";
    [cityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(50);
    }];

    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = @"姓      名";
    [nameLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(50);
        
    }];
    nameField = [[UITextField alloc] init];
    [self.view addSubview:nameField];
    nameField.delegate = self;
    nameField.textAlignment = NSTextAlignmentLeft;
    nameField.font = [UIFont systemFontOfSize:16];
    [nameField setTextColor:COLORFromRGB(0x666666)];
    nameField.placeholder = @"姓名";
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(50);
    }];
    
    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    
    UILabel *teleLabel = [[UILabel alloc] init];
    teleLabel.font = [UIFont systemFontOfSize:16];
    teleLabel.textAlignment = NSTextAlignmentLeft;
    teleLabel.text = @"联系电话";
    [teleLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:teleLabel];
    [teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(50);
        
    }];
    teleField = [[UITextField alloc] init];
    [self.view addSubview:teleField];
    teleField.delegate = self;
    teleField.textAlignment = NSTextAlignmentLeft;
    teleField.font = [UIFont systemFontOfSize:16];
    [teleField setTextColor:COLORFromRGB(0x666666)];
    teleField.placeholder = @"电话";
    [teleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(50);
    }];
    
    
    UIImageView *lineThree = [[UIImageView alloc] init];
    lineThree.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineThree];
    [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    
    UILabel *emailLabel = [[UILabel alloc] init];
    emailLabel.font = [UIFont systemFontOfSize:16];
    emailLabel.textAlignment = NSTextAlignmentLeft;
    emailLabel.text = @"电子邮箱";
    [emailLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThree.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(50);
        
    }];
    emailField = [[UITextField alloc] init];
    [self.view addSubview:emailField];
    emailField.delegate = self;
    emailField.textAlignment = NSTextAlignmentLeft;
    emailField.font = [UIFont systemFontOfSize:16];
    [emailField setTextColor:COLORFromRGB(0x666666)];
    emailField.placeholder = @"邮箱";
    [emailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThree.mas_bottom);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(50);
    }];
    
    
    
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThree.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:16];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = @"地    址";
    [addressLabel setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFour.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(50);
        
    }];
    addressField = [[UITextField alloc] init];
    [self.view addSubview:addressField];
    addressField.delegate = self;
    addressField.textAlignment = NSTextAlignmentLeft;
    addressField.font = [UIFont systemFontOfSize:16];
    [addressField setTextColor:COLORFromRGB(0x666666)];
    addressField.placeholder = @"地址";
    [addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFour.mas_bottom);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(50);
    }];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [submitBtn.titleLabel setTextColor:COLORFromRGB(0xffffff)];
    submitBtn.backgroundColor = COLORFromRGB(0xe10000);
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(bdSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(SC_WIDTH-30);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];

}
- (void)bdSubmitBtnClick{

    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];

    NSDictionary *bdDic =@{@"auth_session":oldSession,
                           @"tel":teleField.text,
                           @"name":nameField.text,
                           @"address":addressField.text,
                           @"city":cityField.text,
                           @"email":emailField.text
                           
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:DELEGATE_URL parameters:bdDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"%@",[shareDelegate logDic:responseObject]);
       
        [self lgShowAlert:responseObject[@"info"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"加入";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
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

#pragma ********************UITextFieldDelegate**************
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
 警示 弹出框
 */
- (void)lgShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
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
