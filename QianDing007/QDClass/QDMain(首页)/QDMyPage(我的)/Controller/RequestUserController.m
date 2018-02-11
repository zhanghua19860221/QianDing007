//
//  RequestUserController.m
//  QianDing007
//
//  Created by 张华 on 17/12/23.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "RequestUserController.h"

@interface RequestUserController (){

    UIView *firstView;
    UIView *secondView;
    UIView *thirdView;
    UILabel *ru_teleLabel;//商户邀请码
}
@end

@implementation RequestUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFirstView];
    [self createSecondView];
    [self createThirdView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)createFirstView{
    
    firstView = [[UIView alloc] init];
    firstView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(120/SCALE_Y);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"代理商邀请码";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [firstView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView).offset(30/SCALE_Y);
        make.left.equalTo(firstView).offset(15);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(16);
    
    }];
    
    NSString *requestCode = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    NSString *phoneStr = [NSString stringWithFormat:@"a%@",requestCode];
    ru_teleLabel = [[UILabel alloc] init];
    ru_teleLabel.text = phoneStr;
    ru_teleLabel.textAlignment = NSTextAlignmentCenter;
    [firstView addSubview:ru_teleLabel];
    [ru_teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(firstView).offset(85/SCALE_X);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(23);
        
    }];
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    copyBtn.backgroundColor = COLORFromRGB(0xbfbfbf);
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyBtn setTitleColor:COLORFromRGB(0xf5f5f5) forState:UIControlStateNormal];
    [copyBtn addTarget:self action:@selector(copyBtn) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ru_teleLabel.mas_centerY);
        make.left.equalTo(ru_teleLabel.mas_right).offset(10);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(25);
        
    }];
    
}

/**
 复制按钮点击事件
 */
- (void)copyBtn{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = ru_teleLabel.text;
    [self rqShowAlert:@"复制成功"];

}
/**
 警示 弹出框
 */
- (void)rqShowAlert:(NSString *)warning{
    
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
- (void)createSecondView{
    secondView = [[UIView alloc] init];
    secondView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(268/SCALE_Y);
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.text = @"扫一扫，邀请商户";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView).offset(30/SCALE_Y);
        make.left.equalTo(secondView).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
        
    }];
    
    UIImageView *codeView = [[UIImageView alloc] init];
    [secondView addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeLabel.mas_bottom).offset(20/SCALE_Y);
        make.centerX.equalTo(secondView.mas_centerX);
        make.width.mas_equalTo(172);
        make.height.mas_equalTo(172);
        
    }];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@&auth_session=%@&type=%@",REQUESTCODE_URL,oldSession,@"agency"];
    [codeView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"二维码占位图"]];
    
}

- (void)createThirdView{
    thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];
    UILabel *sendLabel = [[UILabel alloc] init];
    sendLabel.text = @"发送消息邀请注册";
    sendLabel.textAlignment = NSTextAlignmentCenter;
    [thirdView addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdView).offset(30/SCALE_Y);
        make.left.equalTo(thirdView).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
        
    }];
    
    
    UIView *iconBJView = [[UIView alloc] init];
    iconBJView.backgroundColor = COLORFromRGB(0xffffff);
    [thirdView addSubview:iconBJView];
    [iconBJView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(sendLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(thirdView).offset(52.5/SCALE_X);
        make.right.equalTo(thirdView).offset(-52.5/SCALE_X);
        make.height.mas_equalTo(60);
        
    }];
    
    NSArray *loginViewArray = @[@"微信@2x",@"QQ",@"通讯录"];
    NSArray *loginLabelArray = @[@"微信邀请",@"QQ邀请",@"通讯录邀请"];

    UIButton *tempBtn = nil;
    for (int i = 0; i<3 ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:loginViewArray[i]] forState:UIControlStateNormal];
        button.tag = 260+i;
        [iconBJView addSubview:button];
        [button addTarget:self action:@selector(requestViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBJView);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right).offset(45/SCALE_X);
            }else{
                
                make.left.equalTo(iconBJView);
            }
            make.width.height.mas_equalTo(60/SCALE_Y);
            
        }];
        UILabel *label = [[UILabel alloc] init];
        label.text = loginLabelArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [label setTextColor:COLORFromRGB(0x333333)];
        [iconBJView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.top.equalTo(button.mas_bottom).offset(10);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(80);
            
        }];
        tempBtn = button;
    }
    
}
/**
 邀请对应类型按钮点击事件
 */
- (void)requestViewClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 260:{
            [self ruShareWeChat];
        }
            break;
        case 261:{
            [self ruShareTencent];
            
        }
            break;
        case 262:{
            [self ruShareMailList];
            
        }
            break;
            
        default:
            break;
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    [self createNavgation];
    
    
}

/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"邀请商家";
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//弹出 分享结果 视图初始化
-(void)ruShareStataView:(NSString * ) stata{
    //收藏时提示框 视图
    UIView *promptBox = [[UIView alloc] init];
    [self.view addSubview:promptBox];

    [UIView animateWithDuration:1 animations:^{
        promptBox.backgroundColor = [COLORFromRGB(0x000000) colorWithAlphaComponent:0.5];
        promptBox.layer.cornerRadius=8;
        promptBox.layer.masksToBounds=YES;
        [promptBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view.mas_centerY).offset(50);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(40);
            
        }];
        
        UILabel*lable=[[UILabel alloc] init];
        lable.text= stata ;
        lable.textAlignment=NSTextAlignmentCenter;
        [lable setTextColor:COLORFromRGB(0xffffff)];
        lable.font=[UIFont boldSystemFontOfSize:16];
        [promptBox addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(promptBox);
            make.centerY.equalTo(promptBox.mas_centerY);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
            
        }];
        
    } completion:^(BOOL finished) {
        
        [promptBox removeFromSuperview];
        
    }];
}
/**
 微信分享
 */
