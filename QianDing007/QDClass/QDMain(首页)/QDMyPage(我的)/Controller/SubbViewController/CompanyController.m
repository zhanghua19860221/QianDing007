//
//  CompanyController.m
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CompanyController.h"
#import "LSCityChooseView.h"
@interface CompanyController (){
    UITextField *cp_selectField;    //记录当前编辑的输入框
    CGFloat   cp_keyBoardHeight;    //记录键盘高度
    CGFloat   cp_keyBoardDuration;  //记录键盘弹出需要的时间
    CGFloat   cp_scrollViewOldoffSet;//记录scrollView旧的偏移量
    UIButton  *cp_selectBtnImage;    //记录当前点击的是那个照片button
    
    UITextField *com_companyNameField;  //企业名称
    UITextField *com_creditField;       //信用代码
    UITextField *com_detailAddressField;//详细地址
    UITextField *com_userNameField;     //姓名
    UITextField *com_cardedField;       //身份证号
    UITextField *com_telePhoneField;    //联系电话
    UITextField *com_accountField;      //收款账户
    UITextField *com_payeeField;        //收款人
    UITextField *com_bankField;         //开户行名称
    UITextField *com_branceTeleField;   //银行预留手机号
    UILabel *com_panyAddressLabel;      //公司地址
    UIScrollView *com_scrollView;       //展示视图
    UIButton *com_submitBtn;            //提交数据按钮

    UIImageView *com_potoImageView;     //身份证正面视图
    UIImageView *com_potoImageViewOne;  //身份证反面视图
    UIImageView *com_handPotoImageView; //手持身份证正面视图
    UIImageView *com_licenseImageView;  //营业执照视图
    UIImageView *com_doorFhotoImageView;//门头照视图
    UIImageView *com_placeImageView;    //经营场所视图
    UIImageView *com_cashierImageView;  //收银台视图
    
    UIImage *com_potoImage;        //身份证正面
    UIImage *com_potoImageOne;     //身份证反面
    UIImage *com_handImage;        //手持身份证正面
    UIImage *com_licenseImage;     //营业执照
    UIImage *com_doorFhotoImage;   //门头照
    UIImage *com_placeImage;       //经营场所
    UIImage *com_cashierImage;     //收银台
    
    NSString *com_province; //省
    NSString *com_city;     //市
    NSString *com_area;     //区域
 
}

@end

@implementation CompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self cmGetDataSource];
    [self createScrollerView];
    [self createOneView];
