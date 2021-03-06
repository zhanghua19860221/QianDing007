//
//  ScanCodeController.m
//  QianDing007
//
//  Created by 张华 on 18/1/5.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "ScanCodeController.h"
#import "ZHScanViewController.h"
@interface ScanCodeController (){
    UITextField * sc_moneyField;
    UITextField * sc_moneyOneField;
    NSString    * sc_recordMoney;//拼接赋值字符串
    NSMutableString * sc_oldMoney;//一个个清除数据记录
    UIView *sc_topView;//头部视图
    UIView *sc_calculatorView;//计算器视图
    
    NSString *tempPoint;//初始化“.”统计输入的数字字符串中 点的个数
    BOOL isHaveDian ;//判断字符串中是否有点
    int  maxMoney;   //记录收取的最大金额

    
}
@end

@implementation ScanCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  scCreateTopView];
    [self  scCreateCalculator];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏TabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    //修改状态栏颜色 为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

/**
 创建计算器视图
 */
- (void)scCreateCalculator{
    
    sc_calculatorView = [[UIView alloc] init];
    sc_calculatorView.layer.masksToBounds = YES;
    sc_calculatorView.layer.cornerRadius = 3;
    sc_calculatorView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:sc_calculatorView];
    [sc_calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sc_topView.mas_bottom).offset(-80);
        make.left.equalTo(self.view).offset(15/SCALE_X);
        make.right.equalTo(self.view).offset(-15/SCALE_X);
        make.height.mas_equalTo(405/SCALE_Y);
        
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"收款金额：";
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    [moneyLabel setTextColor:COLORFromRGB(0x666666)];
    moneyLabel.font = [UIFont systemFontOfSize:20];
    [sc_calculatorView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sc_calculatorView);
        make.left.equalTo(sc_calculatorView).offset(10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(70);
        
    }];
    
    sc_moneyOneField = [[UITextField alloc] init];
    sc_moneyOneField.text = @"￥";
    sc_moneyOneField.delegate = self;
    sc_moneyOneField.textAlignment = NSTextAlignmentRight;
    sc_moneyOneField.font = [UIFont systemFontOfSize:20];
    [sc_moneyOneField setTextColor:COLORFromRGB(0xe10000)];
    [sc_calculatorView addSubview:sc_moneyOneField];
    [sc_moneyOneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyLabel.mas_centerY);
        make.right.equalTo(sc_calculatorView).offset(-10);
        make.width.mas_equalTo(SC_WIDTH-160);
        make.height.mas_equalTo(70/SCALE_Y);
        
    }];
    
    NSArray * calculatorBtn=@[@"1",@"2",@"3",@"",@"4",@"5",@"6",@"清除",@"7",@"8",@"9",@"",@"0",@".",@"00",@""];
    
    UIView *calculatorView = [[UIView alloc] init];
    [self.view addSubview:calculatorView];
    [calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sc_moneyOneField.mas_bottom);
        make.left.equalTo(self.view).offset(25/SCALE_X);
        make.right.equalTo(self.view).offset(-25/SCALE_X);
        make.bottom.equalTo(sc_calculatorView.mas_bottom).offset(-10);

    }];
    
    float cWidth = 325/SCALE_X;
    float cHeight= 325/SCALE_X;

    
    for (int i = 0; i<calculatorBtn.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = COLORFromRGB(0xffffff);
        [button setTitle:calculatorBtn[i] forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.masksToBounds = YES ;
        button.layer.cornerRadius = 2;
        button.titleLabel.font = [UIFont systemFontOfSize:35];
        [button.titleLabel setTextColor:COLORFromRGB(0x333333)];
        button.layer.borderColor = [COLORFromRGB(0xebebeb) CGColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [calculatorView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((cWidth-15)/4, (cHeight-15)/4));
            make.top.mas_equalTo((i/4*5)+(i/4)*(cHeight-15)/4);
            make.left.mas_equalTo(((cWidth-15)/4)*(i%4)+(i%4)*5);
            
        }];
        if (i == 11 || i == 15) {
            button.hidden=YES;
        }
        if (i == 3 || i == 7) {
            button.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        if (i == 3) {
            [button setImage:[UIImage imageNamed:@"清除"] forState:UIControlStateNormal];
        }
        
    }
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonOne setTitle:@"收款" forState:UIControlStateNormal];
    [buttonOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonOne.backgroundColor=[UIColor whiteColor];
    buttonOne.layer.borderWidth = 1;
    buttonOne.layer.masksToBounds = YES ;
    buttonOne.layer.cornerRadius = 2;
    buttonOne.titleLabel.font = [UIFont systemFontOfSize:25];
    [buttonOne.titleLabel setTextColor:COLORFromRGB(0x333333)];
    buttonOne.layer.borderColor = [COLORFromRGB(0xebebeb) CGColor];
    [buttonOne addTarget:self action:@selector(buttonOneClick:) forControlEvents:UIControlEventTouchUpInside];
    [calculatorView addSubview:buttonOne];
    [buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-25/SCALE_X);
        make.size.mas_equalTo(CGSizeMake((cWidth-15)/4,5+2*(cHeight-15)/4));
        make.top.mas_equalTo(10+2*(cHeight-15)/4);
    }];
    

}

