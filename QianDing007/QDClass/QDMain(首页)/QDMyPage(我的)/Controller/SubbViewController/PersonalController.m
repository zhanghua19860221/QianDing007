//
//  PersonalController.m
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "PersonalController.h"
#import "LSCityChooseView.h"
#import "QDPickerModel.h"

@interface PersonalController (){
    UITextField *ps_selectField;     //记录当前编辑的输入框
    CGFloat   ps_keyBoardHeight;     //记录键盘高度
    CGFloat   ps_keyBoardDuration;   //记录键盘弹出需要的时间
    CGFloat   ps_scrollViewOldoffSet;//记录scrollView旧的偏移量
    UIButton  *ps_selectBtnImage;    //记录当前点击的是那个照片button

    UITextField *ps_businessField;     //商家名称
    UITextField *ps_detailAddressField;//详细地址
    UITextField *ps_userNameField;     //姓名
    UITextField *ps_cardedField;       //身份证号
    UITextField *ps_telePhoneField;    //联系电话
    UITextField *ps_accountField;      //收款账户
    UITextField *ps_payeeField;        //收款人
    UILabel     *ps_bankLabel;         //开户行
    UITextField *ps_branceTelField;    //银行预留手机号
    UILabel *ps_businessAddressLabel;  //营业地址
    UIScrollView *ps_scrollView;       //展示视图
    UIButton    *ps_submitBtn;         //提交数据按钮
    
    
    UIImageView *ps_photoImageView;     //身份证正面视图
    UIImageView *ps_photoImageViewOne;  //身份证反面视图
    UIImageView *ps_handPhotoImageView; //手持身份证正面视图
    UIImageView *ps_doorPhotoImageView; //门头照视图
    UIImageView *ps_placeImageView;     //经营场所视图
    UIImageView *ps_cashierImageView;   //收银台视图
    UIImageView *ps_leaseImageView;     //租赁合同一视图
    UIImageView *ps_leaseImageViewOne;  //租赁合同二视图

    
    UIImage *ps_photoImage;     //身份证正面照片
    UIImage *ps_photoImageOne;  //身份证反面照片
    UIImage *ps_handPhotoImage; //手持身份证照片
    UIImage *ps_doorPhotoImage; //门头照照片
    UIImage *ps_placeImage;     //经营场所照片
    UIImage *ps_cashierImage;   //收银台照片
    UIImage *ps_leaseImage;     //租赁合同一照片
    UIImage *ps_leaseImageOne;  //租赁合同二照片

    NSString *ps_province; //省
    NSString *ps_city;     //市
    NSString *ps_area;     //区域
    
    UIView   *ps_maskView;   //蒙板视图
    UIView   *ps_bankView;   //银行选择器视图
    NSString *ps_currentBank;   //记录当前选择的银行
    
}
@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self psInitPickerDataSource];
    [self psGetDataSource];
    [self psCreateScrollerView];
    [self psCreateOneView];
    [self psCreateMaskView];
    [self psCreateBankView];

    // Do any additional setup after loading the view.
}/**
  创建蒙板视图
  */
-(void)psCreateMaskView{
    
    ps_maskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0,SC_WIDTH, SC_HEIGHT)];
    ps_maskView.hidden = YES;
    ps_maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    //    [[UIApplication sharedApplication].keyWindow addSubview:com_maskView];
    [self.view addSubview:ps_maskView];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mrTapAction:)];
    
    [ps_maskView addGestureRecognizer:tapGesturRecognizer];
    
}

/**
 
 蒙板点击事件
 */
-(void)mrTapAction:(id)tap{
    
    [ps_bankView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_maskView).offset(SC_HEIGHT-122);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [ps_maskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        ps_maskView.hidden = YES;
        
    }];
    //更新约束
    
}
/**
 创建银行选择器视图
 */