//     Do any additional setup after loading the view.
}
//防止重复点击
- (void)changeButtonStatus{
    com_submitBtn.enabled = YES;
    
}
- (void)ccSubmitBtnBlick{
    
    //防止重复点击
    com_submitBtn.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击

    if ([com_companyNameField.text isEqualToString:@""]||[shareDelegate isAllCharacterString:com_companyNameField.text]) {
        
        [self cpShowAlert:@"企业名称不可为空，并且不可全为特殊符号。"];
        return;
    }
    if ([com_creditField.text isEqualToString:@""]) {
        [self cpShowAlert:@"统一社会信用代码不可为空。"];
        
        return;
    }
    if (com_panyAddressLabel.text == NULL) {
        [self cpShowAlert:@"企业地址不可为空。"];
        return;
    }

    if ([com_detailAddressField.text isEqualToString:@""]) {
        
        [self cpShowAlert:@"详细地址不可为空。"];
        return;
    }

    if ([com_userNameField.text isEqualToString:@""]||![shareDelegate deptNameInputShouldChinese:com_userNameField.text]||![shareDelegate isStringLengthName:com_userNameField.text]) {
        
        [self cpShowAlert:@"请输不可为空的、11个字以内的纯中文姓名。"];
        return;
        
    }
  if ([com_cardedField.text isEqualToString:@""]||![shareDelegate isLenghtCard:com_cardedField.text]) {
        
        [self cpShowAlert:@"请输入15到18位，正确的身份证号码。"];
        return;
        
    }
    
    if ([com_telePhoneField.text isEqualToString:@""]||![shareDelegate isChinaMobile:com_telePhoneField.text]) {
        
        [self cpShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }
    
    if (com_potoImage == NULL||com_potoImageOne == NULL||com_handImage == NULL||com_licenseImage == NULL||com_doorFhotoImage == NULL||com_placeImage == NULL||com_cashierImage == NULL){
        
        [self cpShowAlert:@"图片不可为空。"];
        return;
    }
    
    if ([com_accountField.text isEqualToString:@""]||![shareDelegate checkCardNo:com_accountField.text]) {
        
        [self cpShowAlert:@"请输入正确的收款账户。"];
        return;
        
    }
    if ([com_payeeField.text isEqualToString:@""]||![shareDelegate deptNameInputShouldChinese:com_payeeField.text]||![shareDelegate isStringLengthName:com_payeeField.text]) {
        
        [self cpShowAlert:@"请输不可为空的、11个字以内的纯中文收款人名称。"];
        return;
        
    }
    if ([com_bankField.text isEqualToString:@""]) {
        
        [self cpShowAlert:@"开户行不可为空。"];
        return;
        
    }

    if ([com_branceTeleField.text isEqualToString:@""]||![shareDelegate isChinaMobile:com_branceTeleField.text]) {
        
        [self cpShowAlert:@"请输入正确的银行预留手机号。"];
        return;
        
    }
    
    
    //创建请求菊花进度条
    [[UIApplication sharedApplication].keyWindow addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.width.mas_equalTo(100);
    }];
    
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];

    NSDictionary *companyDic =@{@"auth_session":oldSession,
                             @"name":com_companyNameField.text,
                             @"biz_license":com_creditField.text,
                             @"province_id":com_province,
                             @"city_id":com_city,
                             @"area_id":com_area,
                             @"h_faren":com_userNameField.text,
                             @"h_tel":com_telePhoneField.text,
                             @"idcard_number":com_cardedField.text,
                             @"bank_user":com_payeeField.text,
                             @"bank_name":com_bankField.text,
                             @"bank_info":com_accountField.text,
                             @"account_mobile":com_branceTeleField.text,
                             @"address":com_detailAddressField.text,
                             @"idcard_img_one":@"身份证正面.png",
                             @"idcard_img_two":@"身份证反面.png",
                             @"idcard_img_three":@"法人手持身份证.png",
                             @"h_license":@"营业执照.png",
                             @"shop_img_one":@"门头照.png",
                             @"shop_img_two":@"经营场所.png",
                             @"shop_img_three":@"收银台.png",
                             @"account_type":@"2"
                             };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];

    [manager POST:SAVEINFOUSER_URL parameters:companyDic constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

        NSArray *potoNameArray = @[@"身份证正面.png",@"身份证反面.png",@"法人手持身份证.png",@"营业执照.png",@"门头照.png",@"经营场所.png",@"收银台.png"];
        NSArray *array = @[@"idcard_img_one",@"idcard_img_two",@"idcard_img_three",@"h_license",@"shop_img_one",@"shop_img_two",@"shop_img_three"];
        NSArray *arrayImage = @[com_potoImage,com_potoImageOne,com_handImage,com_licenseImage,com_doorFhotoImage,com_placeImage,com_cashierImage];
        
        for (int i = 0; i < arrayImage.count; i ++) {
            NSString *parameterName = array[i];
          UIImage *image = arrayImage[i];
          NSData *imageData =UIImageJPEGRepresentation(image,1.0);
            [formData appendPartWithFileData:imageData
                                        name:parameterName
                                    fileName:potoNameArray[i]
                                    mimeType:@"image/png"];
            
        }
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        //上传成功
      NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            //上传成功后禁止scrollview滚动
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScrollEnabled" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
            [self cpShowAlert:@"上传成功"];

        }else{
            [self cpShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
    }];
    
}
/**
 获取网络企业信息数据
 */