- (void)ruShareWeChat{

    //本地保存用户 手机号 数据
    NSString *sharePhone = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    NSString *tempPhone =  [NSString stringWithFormat:@"a%@",sharePhone];
    NSString *tempStr = @"http://101.201.117.15/wap/index.php?ctl=qd_user&act=Register&invite_code=";
    NSString *inviteUrl = [NSString stringWithFormat:@"%@%@",tempStr,tempPhone];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:SHATETEXT
                                     images:[UIImage imageNamed:@"LOGO"]
                                        url:[NSURL URLWithString:inviteUrl]
                                      title:SHATETITLE
                                       type:SSDKContentTypeWebPage
     ];
    //开始进行分享
    [ShareSDK showShareEditor:SSDKPlatformTypeWechat
           otherPlatformTypes:nil
                  shareParams:shareParams
          onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end){
              
              NSLog(@"state == %lu",(unsigned long)state);
              
              
              switch (state) {
                      
                  case SSDKResponseStateSuccess:{
                      [self ruShareStataView:@"分享成功"];
                      
                      
                  }
                      break;
                  case SSDKResponseStateFail:{
                      [self ruShareStataView:@"分享失败"];
                      
                  }
                      break;
                      
                  case SSDKResponseStateCancel:{
                      //                     [self shareStataView:@"取消分享"];
                      
                  }
                      break;
                  default:
                      break;
              }
              
          }];
}
/**
 qq分享
 */
- (void)ruShareTencent{
    
    //本地保存用户 手机号 数据
    NSString *sharePhone =   [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    NSString *tempPhone =  [NSString stringWithFormat:@"a%@",sharePhone];
    NSString *tempStr = @"http://101.201.117.15/wap/index.php?ctl=qd_user&act=Register&invite_code=";
    NSString *inviteUrl = [NSString stringWithFormat:@"%@%@",tempStr,tempPhone];

    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:SHATETEXT
                                     images:[UIImage imageNamed:@"LOGO"]
                                        url:[NSURL URLWithString:inviteUrl]
                                      title:SHATETITLE
                                       type:SSDKContentTypeWebPage
     ];
    //开始进行分享
    [ShareSDK showShareEditor:SSDKPlatformTypeQQ
           otherPlatformTypes:nil
                  shareParams:shareParams
          onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end){
//              NSLog(@"(unsigned long)state==%lu",(unsigned long)state);
              switch (state) {
                  case SSDKResponseStateSuccess:{
                      [self ruShareStataView:@"分享成功"];
                      
                  }
                      break;
                  case SSDKResponseStateFail:{
                      [self ruShareStataView:@"分享失败"];
                      
                  }
                      break;
                  case SSDKResponseStateCancel:{
//                      [self shareStataView:@"取消分享"];
                      
                  }
                      break;
                  default:
                      break;
              }
              
          }];
    
}
/**
 通讯录分享
 */
- (void)ruShareMailList{

    //让用户给权限,没有的话会被拒的各位
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"没有授权, 需要去设置中心设置授权");
            }else{
                NSLog(@"用户已授权限");
                CNContactPickerViewController * picker = [CNContactPickerViewController new];
                picker.delegate = self;
                // 加载手机号
                picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
                [self presentViewController: picker  animated:YES completion:nil];
            }
        }];
    }
    if (status == CNAuthorizationStatusAuthorized) {
        
        //有权限时
        CNContactPickerViewController * picker = [CNContactPickerViewController new];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController: picker  animated:YES completion:nil];
    }
    else{
        NSLog(@"您未开启通讯录权限,请前往设置中心开启");
    }
    
}
#pragma ************ 通讯录代理方法********************************

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    CNContact *contact = contactProperty.contact;
    
    //    NSLog(@"%@",contactProperty);
    //    NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
    
    if (![contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        NSLog(@"提示用户选择11位的手机号");
        return;
    }
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString * Str = phoneNumber.stringValue;
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *phoneStr = [[Str componentsSeparatedByCharactersInSet:setToRemove]componentsJoinedByString:@""];
    if (phoneStr.length != 11) {
        
        NSLog(@"提示用户选择11位的手机号");
    }
//    NSString * textName = [NSString stringWithFormat:@"姓名:%@-电话:%@",contact.familyName,phoneStr];
    NSString * requestPhone = [NSString stringWithFormat:@"%@",phoneStr];
    
    NSString * authSession = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSDictionary *mrDic =@{@"phone":requestPhone,
                           @"auth_session":authSession,
                           @"type":@"agency"
                           
                           };
    NSLog(@"mrDic == %@",mrDic);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:REQUESTESMS_URL parameters:mrDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self rqShowAlert:@"短信已发送"];
        }else{
            
            [self rqShowAlert:responseObject[@"info"]];
            
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
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