- (void)psCreateBankView{
    
    ps_bankView = [[UIView alloc] init];
    ps_bankView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_maskView addSubview:ps_bankView];
    [ps_bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_maskView).offset(SC_HEIGHT-122);
        make.left.equalTo(ps_maskView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(240);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = COLORFromRGB(0xe10000);
    [cancelBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 3;
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [ps_bankView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_bankView).offset(5);
        make.left.equalTo(ps_bankView).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    OKBtn.backgroundColor = COLORFromRGB(0xe10000);
    [OKBtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    [OKBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    OKBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    OKBtn.layer.masksToBounds = YES;
    OKBtn.layer.cornerRadius = 3;
    [ps_bankView addSubview:OKBtn];
    [OKBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_bankView).offset(5);
        make.right.equalTo(ps_bankView).offset(-15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    [ps_bankView addSubview:self.pickerView];
    
    
}
/**
 初始化选择器数据
 */
- (void)psInitPickerDataSource{
    NSDictionary *tempDic = @{@"status":@"1000",
                              @"desc": @"Normal Returned",
                              @"data": @[
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"浦发银行(暂不支持)",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/SPDB.png",
                                          @"numb": @"310290000013"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"工商银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/ICBC.png",
                                          @"numb": @"102100099996"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"农业银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/ABC.png",
                                          @"numb": @"103100000026"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"中国银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/BOC.png",
                                          @"numb": @"104100000004"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"建设银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CCB.png",
                                          @"numb": @"105100000017"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"交通银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/BCM.png",
                                          @"numb": @"301290000007"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"中信银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CITIC.png",
                                          @"numb": @"302100011000"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"招商银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CMB.png",
                                          @"numb": @"308584000013"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"光大银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CEB.png",
                                          @"numb": @"303100000006"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"华夏银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/HXBANK.png",
                                          @"numb": @"304100040000"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"民生银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CMBC.png",
                                          @"numb": @"305100000013"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"广发银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/BCM.png",
                                          @"numb": @"306581000003"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"兴业银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CIB.png",
                                          @"numb": @"309391000011"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"平安银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/PAB.png",
                                          @"numb": @"307584007998"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"恒丰银行(暂不支持)",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/HF.png",
                                          @"numb": @"315456000105"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"浙商银行(暂不支持)",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/ZHESHANG.png",
                                          @"numb": @"316331000018"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"渤海银行(暂不支持)",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/BH.png",
                                          @"numb": @"318110000014"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"邮储银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/PSBC.png",
                                          @"numb": @"403100000004"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"北京银行",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/BOB.png",
                                          @"numb": @"313100000013"
                                          },
                                      @{
                                          @"summ": @"单笔5万，日累计20万",
                                          @"name": @"上海银行(暂不支持)",
                                          @"logo": @"http://oo6o93zxg.bkt.clouddn.com//BankInfo/BCM.png",
                                          @"numb": @"325290000012"
                                          }
                                      ]
                              };
    NSArray *array = tempDic[@"data"];
    
    for (NSDictionary *dic in array) {
        QDPickerModel *model = [[QDPickerModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardhide:) name:UIKeyboardWillHideNotification object:nil];

}
/**
 获取网络数据 填充默认数据
 */
-(void)psGetDataSource{
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSDictionary *levelDic =@{@"auth_session":oldSession};
    
    //创建请求菊花进度条
    [[UIApplication sharedApplication].keyWindow addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.width.mas_equalTo(100);
    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:[shareDelegate stringBuilder:GETINFOUSER_URL] parameters:levelDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            //判断认证类型
            if ([responseObject[@"account_type"] isEqualToString:@"1"]) {
                [self fillDataToSubView:responseObject];
                
                NSString *temp_Account = responseObject[@"account_type"];
                [[shareDelegate shareNSUserDefaults] setObject:temp_Account forKey:@"account_type"];
            }
        }else{
            [self psShowAlert:responseObject[@"info"]];
            
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
//防止重复点击
- (void)changeButtonStatus{
    ps_submitBtn.enabled = YES;
    
}

/**
 点击提交按钮点击事件

 */
- (void)psSubmitBtnClick:(UIButton *)btn{
    
    ps_submitBtn.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    if ([ps_businessField.text isEqualToString:@""]||[shareDelegate isAllCharacterString:ps_businessField.text]) {
        
        [self psShowAlert:@"商家名称不可为空，并且不可全为特殊符号。"];
        return;
    }
    if (ps_businessField.text.length >(NSUInteger)19) {
        [self psShowAlert:@"商户名称不合法"];
        
    }
    if (ps_businessAddressLabel.text == NULL) {
        [self psShowAlert:@"经营地址不可为空。"];
        return;
    }

    if ([ps_detailAddressField.text isEqualToString:@""]) {
        
        [self psShowAlert:@"详细地址不可为空。"];
        return;
    }

    if ([ps_userNameField.text isEqualToString:@""]||![shareDelegate deptNameInputShouldChinese:ps_userNameField.text]||![shareDelegate isStringLengthName:ps_userNameField.text]) {
        
        [self psShowAlert:@"请输不可为空的、11个字以内的纯中文姓名。"];
        return;
        
    }

    
    if ([ps_cardedField.text isEqualToString:@""]||![shareDelegate isLenghtCard:ps_cardedField.text]) {
        
        [self psShowAlert:@"请输入15到18位，正确的身份证号码。"];
        return;
        
    }

    if ([ps_telePhoneField.text isEqualToString:@""]||![shareDelegate isChinaMobile:ps_telePhoneField.text]) {
        
        [self psShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }

    if (ps_photoImage == NULL||ps_photoImageOne == NULL||ps_handPhotoImage == NULL||ps_doorPhotoImage == NULL||ps_placeImage == NULL||ps_cashierImage == NULL||ps_leaseImage == NULL||ps_leaseImageOne == NULL){
        
        [self psShowAlert:@"图片不可为空。"];
        return;
    }

    if ([ps_accountField.text isEqualToString:@""]||![shareDelegate checkCardNo:ps_accountField.text]) {
        
        [self psShowAlert:@"请输入正确的收款账户。"];
        return;
        
    }

    if ([ps_payeeField.text isEqualToString:@""]||![shareDelegate deptNameInputShouldChinese:ps_payeeField.text]||![shareDelegate isStringLengthName:ps_payeeField.text]) {
        
        [self psShowAlert:@"请输不可为空的、11个字以内的纯中文收款人名称。"];
        return;
        
    }
    if ([ps_bankLabel.text isEqualToString:@""]) {
        
        [self psShowAlert:@"开户行不可为空。"];
        return;
        
    }

    if ([ps_branceTelField.text isEqualToString:@""]||![shareDelegate isChinaMobile:ps_branceTelField.text]) {
        
        [self psShowAlert:@"请输入正确的银行预留手机号。"];
        return;
        
    }
    
    
    
    
    
    //创建请求菊花进度条
    [[UIApplication sharedApplication].keyWindow addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.width.mas_equalTo(100);
    }];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *personalDic =@{@"auth_session":oldSession,
                                @"name":ps_businessField.text,
                                @"province_id":ps_province,
                                @"city_id":ps_city,
                                @"area_id":ps_area,
                                @"h_faren":ps_userNameField.text,
                                @"h_tel":ps_telePhoneField.text,
                                @"idcard_number":ps_cardedField.text,
                                @"bank_user":ps_payeeField.text,
                                @"bank_name":ps_bankLabel.text,
                                @"bank_info":ps_accountField.text,
                                @"account_mobile":ps_branceTelField.text,
                                @"address":ps_detailAddressField.text,
                                @"idcard_img_one":@"身份证正面.png",
                                @"idcard_img_two":@"身份证反面.png",
                                @"idcard_img_three":@"法人手持身份证.png",
                                @"shop_img_one":@"门头照.png",
                                @"shop_img_two":@"经营场所.png",
                                @"shop_img_three":@"收银台.png",
                                @"contract_img_one":@"租赁合同一.png",
                                @"contract_img_two":@"租赁合同二.png",
                                @"account_type":@"1"
                                 
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

    [manager POST:[shareDelegate stringBuilder:SAVEINFOUSER_URL] parameters:personalDic constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSArray *potoNameArray = @[@"身份证正面.png",@"身份证反面.png",@"法人手持身份证.png",@"门头照.png",@"经营场所.png",@"收银台.png",@"租赁合同一.png",@"租赁合同二.png"];
        NSArray *array = @[@"idcard_img_one",@"idcard_img_two",@"idcard_img_three",@"shop_img_one",@"shop_img_two",@"shop_img_three",@"contract_img_one",@"contract_img_two"];
        
        NSArray *arrayImage = @[ps_photoImage,ps_photoImageOne,ps_handPhotoImage,ps_doorPhotoImage,ps_placeImage,ps_cashierImage,ps_leaseImage,ps_leaseImageOne];
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
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            //上传成功后禁止scrollview滚动
            [[shareDelegate shareNSUserDefaults] setObject:responseObject[@"account_type"] forKey:@"account_type"];
            
//            NSLog(@"account_type == %@",responseObject[@"account_type"]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScrollEnabled" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
            [self psShowAlert:@"资料上传成功"];
        }else{
            [self psShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
    }];

}
/**
 网络请求完数据后 填充界面数据
 */
- (void)fillDataToSubView:(NSDictionary *)comPanyDic{
      ps_businessField.text= comPanyDic[@"name"];
      ps_detailAddressField.text = comPanyDic[@"address"];
      ps_userNameField.text = comPanyDic[@"h_faren"];
      ps_cardedField.text = comPanyDic[@"idcard_number"];
      ps_telePhoneField.text = comPanyDic[@"h_tel"];
      ps_accountField.text = comPanyDic[@"bank_info"];
      ps_payeeField.text = comPanyDic[@"bank_user"];
      ps_bankLabel.text = comPanyDic[@"bank_name"];
      ps_branceTelField.text = comPanyDic[@"account_mobile"];
      ps_province = comPanyDic[@"province_id"];
      ps_city = comPanyDic[@"city_id"];
      ps_area = comPanyDic[@"area_id"];
      if (ps_city == NULL) {
            ps_city = @"";
      }
      if (ps_area == NULL) {
            ps_area = @"";
      }
      NSString *companyAddress = [NSString stringWithFormat:@"%@%@%@",ps_province,ps_city,ps_area,nil];
      ps_businessAddressLabel.text = companyAddress;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //身份证正面
        if (![comPanyDic[@"idcard_img_one"] isEqualToString:@""]) {
            [ps_photoImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"idcard_img_one"]]];
            
            ps_photoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"idcard_img_one"]]]];
        }
        
        
        //身份证反面
        if (![comPanyDic[@"idcard_img_two"] isEqualToString:@""]) {
            [ps_photoImageViewOne sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"idcard_img_two"]] ];
            ps_photoImageOne = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"idcard_img_two"]]]];
        }

        //法人手持身份证
        if (![comPanyDic[@"idcard_img_three"] isEqualToString:@""]) {
            [ps_handPhotoImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"idcard_img_three"]]];
            ps_handPhotoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"idcard_img_three"]]]];
        }
        //门头照
        if (![comPanyDic[@"shop_img_one"] isEqualToString:@""]) {
            [ps_doorPhotoImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"shop_img_one"]]];
            ps_doorPhotoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"shop_img_one"]]]];
        }

        
        //经营场所
        if (![comPanyDic[@"shop_img_two"] isEqualToString:@""]) {
            [ps_placeImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"shop_img_two"]] ];
            ps_placeImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"shop_img_two"]]]];
            
        }
        //收银台
        if (![comPanyDic[@"shop_img_three"] isEqualToString:@""]) {
            [ps_cashierImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"shop_img_three"]] ];
            ps_cashierImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"shop_img_three"]]]];
            
        }
        //租赁合同一
        if (![comPanyDic[@"contract_img_one"] isEqualToString:@""]) {
            [ps_leaseImageView sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"contract_img_one"]]];
            
                ps_leaseImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"contract_img_one"]]]];
        }
        //租赁合同二
        if (![comPanyDic[@"contract_img_two"] isEqualToString:@""]) {
            [ps_leaseImageViewOne sd_setImageWithURL:[NSURL URLWithString:comPanyDic[@"contract_img_two"]]];
            ps_leaseImageOne = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:comPanyDic[@"contract_img_two"]]]];
        }
        
        
    });
}