/**
 计算器 按钮 点击事件
 
 */
- (void)buttonClick:(UIButton*)btn{
    maxMoney = 1000000000;

    switch (btn.tag) {
        case 100:

        case 101:

        case 102:

        case 104:

        case 105:

        case 106:

        case 108:

        case 109:

        case 110:{
            //当开始输入小数点时 自动补零
            if ([sc_moneyField.text isEqual:@"￥."]&&[sc_moneyOneField.text isEqual:@"￥."]) {
                sc_moneyField.text = @"￥0.";
                sc_moneyOneField.text = @"￥0.";
                
            }
            if ([sc_moneyField.text isEqual:@"￥0"] && ![btn.currentTitle isEqual:@"."]  ) {
                sc_moneyField.text = @"￥0";
                sc_moneyOneField.text = @"￥0";
                break;
            }

            // 小数点后最多输入两位
            if ([sc_recordMoney containsString:@"."]) {
                isHaveDian = YES;
            }else{
                isHaveDian = NO;
            }

            if (isHaveDian) {
                NSUInteger secondLoc = [sc_recordMoney rangeOfString:@"."].location;
                NSUInteger length = sc_recordMoney.length;
                NSUInteger difference = length-secondLoc;
                if (difference >=3) {
                    break;
                }else{
                    sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
                }
            }else{
                sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
            }
            //截取掉下标3之后的字符串
            {
                NSString *tempStrOne = [sc_recordMoney substringFromIndex:1];
                int tempMoneyOne = [tempStrOne intValue];
                //最大限额控制
                if (tempMoneyOne > maxMoney) {
                    
                    break;
                }
            }
            sc_moneyField.text = sc_recordMoney;
            sc_moneyOneField.text = sc_recordMoney;
    }
            break;
            
            case 112:
            //当开始输入小数点时 自动补零
            if ([sc_moneyField.text isEqual:@"￥."]&&[sc_moneyOneField.text isEqual:@"￥."]) {
                    sc_moneyField.text = @"￥0.";
                    sc_moneyOneField.text = @"￥0.";

            }else if([sc_moneyField.text isEqual:@"￥0"]&&[sc_moneyOneField.text isEqual:@"￥0"]){
                
                break;
            }
            // 小数点后最多输入两位小数
            if ([sc_recordMoney containsString:@"."]) {
                isHaveDian = YES;
            }else{
                isHaveDian = NO;
            }
            if (isHaveDian) {
                NSUInteger secondLoc = [sc_recordMoney rangeOfString:@"."].location;
                NSUInteger length = sc_recordMoney.length;
                NSUInteger difference = length-secondLoc;
                if (difference >=3) {
                    break;
                }else{
                    sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
                }
            }else{
                sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
            }
            //截取掉下标3之后的字符串
            {
                NSString *tempStrOne = [sc_recordMoney substringFromIndex:1];
                int tempMoneyOne = [tempStrOne intValue];
                //最大限额控制
                if (tempMoneyOne > maxMoney) {
                
                    break;
                }
            }
            sc_moneyField.text = sc_recordMoney;
            sc_moneyOneField.text = sc_recordMoney;
            break;
        case 113:{
            tempPoint = @".";
            //当开始输入小数点时 自动补零
            if ([sc_moneyField.text isEqual:@"￥."]&&[sc_moneyOneField.text isEqual:@"￥."]) {
                sc_moneyField.text = @"￥0.";
                sc_moneyOneField.text = @"￥0.";
                
            }
            // 小数点后最多输入两位小数
            if ([sc_recordMoney containsString:@"."]) {
                isHaveDian = YES;
            }else{
                isHaveDian = NO;
            }
            if (isHaveDian) {
                NSUInteger secondLoc = [sc_recordMoney rangeOfString:@"."].location;
                NSUInteger length = sc_recordMoney.length;
                NSUInteger difference = length-secondLoc;
                if (difference >=3) {
                    break;
                }else{
                    sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
                }
            }else{
                sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
            }
            NSArray * array=[sc_recordMoney componentsSeparatedByString:tempPoint];

            NSInteger count=[array count]-1;

            if (count > 1 ) {
                NSMutableString *tempStr =[NSMutableString stringWithString:sc_recordMoney];
                [tempStr deleteCharactersInRange:NSMakeRange((tempStr.length-1), 1)];
                sc_recordMoney = tempStr;

            }
            //截取掉下标3之后的字符串
            {
                NSString *tempStrOne = [sc_recordMoney substringFromIndex:1];
                int tempMoneyOne = [tempStrOne intValue];
                //最大限额控制
                if (tempMoneyOne > maxMoney) {
                    
                    break;
                }
            }
            sc_moneyField.text = sc_recordMoney;
            sc_moneyOneField.text = sc_recordMoney;
    }
            break;
        case 114:
            //当开始输入小数点时 自动补零
            if ([sc_moneyField.text isEqual:@"￥."]&&[sc_moneyOneField.text isEqual:@"￥."]) {
                sc_moneyField.text = @"￥0.";
                sc_moneyOneField.text = @"￥0.";
                     //当输入框只有一个零时 ，00不可输入
            }else if ([sc_moneyField.text isEqualToString:@"￥0"] && ![btn.currentTitle isEqualToString:@"."]  ) {
                sc_moneyField.text = @"￥0";
                sc_moneyOneField.text = @"￥0";
                break;
            }else if([sc_moneyField.text isEqual:@"￥"]){
                
                break;
            }
            // 小数点后最多输入两位小数
            if ([sc_recordMoney containsString:@"."]) {
                isHaveDian = YES;
            }else{
                isHaveDian = NO;
            }
            if (isHaveDian) {
                NSUInteger secondLoc = [sc_recordMoney rangeOfString:@"."].location;
                NSUInteger length = sc_recordMoney.length;
                NSUInteger difference = length-secondLoc;
                if (difference >=3) {
                    break;
                }else{
                    sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
                }
            }else{
                sc_recordMoney=[sc_moneyField.text stringByAppendingString:btn.currentTitle];
            }
            //截取掉下标3之后的字符串
            {
                NSString *tempStrOne = [sc_recordMoney substringFromIndex:1];
                int tempMoneyOne = [tempStrOne intValue];
                //最大限额控制
                if (tempMoneyOne > maxMoney) {
                
                break;
                }
            }
            sc_moneyField.text = sc_recordMoney;
            sc_moneyOneField.text = sc_recordMoney;
            
            break;
        case 103:
            //删除数字时。将utf。text转化为可变字符串从最后一个开始删除，设置长度为0时给text赋值为0否则崩溃
            sc_oldMoney = [NSMutableString stringWithString:sc_moneyField.text];
            [sc_oldMoney deleteCharactersInRange:NSMakeRange(sc_oldMoney.length-1, 1)];
            sc_recordMoney = sc_oldMoney;
            sc_moneyField.text = sc_oldMoney;
            sc_moneyOneField.text = sc_oldMoney;
            
            if (sc_moneyField.text.length == 0) {
                sc_moneyField.text = @"￥";
                sc_moneyOneField.text = @"￥";
                
            }
            break;
        case 107:
            sc_recordMoney = nil;
            sc_moneyField.text = @"￥";
            sc_moneyOneField.text = @"￥";
            break;
        default:
            break;
    }
    

}
/**
 计算器 收款 按钮 点击事件
 
 */