- (void)cmGetDataSource{
    
//    //创建请求菊花进度条
    [[UIApplication sharedApplication].keyWindow addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.width.mas_equalTo(100);
    }];

    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *levelDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:GETINFOUSER_URL parameters:levelDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if ([responseObject[@"account_type"] isEqualToString:@"2"]) {
                [self fillDataToSubView:responseObject];
                
                NSString *temp_Account = responseObject[@"account_type"];
                [[shareDelegate shareNSUserDefaults] setObject:temp_Account forKey:@"account_type"];
            }
        }else{
                [self cpShowAlert:responseObject[@"info"]];
            
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
- (void)fillDataToSubView:(NSDictionary *)comPanyDic{
    com_companyNameField.text= comPanyDic[@"name"];
    com_creditField.text = comPanyDic[@"biz_license"];
    com_detailAddressField.text = comPanyDic[@"address"];
    com_userNameField.text = comPanyDic[@"h_faren"];
    com_cardedField.text = comPanyDic[@"idcard_number"];
    com_telePhoneField.text = comPanyDic[@"h_tel"];
    com_accountField.text = comPanyDic[@"bank_info"];
    com_payeeField.text = comPanyDic[@"bank_user"];
    com_bankField.text = comPanyDic[@"bank_name"];
    com_branceTeleField.text = comPanyDic[@"account_mobile"];

    com_province = comPanyDic[@"province_id"];
    com_city = comPanyDic[@"city_id"];
    com_area = comPanyDic[@"area_id"];
    NSString *companyAddress = [NSString stringWithFormat:@"%@%@%@",com_province,com_city,com_area,nil];
    com_panyAddressLabel.text = companyAddress;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //身份证正面
        if (![comPanyDic[@"idcard_img_one"] isEqualToString:@""]) {
            [com_potoImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"idcard_img_one"]]];


            com_potoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"idcard_img_one"]]]];
        }
        
        
        //身份证反面
        if (![comPanyDic[@"idcard_img_two"] isEqualToString:@""]) {
            [com_potoImageViewOne sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"idcard_img_two"]]];
            com_potoImageOne = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"idcard_img_two"]]]];
        }
        
        //法人手持身份证
        if (![comPanyDic[@"idcard_img_three"] isEqualToString:@""]) {
            [com_handPotoImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"idcard_img_three"]]];
            com_handImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"idcard_img_three"]]]];
        }
        //营业执照
        if (![comPanyDic[@"h_license"] isEqualToString:@""]) {
            [com_licenseImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"h_license"]] ];
            com_licenseImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"h_license"]]]];
        }
        //门头照
        if (![comPanyDic[@"shop_img_one"] isEqualToString:@""]) {
            [com_doorFhotoImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"shop_img_one"]]];
            com_doorFhotoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"shop_img_one"]]]];
        }
        
        //经营场所
        if (![comPanyDic[@"shop_img_two"] isEqualToString:@""]) {
            [com_placeImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"shop_img_two"]]];
            com_placeImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"shop_img_two"]]]];
            
        }
        //收银台
        if (![comPanyDic[@"shop_img_three"] isEqualToString:@""]) {
            [com_cashierImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"shop_img_three"]] ];
            com_cashierImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"shop_img_three"]]]];
            
        }

    });
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    com_scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:com_scrollView];
    com_scrollView.alwaysBounceVertical  = YES ;
    com_scrollView.contentSize = CGSizeMake(0, 1520/SCALE_Y);
    [com_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
}
- (void)createOneView{

    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(com_scrollView.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *companyNameLabel = [[UILabel alloc] init];
    companyNameLabel.font = [UIFont systemFontOfSize:14];
    companyNameLabel.textAlignment = NSTextAlignmentLeft;
    companyNameLabel.text = @"企业名称：";
    [companyNameLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:companyNameLabel];
    [companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    com_companyNameField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_companyNameField];
    com_companyNameField.delegate = self;
    //取消输入框首字母默认大写功能
    [com_companyNameField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [com_companyNameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    com_companyNameField.textAlignment = NSTextAlignmentLeft;
    com_companyNameField.font = [UIFont systemFontOfSize:14];
    [com_companyNameField setTextColor:COLORFromRGB(0x333333)];
    com_companyNameField.placeholder = @"名称";
    [com_companyNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line.mas_centerY).offset(-25);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *creditLabel = [[UILabel alloc] init];
    creditLabel.font = [UIFont systemFontOfSize:14];
    creditLabel.textAlignment = NSTextAlignmentLeft;
    creditLabel.text = @"信用代码：";
    [creditLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:creditLabel];
    [creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        
    }];
    UILabel *creditLabelOne = [[UILabel alloc] init];
    creditLabelOne.font = [UIFont systemFontOfSize:14];
    creditLabelOne.textAlignment = NSTextAlignmentLeft;
    creditLabelOne.text = @"统一社会";
    [creditLabelOne setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:creditLabelOne];
    [creditLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(creditLabel.mas_top);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
        
    }];
    com_creditField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_creditField];
    com_creditField.delegate = self;
    com_creditField.textAlignment = NSTextAlignmentLeft;
    com_creditField.font = [UIFont systemFontOfSize:14];
    [com_creditField setTextColor:COLORFromRGB(0x333333)];
    com_creditField.placeholder = @"信用";
    [com_creditField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineOne.mas_centerY).offset(-25);
        make.left.right.equalTo(lineOne);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = @"企业地址：";
    [addressLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTwo.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    UIButton *selectorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectorBtn  setTitle:@"+" forState:UIControlStateNormal];
    [selectorBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    selectorBtn.backgroundColor = COLORFromRGB(0Xe10000);
    selectorBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [com_scrollView addSubview:selectorBtn];
    [selectorBtn addTarget:self action:@selector(selectorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTwo.mas_centerY).offset(-25);
        make.left.equalTo(addressLabel.mas_right).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    com_panyAddressLabel = [[UILabel alloc] init];
    com_panyAddressLabel.font = [UIFont systemFontOfSize:14];
    com_panyAddressLabel.textAlignment = NSTextAlignmentLeft;
    [com_panyAddressLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:com_panyAddressLabel];
    [com_panyAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTwo.mas_centerY).offset(-25);
        make.left.equalTo(selectorBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SC_WIDTH-140);
        
    }];
    

    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *detailAddressLabel = [[UILabel alloc] init];
    detailAddressLabel.font = [UIFont systemFontOfSize:14];
    detailAddressLabel.textAlignment = NSTextAlignmentLeft;
    detailAddressLabel.text = @"详细地址：";
    [detailAddressLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:detailAddressLabel];
    [detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineThird.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_detailAddressField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_detailAddressField];
    com_detailAddressField.delegate = self;
    com_detailAddressField.textAlignment = NSTextAlignmentLeft;
    com_detailAddressField.font = [UIFont systemFontOfSize:14];
    [com_detailAddressField setTextColor:COLORFromRGB(0x333333)];
    com_detailAddressField.placeholder = @"详细地址";
    [com_detailAddressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineThird.mas_centerY).offset(-25);
        make.left.right.equalTo(lineThird);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.text = @"姓        名：";
    [userNameLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFour.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_userNameField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_userNameField];
    com_userNameField.delegate = self;
    com_userNameField.textAlignment = NSTextAlignmentLeft;
    com_userNameField.font = [UIFont systemFontOfSize:14];
    [com_userNameField setTextColor:COLORFromRGB(0x333333)];
    com_userNameField.placeholder = @"姓名";
    [com_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFour.mas_centerY).offset(-25);
        make.left.right.equalTo(lineThird);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineFive = [[UIImageView alloc] init];
    lineFive.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *cardedLabel = [[UILabel alloc] init];
    cardedLabel.font = [UIFont systemFontOfSize:14];
    cardedLabel.textAlignment = NSTextAlignmentLeft;
    cardedLabel.text = @"身份证号：";
    [cardedLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:cardedLabel];
    [cardedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFive.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_cardedField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_cardedField];
    com_cardedField.delegate = self;
    com_cardedField.textAlignment = NSTextAlignmentLeft;
    com_cardedField.font = [UIFont systemFontOfSize:14];
    [com_cardedField setTextColor:COLORFromRGB(0x333333)];
    com_cardedField.placeholder = @"身份证号";
    [com_cardedField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFive.mas_centerY).offset(-25);
        make.left.right.equalTo(lineFive);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIImageView *lineSix = [[UIImageView alloc] init];
    lineSix.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFive.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *telePhoneLabel = [[UILabel alloc] init];
    telePhoneLabel.font = [UIFont systemFontOfSize:14];
    telePhoneLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneLabel.text = @"联系电话：";
    [telePhoneLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:telePhoneLabel];
    [telePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSix.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_telePhoneField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_telePhoneField];
    com_telePhoneField.delegate = self;
    com_telePhoneField.textAlignment = NSTextAlignmentLeft;
    com_telePhoneField.font = [UIFont systemFontOfSize:14];
    [com_telePhoneField setTextColor:COLORFromRGB(0x333333)];
    com_telePhoneField.placeholder = @"联系电话";
    [com_telePhoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSix.mas_centerY).offset(-25);
        make.left.right.equalTo(lineSix);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *potoLabel = [[UILabel alloc] init];
    potoLabel.font = [UIFont systemFontOfSize:14];
    potoLabel.textAlignment = NSTextAlignmentLeft;
    potoLabel.text = @"上传法人身份证照片";
    [potoLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:potoLabel];
    [potoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSix.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        
    }];
    UIButton *potoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    potoBtn.tag = 100;
    potoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:potoBtn];
    [potoBtn addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    [potoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoLabel.mas_bottom).offset(10);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    com_potoImageView = [[UIImageView alloc] init];
    [com_potoImageView setImage:[UIImage imageNamed:@"身份证正面"]];
    com_potoImageView.backgroundColor = COLORFromRGB(0xffffff);
    com_potoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [potoBtn addSubview:com_potoImageView];
    [com_potoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(potoBtn);
        
    }];
    
    
    UIButton *potoBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    potoBtnOne.tag = 101;
    [potoBtnOne addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    potoBtnOne.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:potoBtnOne];
    [potoBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(potoBtn.mas_centerY);
        make.left.equalTo(potoBtn.mas_right).offset(15);
        make.width.height.equalTo(potoBtn);
        
    }];
    
    
    com_potoImageViewOne = [[UIImageView alloc] init];
    [com_potoImageViewOne setImage:[UIImage imageNamed:@"身份证背面"]];
    com_potoImageViewOne.backgroundColor = COLORFromRGB(0xffffff);
    com_potoImageViewOne.contentMode = UIViewContentModeScaleAspectFit;
    [potoBtnOne addSubview:com_potoImageViewOne];
    [com_potoImageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(potoBtnOne);
        
    }];

    UILabel *handPotoLabel = [[UILabel alloc] init];
    handPotoLabel.font = [UIFont systemFontOfSize:14];
    handPotoLabel.textAlignment = NSTextAlignmentLeft;
    handPotoLabel.text = @"法人手持身份证照片(请参考示例)";
    [handPotoLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:handPotoLabel];
    [handPotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-100));
        make.height.mas_equalTo(16);
        
    }];
    
    UIButton *handPotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    handPotoBtn.tag = 102;
    handPotoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [handPotoBtn addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    [com_scrollView addSubview:handPotoBtn];
    [handPotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handPotoLabel.mas_bottom).offset(10);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    com_handPotoImageView = [[UIImageView alloc] init];
    [com_handPotoImageView setImage:[UIImage imageNamed:@"手持身份证"]];
    com_handPotoImageView.backgroundColor = COLORFromRGB(0xffffff);
    com_handPotoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [handPotoBtn addSubview:com_handPotoImageView];
    [com_handPotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(handPotoBtn);
    }];
    
    
    UIImageView *handPotoView = [[UIImageView alloc] init];
    [handPotoView setImage:[UIImage imageNamed:@"示例"]];
    handPotoView.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:handPotoView];
    [handPotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(handPotoBtn.mas_centerY);
        make.left.equalTo(handPotoBtn.mas_right).offset(15);
        make.width.height.equalTo(handPotoBtn);
        
    }];

    UILabel *licenseLabel = [[UILabel alloc] init];
    licenseLabel.font = [UIFont systemFontOfSize:14];
    licenseLabel.textAlignment = NSTextAlignmentLeft;
    licenseLabel.text = @"营业执照(必填)";
    [licenseLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:licenseLabel];
    [licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handPotoBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *doorFhotoLabel = [[UILabel alloc] init];
    doorFhotoLabel.font = [UIFont systemFontOfSize:14];
    doorFhotoLabel.textAlignment = NSTextAlignmentLeft;
    doorFhotoLabel.text = @"门头照图片(必填)";
    [doorFhotoLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:doorFhotoLabel];
    [doorFhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(licenseLabel.mas_centerY);
        make.left.equalTo(licenseLabel.mas_right).offset(15);
        make.width.height.equalTo(licenseLabel);
        
    }];
    
    UIButton *licenseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [licenseBtn setImage:[UIImage imageNamed:@"营业执照"] forState:UIControlStateNormal];
    licenseBtn.tag = 103;
    
    [licenseBtn addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    licenseBtn.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:licenseBtn];
    [licenseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(licenseLabel.mas_bottom).offset(10);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    com_licenseImageView = [[UIImageView alloc] init];
    [com_licenseImageView setImage:[UIImage imageNamed:@"营业执照"]];
    com_licenseImageView.backgroundColor = COLORFromRGB(0xffffff);
    com_licenseImageView.contentMode = UIViewContentModeScaleAspectFit;
    [licenseBtn addSubview:com_licenseImageView];
    [com_licenseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(licenseBtn);
    }];
    
    
    UIButton *doorFhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doorFhotoBtn setImage:[UIImage imageNamed:@"门头照"] forState:UIControlStateNormal];
    doorFhotoBtn.tag = 104;
    [doorFhotoBtn addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    doorFhotoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:doorFhotoBtn];
    [doorFhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(licenseBtn.mas_centerY);
        make.left.equalTo(licenseBtn.mas_right).offset(15);
        make.width.height.equalTo(licenseBtn);
        
    }];
    
    com_doorFhotoImageView = [[UIImageView alloc] init];
    [com_doorFhotoImageView setImage:[UIImage imageNamed:@"门头照"]];
    com_doorFhotoImageView.backgroundColor = COLORFromRGB(0xffffff);
    com_doorFhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [doorFhotoBtn addSubview:com_doorFhotoImageView];
    [com_doorFhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(doorFhotoBtn);
    }];
    
    
    UILabel *placeLabel = [[UILabel alloc] init];
    placeLabel.font = [UIFont systemFontOfSize:14];
    placeLabel.textAlignment = NSTextAlignmentLeft;
    placeLabel.text = @"经营场所(必填)";
    [placeLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:placeLabel];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(licenseBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(16);
        
    }];
    
    
    UILabel *cashierLabel = [[UILabel alloc] init];
    cashierLabel.font = [UIFont systemFontOfSize:14];
    cashierLabel.textAlignment = NSTextAlignmentLeft;
    cashierLabel.text = @"收银台(必填)";
    [cashierLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:cashierLabel];
    [cashierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeLabel.mas_centerY);
        make.left.equalTo(placeLabel.mas_right).offset(15);
        make.width.height.equalTo(placeLabel);
        
    }];
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setImage:[UIImage imageNamed:@"经营场所"] forState:UIControlStateNormal];
    placeBtn.tag = 105;
    [placeBtn addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    placeBtn.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:placeBtn];
    [placeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeLabel.mas_bottom).offset(10);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    com_placeImageView = [[UIImageView alloc] init];
    [com_placeImageView setImage:[UIImage imageNamed:@"经营场所"]];
    com_placeImageView.backgroundColor = COLORFromRGB(0xffffff);
    com_placeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [placeBtn addSubview:com_placeImageView];
    [com_placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(placeBtn);
    }];
    
    
    UIButton *cashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cashierBtn setImage:[UIImage imageNamed:@"收银台"] forState:UIControlStateNormal];
    cashierBtn.tag = 106;
    [cashierBtn addTarget:self action:@selector(cpButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    cashierBtn.backgroundColor = COLORFromRGB(0xffffff);
    [com_scrollView addSubview:cashierBtn];
    [cashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeBtn.mas_centerY);
        make.left.equalTo(placeBtn.mas_right).offset(15);
        make.width.height.equalTo(placeBtn);
        
    }];
    
    com_cashierImageView = [[UIImageView alloc] init];
    [com_cashierImageView setImage:[UIImage imageNamed:@"收银台"]];
    com_cashierImageView.backgroundColor = COLORFromRGB(0xffffff);
    com_cashierImageView.contentMode = UIViewContentModeScaleAspectFit;
    [cashierBtn addSubview:com_cashierImageView];
    [com_cashierImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cashierBtn);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = COLORFromRGB(0xffffff);
    [imageView setImage:[UIImage imageNamed:@"组4"]];
    [com_scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(com_scrollView);
        make.width.mas_equalTo(187);
        make.height.mas_equalTo(30);
        
    }];
    
    UIImageView *lineSeven = [[UIImageView alloc] init];
    lineSeven.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineSeven];
    [lineSeven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.font = [UIFont systemFontOfSize:14];
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.text = @"收款账户：";
    [accountLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSeven.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_accountField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_accountField];
    com_accountField.delegate = self;
    com_accountField.textAlignment = NSTextAlignmentLeft;
    com_accountField.font = [UIFont systemFontOfSize:14];
    [com_accountField setTextColor:COLORFromRGB(0x333333)];
    com_accountField.placeholder = @"账户";
    [com_accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSeven.mas_centerY).offset(-25);
        make.left.right.equalTo(lineSeven);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineEight = [[UIImageView alloc] init];
    lineEight.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineEight];
    [lineEight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSeven.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *payeeLabel = [[UILabel alloc] init];
    payeeLabel.font = [UIFont systemFontOfSize:14];
    payeeLabel.textAlignment = NSTextAlignmentLeft;
    payeeLabel.text = @"收款人：";
    [payeeLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:payeeLabel];
    [payeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineEight.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_payeeField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_payeeField];
    com_payeeField.delegate = self;
    com_payeeField.textAlignment = NSTextAlignmentLeft;
    com_payeeField.font = [UIFont systemFontOfSize:14];
    [com_payeeField setTextColor:COLORFromRGB(0x333333)];
    com_payeeField.placeholder = @"收款人";
    [com_payeeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineEight.mas_centerY).offset(-25);
        make.left.right.equalTo(lineEight);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineNine = [[UIImageView alloc] init];
    lineNine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineNine];
    [lineNine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineEight.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *bankLabel = [[UILabel alloc] init];
    bankLabel.font = [UIFont systemFontOfSize:14];
    bankLabel.textAlignment = NSTextAlignmentLeft;
    bankLabel.text = @"开户行：";
    [bankLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:bankLabel];
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineNine.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_bankField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_bankField];
    com_bankField.delegate = self;
    com_bankField.textAlignment = NSTextAlignmentLeft;
    com_bankField.font = [UIFont systemFontOfSize:14];
    [com_bankField setTextColor:COLORFromRGB(0x333333)];
    com_bankField.placeholder = @"开户行";
    [com_bankField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineNine.mas_centerY).offset(-25);
        make.left.right.equalTo(lineNine);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineTen = [[UIImageView alloc] init];
    lineTen.backgroundColor = COLORFromRGB(0xf9f9f9);
    [com_scrollView addSubview:lineTen];
    [lineTen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineNine.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *branceTeleLabel = [[UILabel alloc] init];
    branceTeleLabel.font = [UIFont systemFontOfSize:14];
    branceTeleLabel.textAlignment = NSTextAlignmentLeft;
    branceTeleLabel.text = @"预留手机：";
    [branceTeleLabel setTextColor:COLORFromRGB(0x333333)];
    [com_scrollView addSubview:branceTeleLabel];
    [branceTeleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTen.mas_centerY).offset(-25);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    com_branceTeleField = [[UITextField alloc] init];
    [com_scrollView addSubview:com_branceTeleField];
    com_branceTeleField.delegate = self;
    com_branceTeleField.textAlignment = NSTextAlignmentLeft;
    com_branceTeleField.font = [UIFont systemFontOfSize:14];
    [com_branceTeleField setTextColor:COLORFromRGB(0x333333)];
    com_branceTeleField.placeholder = @"银行预留手机号";
    [com_branceTeleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTen.mas_centerY).offset(-25);
        make.left.right.equalTo(lineTen);
        make.height.mas_equalTo(40);
    }];
    
    com_submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [com_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    com_submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [com_submitBtn.titleLabel setTextColor:COLORFromRGB(0xffffff)];
    com_submitBtn.backgroundColor = COLORFromRGB(0xe10000);
    com_submitBtn.layer.masksToBounds = YES;
    com_submitBtn.layer.cornerRadius = 5;
    [com_scrollView addSubview:com_submitBtn];
    [com_submitBtn addTarget:self action:@selector(ccSubmitBtnBlick) forControlEvents:UIControlEventTouchUpInside];
    [com_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTen.mas_bottom).offset(60/SCALE_Y);
        make.left.equalTo(com_scrollView).offset(15);
        make.width.mas_equalTo(SC_WIDTH-30);
        make.height.mas_equalTo(50/SCALE_Y);

    }];
    
}
/**
 城市选择按钮点击事件
 */