/**
 警示 弹出框
 */
- (void)psShowAlert:(NSString *)warning{
    
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
- (void)keyBoardshow:(NSNotification*)notification{
    
    NSDictionary * info = [notification userInfo];
    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
    //键盘的高度
    ps_keyBoardHeight = keyboardRect.size.height;
    //键盘调起的时间长度
    ps_keyBoardDuration = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    ps_scrollViewOldoffSet = ps_scrollView.contentOffset.y;
    if ( (ps_selectField.frame.origin.y + ps_keyBoardHeight + 150) >= ([[UIScreen mainScreen] bounds].size.height-114 + ps_scrollViewOldoffSet)){
        //此时，编辑框被键盘盖住，则对视图做相应的位移
        CGFloat offSetY = ps_selectField.frame.origin.y + 150 + ps_keyBoardHeight - [[UIScreen mainScreen] bounds].size.height + 114;//偏移量=编辑框原点Y值+键盘高度+编辑框高度-屏幕高度
        [UIView animateWithDuration:ps_keyBoardDuration animations:^{
            [ps_scrollView setContentOffset:CGPointMake(0, offSetY) animated:YES];
            
        }];
        
    }
    
}
- (void)keyBoardhide:(NSNotification*)notification{
    
    [UIView animateWithDuration:ps_keyBoardDuration animations:^{
        [ps_scrollView setContentOffset:CGPointMake(0,ps_scrollViewOldoffSet) animated:YES];
    }];
    
    
}

/**
 scrollerView展示控制器
 */
- (void)psCreateScrollerView{
    
    ps_scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:ps_scrollView];
    ps_scrollView.alwaysBounceVertical  = YES ;
    ps_scrollView.contentSize = CGSizeMake(0, 1480/SCALE_Y);
    [ps_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
}
- (void)psCreateOneView{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_scrollView.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *businessLabel = [[UILabel alloc] init];
    businessLabel.font = [UIFont systemFontOfSize:14];
    businessLabel.textAlignment = NSTextAlignmentLeft;
    businessLabel.text = @"商家名称：";
    [businessLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:businessLabel];
    [businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    ps_businessField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_businessField];
    ps_businessField.delegate = self;
    ps_businessField.textAlignment = NSTextAlignmentLeft;
    ps_businessField.font = [UIFont systemFontOfSize:14];
    [ps_businessField setTextColor:COLORFromRGB(0x333333)];
    ps_businessField.placeholder = @"（必填）";
    [ps_businessField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line.mas_centerY).offset(-25);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = @"经营地址：";
    [addressLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineOne.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];

    UIButton *selectorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectorBtn  setTitle:@"+" forState:UIControlStateNormal];
    [selectorBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    selectorBtn.backgroundColor = COLORFromRGB(0Xe10000);
    selectorBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [ps_scrollView addSubview:selectorBtn];
    [selectorBtn addTarget:self action:@selector(selectorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineOne.mas_centerY).offset(-25);
        make.left.equalTo(addressLabel.mas_right).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    ps_businessAddressLabel = [[UILabel alloc] init];
    ps_businessAddressLabel.font = [UIFont systemFontOfSize:14];
    ps_businessAddressLabel.textAlignment = NSTextAlignmentLeft;
    [ps_businessAddressLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:ps_businessAddressLabel];
    [ps_businessAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineOne.mas_centerY).offset(-25);
        make.left.equalTo(selectorBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SC_WIDTH-140);
        
    }];

    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *detailAddressLabel = [[UILabel alloc] init];
    detailAddressLabel.font = [UIFont systemFontOfSize:14];
    detailAddressLabel.textAlignment = NSTextAlignmentLeft;
    detailAddressLabel.text = @"详细地址：";
    [detailAddressLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:detailAddressLabel];
    [detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTwo.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_detailAddressField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_detailAddressField];
    ps_detailAddressField.delegate = self;
    ps_detailAddressField.textAlignment = NSTextAlignmentLeft;
    ps_detailAddressField.font = [UIFont systemFontOfSize:14];
    [ps_detailAddressField setTextColor:COLORFromRGB(0x333333)];
    ps_detailAddressField.placeholder = @"（必填）";
    [ps_detailAddressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineTwo.mas_centerY).offset(-25);
        make.left.right.equalTo(lineTwo);
        make.height.mas_equalTo(40);
    }];

    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.text = @"姓        名：";
    [userNameLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineThird.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_userNameField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_userNameField];
    ps_userNameField.delegate = self;
    ps_userNameField.textAlignment = NSTextAlignmentLeft;
    ps_userNameField.font = [UIFont systemFontOfSize:14];
    [ps_userNameField setTextColor:COLORFromRGB(0x333333)];
    ps_userNameField.placeholder = @"负责人（必填）";
    [ps_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineThird.mas_centerY).offset(-25);
        make.left.right.equalTo(lineThird);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *cardedLabel = [[UILabel alloc] init];
    cardedLabel.font = [UIFont systemFontOfSize:14];
    cardedLabel.textAlignment = NSTextAlignmentLeft;
    cardedLabel.text = @"身份证号：";
    [cardedLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:cardedLabel];
    [cardedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFour.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_cardedField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_cardedField];
    ps_cardedField.delegate = self;
    ps_cardedField.textAlignment = NSTextAlignmentLeft;
    ps_cardedField.font = [UIFont systemFontOfSize:14];
    [ps_cardedField setTextColor:COLORFromRGB(0x333333)];
    ps_cardedField.placeholder = @"与填写姓名保持一致（必填）";
    [ps_cardedField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFour.mas_centerY).offset(-25);
        make.left.right.equalTo(lineFour);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineFive = [[UIImageView alloc] init];
    lineFive.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *telePhoneLabel = [[UILabel alloc] init];
    telePhoneLabel.font = [UIFont systemFontOfSize:14];
    telePhoneLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneLabel.text = @"联系电话：";
    [telePhoneLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:telePhoneLabel];
    [telePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFive.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_telePhoneField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_telePhoneField];
    ps_telePhoneField.delegate = self;
    ps_telePhoneField.textAlignment = NSTextAlignmentLeft;
    ps_telePhoneField.font = [UIFont systemFontOfSize:14];
    [ps_telePhoneField setTextColor:COLORFromRGB(0x333333)];
    ps_telePhoneField.placeholder = @"（必填）";
    [ps_telePhoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineFive.mas_centerY).offset(-25);
        make.left.right.equalTo(lineFive);
        make.height.mas_equalTo(40);
    }];


    UILabel *potoLabel = [[UILabel alloc] init];
    potoLabel.font = [UIFont systemFontOfSize:14];
    potoLabel.textAlignment = NSTextAlignmentLeft;
    potoLabel.text = @"上传负责人身份证照片";
    [potoLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:potoLabel];
    [potoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFive.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
        
    }];
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.tag = 110;
    [photoBtn addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    photoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:photoBtn];
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoLabel.mas_bottom).offset(10);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    ps_photoImageView = [[UIImageView alloc] init];
    [ps_photoImageView setImage:[UIImage imageNamed:@"身份证正面"]];
    ps_photoImageView.backgroundColor = COLORFromRGB(0xffffff);
    ps_photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [photoBtn addSubview:ps_photoImageView];
    [ps_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(photoBtn);
        
    }];
    
    UIButton *photoBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtnOne.tag = 111;
    [photoBtnOne addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    photoBtnOne.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:photoBtnOne];
    [photoBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(photoBtn.mas_centerY);
        make.left.equalTo(photoBtn.mas_right).offset(15);
        make.width.height.equalTo(photoBtn);
        
    }];
    
    ps_photoImageViewOne = [[UIImageView alloc] init];
    [ps_photoImageViewOne setImage:[UIImage imageNamed:@"身份证背面"]];
    ps_photoImageViewOne.backgroundColor = COLORFromRGB(0xffffff);
    ps_photoImageViewOne.contentMode = UIViewContentModeScaleAspectFit;
    [photoBtnOne addSubview:ps_photoImageViewOne];
    [ps_photoImageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(photoBtnOne);
        
    }];
    
    
    UILabel *handPhotoLabel = [[UILabel alloc] init];
    handPhotoLabel.font = [UIFont systemFontOfSize:14];
    handPhotoLabel.textAlignment = NSTextAlignmentLeft;
    handPhotoLabel.text = @"手持身份证照片";
    [handPhotoLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:handPhotoLabel];
    [handPhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(14);
        
    }];
    
    UILabel *doorFhotoLabel = [[UILabel alloc] init];
    doorFhotoLabel.font = [UIFont systemFontOfSize:14];
    doorFhotoLabel.textAlignment = NSTextAlignmentLeft;
    doorFhotoLabel.text = @"门头照图片(必填)";
    [doorFhotoLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:doorFhotoLabel];
    [doorFhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(handPhotoLabel.mas_centerY);
        make.left.equalTo(handPhotoLabel.mas_right).offset(15);
        make.width.height.equalTo(handPhotoLabel);
        
    }];
    
    UIButton *handPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [handPhotoBtn setImage:[UIImage imageNamed:@"手持身份证"] forState:UIControlStateNormal];
    handPhotoBtn.tag = 112;
    [handPhotoBtn addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    handPhotoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:handPhotoBtn];
    [handPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handPhotoLabel.mas_bottom).offset(10);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    ps_handPhotoImageView = [[UIImageView alloc] init];
    [ps_handPhotoImageView setImage:[UIImage imageNamed:@"手持身份证"]];
    ps_handPhotoImageView.backgroundColor = COLORFromRGB(0xffffff);
    ps_handPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [handPhotoBtn addSubview:ps_handPhotoImageView];
    [ps_handPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(handPhotoBtn);
        
    }];
    
    UIButton *doorPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doorPhotoBtn setImage:[UIImage imageNamed:@"门头照"] forState:UIControlStateNormal];
    doorPhotoBtn.tag = 113;
    [doorPhotoBtn addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    doorPhotoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:doorPhotoBtn];
    [doorPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(handPhotoBtn.mas_centerY);
        make.left.equalTo(handPhotoBtn.mas_right).offset(15);
        make.width.height.equalTo(handPhotoBtn);
        
    }];
    
    ps_doorPhotoImageView = [[UIImageView alloc] init];
    [ps_doorPhotoImageView setImage:[UIImage imageNamed:@"门头照"]];
    ps_doorPhotoImageView.backgroundColor = COLORFromRGB(0xffffff);
    ps_doorPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [doorPhotoBtn addSubview:ps_doorPhotoImageView];
    [ps_doorPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(doorPhotoBtn);
        
    }];
    
    UILabel *placeLabel = [[UILabel alloc] init];
    placeLabel.font = [UIFont systemFontOfSize:14];
    placeLabel.textAlignment = NSTextAlignmentLeft;
    placeLabel.text = @"经营场所(必填)";
    [placeLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:placeLabel];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handPhotoBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(16);
        
    }];
    
    
    UILabel *cashierLabel = [[UILabel alloc] init];
    cashierLabel.font = [UIFont systemFontOfSize:14];
    cashierLabel.textAlignment = NSTextAlignmentLeft;
    cashierLabel.text = @"收银台(必填)";
    [cashierLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:cashierLabel];
    [cashierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeLabel.mas_centerY);
        make.left.equalTo(placeLabel.mas_right).offset(15);
        make.width.height.equalTo(placeLabel);
        
    }];
    
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setImage:[UIImage imageNamed:@"经营场所"] forState:UIControlStateNormal];
    placeBtn.tag = 114;
    [placeBtn addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    placeBtn.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:placeBtn];
    [placeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeLabel.mas_bottom).offset(10);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    ps_placeImageView = [[UIImageView alloc] init];
    [ps_placeImageView setImage:[UIImage imageNamed:@"经营场所"]];
    ps_placeImageView.backgroundColor = COLORFromRGB(0xffffff);
    ps_placeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [placeBtn addSubview:ps_placeImageView];
    [ps_placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(placeBtn);
        
    }];
    
    
    UIButton *cashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cashierBtn setImage:[UIImage imageNamed:@"收银台"] forState:UIControlStateNormal];
    cashierBtn.tag = 115;
    [cashierBtn addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    cashierBtn.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:cashierBtn];
    [cashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeBtn.mas_centerY);
        make.left.equalTo(placeBtn.mas_right).offset(15);
        make.width.height.equalTo(placeBtn);
        
    }];
    ps_cashierImageView = [[UIImageView alloc] init];
    [ps_cashierImageView setImage:[UIImage imageNamed:@"收银台"]];
    ps_cashierImageView.backgroundColor = COLORFromRGB(0xffffff);
    ps_cashierImageView.contentMode = UIViewContentModeScaleAspectFit;
    [cashierBtn addSubview:ps_cashierImageView];
    [ps_cashierImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cashierBtn);
        
    }];

    
    UILabel *LeaseLabel = [[UILabel alloc] init];
    LeaseLabel.font = [UIFont systemFontOfSize:14];
    LeaseLabel.textAlignment = NSTextAlignmentLeft;
    LeaseLabel.text = @"租赁合同－";
    [LeaseLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:LeaseLabel];
    [LeaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cashierBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(16);
        
    }];

    
    UILabel *LeaseLabelOne = [[UILabel alloc] init];
    LeaseLabelOne.font = [UIFont systemFontOfSize:14];
    LeaseLabelOne.textAlignment = NSTextAlignmentLeft;
    LeaseLabelOne.text = @"租赁合同二";
    [LeaseLabelOne setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:LeaseLabelOne];
    [LeaseLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(LeaseLabel.mas_centerY);
        make.left.equalTo(LeaseLabel.mas_right).offset(15);
        make.width.height.equalTo(LeaseLabel);
        
    }];

    UIButton *leaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaseBtn setImage:[UIImage imageNamed:@"租赁合同一"] forState:UIControlStateNormal];
    leaseBtn.tag = 116;
    [leaseBtn addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    leaseBtn.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:leaseBtn];
    [leaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LeaseLabel.mas_bottom).offset(10);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    ps_leaseImageView = [[UIImageView alloc] init];
    [ps_leaseImageView setImage:[UIImage imageNamed:@"租赁合同一"]];
    ps_leaseImageView.backgroundColor = COLORFromRGB(0xffffff);
    ps_leaseImageView.contentMode = UIViewContentModeScaleAspectFit;
    [leaseBtn addSubview:ps_leaseImageView];
    [ps_leaseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(leaseBtn);
        
    }];
    
    
    
    UIButton *leaseBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaseBtnOne setImage:[UIImage imageNamed:@"租赁合同二"] forState:UIControlStateNormal];
    leaseBtnOne.tag = 117;
    [leaseBtnOne addTarget:self action:@selector(psButPhotoListClick:) forControlEvents:UIControlEventTouchUpInside];
    leaseBtnOne.backgroundColor = COLORFromRGB(0xffffff);
    [ps_scrollView addSubview:leaseBtnOne];
    [leaseBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leaseBtn.mas_centerY);
        make.left.equalTo(leaseBtn.mas_right).offset(15);
        make.width.height.equalTo(leaseBtn);
        
    }];
    
    ps_leaseImageViewOne = [[UIImageView alloc] init];
    [ps_leaseImageViewOne setImage:[UIImage imageNamed:@"租赁合同二"]];
    ps_leaseImageViewOne.backgroundColor = COLORFromRGB(0xffffff);
    ps_leaseImageViewOne.contentMode = UIViewContentModeScaleAspectFit;
    [leaseBtnOne addSubview:ps_leaseImageViewOne];
    [ps_leaseImageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(leaseBtnOne);
        
    }];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = COLORFromRGB(0xffffff);
    [imageView setImage:[UIImage imageNamed:@"组4"]];
    [ps_scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leaseBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(ps_scrollView);
        make.width.mas_equalTo(187);
        make.height.mas_equalTo(30);
        
    }];
    
    UIImageView *lineSix = [[UIImageView alloc] init];
    lineSix.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.font = [UIFont systemFontOfSize:14];
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.text = @"收款账号：";
    [accountLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSix.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_accountField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_accountField];
    ps_accountField.delegate = self;
    ps_accountField.textAlignment = NSTextAlignmentLeft;
    ps_accountField.font = [UIFont systemFontOfSize:14];
    [ps_accountField setTextColor:COLORFromRGB(0x333333)];
    ps_accountField.placeholder = @"（必填）";
    [ps_accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSix.mas_centerY).offset(-25);
        make.left.right.equalTo(lineSix);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineSeven = [[UIImageView alloc] init];
    lineSeven.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineSeven];
    [lineSeven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSix.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *payeeLabel = [[UILabel alloc] init];
    payeeLabel.font = [UIFont systemFontOfSize:14];
    payeeLabel.textAlignment = NSTextAlignmentLeft;
    payeeLabel.text = @"收  款  人：";
    [payeeLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:payeeLabel];
    [payeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSeven.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_payeeField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_payeeField];
    ps_payeeField.delegate = self;
    ps_payeeField.textAlignment = NSTextAlignmentLeft;
    ps_payeeField.font = [UIFont systemFontOfSize:14];
    [ps_payeeField setTextColor:COLORFromRGB(0x333333)];
    ps_payeeField.placeholder = @"（必填）";
    [ps_payeeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineSeven.mas_centerY).offset(-25);
        make.left.right.equalTo(lineSeven);
        make.height.mas_equalTo(40);
    }];

    
    UIImageView *lineEight = [[UIImageView alloc] init];
    lineEight.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineEight];
    [lineEight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSeven.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *bankLabel = [[UILabel alloc] init];
    bankLabel.font = [UIFont systemFontOfSize:14];
    bankLabel.textAlignment = NSTextAlignmentLeft;
    bankLabel.text = @"开  户  行：";
    [bankLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:bankLabel];
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineEight.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    UIButton *selectorBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectorBankBtn  setTitle:@"+" forState:UIControlStateNormal];
    [selectorBankBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    selectorBankBtn.backgroundColor = COLORFromRGB(0Xe10000);
    selectorBankBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [ps_scrollView addSubview:selectorBankBtn];
    [selectorBankBtn addTarget:self action:@selector(selectorbankClick) forControlEvents:UIControlEventTouchUpInside];
    [selectorBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bankLabel.mas_centerY);
        make.left.equalTo(bankLabel.mas_right).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    ps_bankLabel = [[UILabel alloc] init];
    [ps_scrollView addSubview:ps_bankLabel];
    ps_bankLabel.textAlignment = NSTextAlignmentLeft;
    ps_bankLabel.font = [UIFont systemFontOfSize:14];
    [ps_bankLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectorBankBtn.mas_centerY);
        make.left.equalTo(selectorBankBtn.mas_right).offset(5);
        make.right.equalTo(lineEight);
        make.height.mas_equalTo(40);
    }];

    UIImageView *lineNine = [[UIImageView alloc] init];
    lineNine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [ps_scrollView addSubview:lineNine];
    [lineNine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineEight.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];

    UILabel *branceTeleLabel = [[UILabel alloc] init];
    branceTeleLabel.font = [UIFont systemFontOfSize:14];
    branceTeleLabel.textAlignment = NSTextAlignmentLeft;
    branceTeleLabel.text = @"预留手机：";
    [branceTeleLabel setTextColor:COLORFromRGB(0x333333)];
    [ps_scrollView addSubview:branceTeleLabel];
    [branceTeleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineNine.mas_centerY).offset(-25);
        make.left.equalTo(ps_scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    ps_branceTelField = [[UITextField alloc] init];
    [ps_scrollView addSubview:ps_branceTelField];
    ps_branceTelField.delegate = self;
    ps_branceTelField.textAlignment = NSTextAlignmentLeft;
    ps_branceTelField.font = [UIFont systemFontOfSize:14];
    [ps_branceTelField setTextColor:COLORFromRGB(0x333333)];
    ps_branceTelField.placeholder = @"（必填）";
    [ps_branceTelField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lineNine.mas_centerY).offset(-25);
        make.left.right.equalTo(lineNine);
        make.height.mas_equalTo(40);
    }];
    
    ps_submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ps_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    ps_submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [ps_submitBtn.titleLabel setTextColor:COLORFromRGB(0xffffff)];
    ps_submitBtn.backgroundColor = COLORFromRGB(0xe10000);
    ps_submitBtn.layer.masksToBounds = YES;
    ps_submitBtn.layer.cornerRadius = 5;
    [ps_submitBtn addTarget:self action:@selector(psSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ps_scrollView addSubview:ps_submitBtn];
    [ps_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineNine.mas_bottom).offset(60/SCALE_Y);
        make.left.equalTo(ps_scrollView).offset(15);
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
        ps_businessAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
        ps_province = province;
        ps_city = city;
        ps_area = area;
    };
    [self.view addSubview:view];
    
}
#pragma ********************UITextFieldDelegate**************
/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    ps_selectField = textField;
    //scrollview便宜量
    ps_scrollViewOldoffSet = ps_scrollView.contentOffset.y;
    if ( (textField.frame.origin.y + ps_keyBoardHeight + 150) >= ([[UIScreen mainScreen] bounds].size.height-114 + ps_scrollViewOldoffSet)){
        //此时，编辑框被键盘盖住，则对视图做相应的位移
        CGFloat offSetY = textField.frame.origin.y + 150 + ps_keyBoardHeight - [[UIScreen mainScreen] bounds].size.height + 114;//偏移量=编辑框原点Y值+键盘高度+编辑框高度-屏幕高度
        [UIView animateWithDuration:ps_keyBoardDuration animations:^{
            [ps_scrollView setContentOffset:CGPointMake(0, offSetY) animated:YES];
            
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
    
    [UIView animateWithDuration:ps_keyBoardDuration animations:^{
        [ps_scrollView setContentOffset:CGPointMake(0,ps_scrollViewOldoffSet) animated:YES];
    }];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

/**
 相册列表操作按钮点击事件
 */
-(void)psButPhotoListClick:(UIButton *)btn{
    ps_selectBtnImage = btn;
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
#pragma ************UIImagePickerControllerDelegate相册代理方法****************
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
        
    if (!image){
        image = info[UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^{

    switch (ps_selectBtnImage.tag) {
        case 110:{
            ps_photoImage = image;
            [ps_photoImageView setImage:image];
        }
            break;
        case 111:{
            ps_photoImageOne = image;
            [ps_photoImageViewOne setImage:image];
            
        }
            break;
        case 112:{
            ps_handPhotoImage = image;
            [ps_handPhotoImageView setImage:image];
            
        }
            break;
        case 113:{
            ps_doorPhotoImage = image;
            [ps_doorPhotoImageView setImage:image];
            
        }
            break;
        case 114:{
            ps_placeImage = image;
            [ps_placeImageView setImage:image];
            
        }
            break;
        case 115:{
            ps_cashierImage = image;
            [ps_cashierImageView setImage:image];
            
        }
            break;
        case 116:{
            ps_leaseImage = image;
            [ps_leaseImageView setImage:image];
            
        }
            break;
        case 117:{
            ps_leaseImageOne = image;
            [ps_leaseImageViewOne setImage:image];
            
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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //移除通知
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidHideNotification    object:nil];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];
    
    
}
/**
 选择器控件懒加载
 */
- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, SC_WIDTH, 200/SCALE_Y)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView selectRow:3 inComponent:0 animated:NO];

        
    }
    return _pickerView;
}
/**
 懒加载数组
 */
- (NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}

#pragma mark  *** 自定义picker代理方法 ***
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1; //列表数
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArray.count; //行数
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return SC_WIDTH; //行宽度
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40; //行高度
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    QDPickerModel *model = self.dataArray[row];
    ps_currentBank = model.name;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    view.backgroundColor = [UIColor whiteColor];
    
    if (!view){
        view = [[UIView alloc]init];
    }
    QDPickerModel *model = self.dataArray[row];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100/SCALE_X,5,30,30);
    imageView.backgroundColor = [UIColor whiteColor];
    NSURL *imageUrl = [NSURL URLWithString:model.logo];
    [imageView sd_setImageWithURL:imageUrl];
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:16];
    [nameLabel setTextColor:COLORFromRGB(0x333333)];
    nameLabel.text = model.name;
    nameLabel.frame = CGRectMake(100/SCALE_X+40,5,200,16);
    [view addSubview:nameLabel];
    
    UILabel * conditionLabel = [[UILabel alloc] init];
    conditionLabel.textAlignment = NSTextAlignmentLeft;
    [conditionLabel setTextColor:COLORFromRGB(0x666666)];
    conditionLabel.font = [UIFont systemFontOfSize:12];
    conditionLabel.text = model.summ;
    conditionLabel.frame = CGRectMake(100/SCALE_X+40,23,200,12);
    [view addSubview:conditionLabel];
    
    return view;
}
/**
 银行选择弹出框 确定按钮点击事件
 
 */
- (void)okClick:(UIButton*)btn{
    [ps_bankView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_maskView).offset(SC_HEIGHT-122);
        
    }];
    ps_bankLabel.text = ps_currentBank;
    [UIView animateWithDuration:0.5 animations:^{
        [ps_maskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        ps_maskView.hidden = YES ;
        
    }];
    
    
}

/**
 银行选择弹出框 取消按钮点击事件
 
 */
- (void)cancelClick:(UIButton*)btn{
    [ps_bankView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_maskView).offset(SC_HEIGHT-122);
        
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [ps_maskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        ps_maskView.hidden = YES;
        
    }];
}

/**
 银行选择 按钮点击事件
 */
- (void)selectorbankClick{
    //收回键盘
    [self.view endEditing:YES];
    
    ps_maskView.hidden = NO;
    //修改下边距约束
    [ps_bankView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ps_maskView).offset(SC_HEIGHT-362);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [ps_maskView layoutIfNeeded];
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