- (void)buttonOneClick:(UIButton*)btn{
    [self judgeCameraLimits];

}
/**
 判断是否有调用摄像头的权限提醒
 */
- (void)judgeCameraLimits{
    /// 先判断摄像头硬件是否好用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        // 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        // 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            [self scShowAlertOpenCamera:@"摄像头访问受限,前往设置"];
            
        }else{
            
            NSMutableString *tempMoney = [NSMutableString stringWithString:sc_moneyField.text];
            [tempMoney deleteCharactersInRange:NSMakeRange(0, 1)];
            [[shareDelegate shareNSUserDefaults] setObject:tempMoney forKey:@"money_count"];
            
            ZHScanViewController *zhVc = [[ZHScanViewController alloc] init];
            [self.navigationController pushViewController:zhVc animated:YES];
            
        }
    } else {
        [self scShowAlert:@"摄像头不可用、请检查手机摄像头设备"];
        
    }
}
/**
 设置打开摄像头
 
 */
- (void)scShowAlertOpenCamera:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
            //获取当前系统版本号
            NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
            if (![phoneVersion isEqualToString:@"ios10"]) {
                   [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
             }
                                                              
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 警示 弹出框
 */
- (void)scShowAlert:(NSString *)warning{
    
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
/**
 创建头部视图
 */
- (void)scCreateTopView{
    sc_topView = [[UIView alloc] init];
    sc_topView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:sc_topView];
    [sc_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        if (SC_HEIGHT == 812) {
            make.height.mas_equalTo(84+200/SCALE_Y);

        }else{
            make.height.mas_equalTo(64+200/SCALE_Y);

        }
        
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回图标白色"] forState:UIControlStateNormal];
    [sc_topView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.equalTo(sc_topView).offset(44);

        }else{
            make.top.equalTo(sc_topView).offset(20);

        }
        make.left.equalTo(sc_topView).offset(15);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(40);
 
    }];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backBtn);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        
    }];
    
    
    
    UILabel *titLabel = [[UILabel alloc] init];
    titLabel.text = @"收款金额";
    titLabel.font = [UIFont systemFontOfSize:18];
    [titLabel setTextColor:COLORFromRGB(0xffffff)];
    [sc_topView addSubview:titLabel];
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backBtn.mas_centerY);
        make.centerX.equalTo(sc_topView.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
        
    }];
    
    sc_moneyField = [[UITextField alloc] init];
    sc_moneyField.text = @"￥";
    sc_moneyField.delegate = self;
    sc_moneyField.textAlignment = NSTextAlignmentCenter;
    sc_moneyField.font = [UIFont systemFontOfSize:45];
    [sc_moneyField setTextColor:COLORFromRGB(0xffffff)];
    [sc_topView addSubview:sc_moneyField];
    [sc_moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titLabel.mas_bottom).offset(40);
        make.left.equalTo(sc_topView);
        make.width.equalTo(sc_topView);
        make.height.mas_equalTo(50);
        
    }];
}

/**
 导航栏 返回按钮 点击事件
 */
- (void)backBtnClick{
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];

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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //修改状态栏颜色 为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

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