- (void)selectorBtnClick{
    
    [self.view endEditing:YES];

    
    LSCityChooseView * view = [[LSCityChooseView alloc] initWithFrame:CGRectMake(0, -124, SC_WIDTH, SC_HEIGHT)];
    view.selectedBlock = ^(NSString * province, NSString * city, NSString * area){
        com_panyAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
        com_province = province;
        com_city = city;
        com_area = area;

    };
    [self.view addSubview:view];

}

/**
 相册列表操作按钮点击事件
 */
-(void)cpButPhotoListClick:(UIButton*)btn{
    cp_selectBtnImage = btn;
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    // 初始化图片选择控制器
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    /*设置媒体来源，即调用出来的UIImagePickerController所显示出来的界面，有一下三种来源
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) { UIImagePickerControllerSourceTypePhotoLibrary, UIImagePickerControllerSourceTypeCamera, UIImagePickerControllerSourceTypeSavedPhotosAlbum };分别表示：图片列表，摄像头，相机相册*/
    [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 设置所支持的媒体功能，即只能拍照，或则只能录像，或者两者都可以
    NSString *requiredMediaType = ( NSString *)kUTTypeImage;
    NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType,nil];
    [controller setMediaTypes:arrMediaTypes];
    
    // 设置是否可以管理已经存在的图片或者视频
    [controller setAllowsEditing:YES];
    // 设置代理
    [controller setDelegate:self];
    [self presentViewController:controller animated:YES completion:nil];
}
/**
 扫描相册二维码获取数据结果
 
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        switch (cp_selectBtnImage.tag) {
            case 100:{
                com_potoImage = image;
                [com_potoImageView setImage:image];
            }
                break;
            case 101:{
                com_potoImageOne = image;
                [com_potoImageViewOne setImage:image];

            }
                break;
            case 102:{
                com_handImage = image;
                [com_handPotoImageView setImage:image];

            }
                break;
            case 103:{
                com_licenseImage = image;
                [com_licenseImageView setImage:image];

            }
                break;
            case 104:{
                com_doorFhotoImage = image;
                [com_doorFhotoImageView setImage:image];

            }
                break;
            case 105:{
                com_placeImage = image;
                [com_placeImageView setImage:image];

            }
                break;
            case 106:{
                com_cashierImage = image;
                [com_cashierImageView setImage:image];

            }
                break;
            default:
                break;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)keyBoardshow:(NSNotification*)notification{
    
    NSDictionary * info = [notification userInfo];
    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
    //键盘的高度
    cp_keyBoardHeight = keyboardRect.size.height;
    //键盘调起的时间长度
    cp_keyBoardDuration = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    cp_scrollViewOldoffSet = com_scrollView.contentOffset.y;
    if ( (cp_selectField.frame.origin.y + cp_keyBoardHeight + 150) >= ([[UIScreen mainScreen] bounds].size.height-114 + cp_scrollViewOldoffSet)){
        //此时，编辑框被键盘盖住，则对视图做相应的位移
        CGFloat offSetY = cp_selectField.frame.origin.y + 150 + cp_keyBoardHeight - [[UIScreen mainScreen] bounds].size.height + 114;//偏移量=编辑框原点Y值+键盘高度+编辑框高度-屏幕高度
        [UIView animateWithDuration:cp_keyBoardDuration animations:^{
            [com_scrollView setContentOffset:CGPointMake(0, offSetY) animated:YES];
            
        }];
    }
    
}
- (void)keyBoardhide:(NSNotification*)notification{
    [UIView animateWithDuration:cp_keyBoardDuration animations:^{
        [com_scrollView setContentOffset:CGPointMake(0,cp_scrollViewOldoffSet) animated:YES];
    }];
    
    
}
#pragma ********************UITextFieldDelegate**************
/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    cp_selectField = textField;
    //scrollview便宜量
    cp_scrollViewOldoffSet = com_scrollView.contentOffset.y;
    if ( (textField.frame.origin.y + cp_keyBoardHeight + 150) >= ([[UIScreen mainScreen] bounds].size.height-114 + cp_scrollViewOldoffSet)){
        //此时，编辑框被键盘盖住，则对视图做相应的位移
        CGFloat offSetY = textField.frame.origin.y + 150 + cp_keyBoardHeight - [[UIScreen mainScreen] bounds].size.height + 114;//偏移量=编辑框原点Y值+键盘高度+编辑框高度-屏幕高度
        [UIView animateWithDuration:cp_keyBoardDuration animations:^{
            [com_scrollView setContentOffset:CGPointMake(0, offSetY) animated:YES];
            
        }];
        
    }
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
    
    [UIView animateWithDuration:cp_keyBoardDuration animations:^{
        [com_scrollView setContentOffset:CGPointMake(0,cp_scrollViewOldoffSet) animated:YES];
    }];
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

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidHideNotification    object:nil];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];

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
