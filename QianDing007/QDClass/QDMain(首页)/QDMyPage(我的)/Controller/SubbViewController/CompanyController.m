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
    UITextField *cp_selectField;       //记录当前编辑的输入框

    UITextField *companyNameField;  //企业名称
    UITextField *creditField;       //信用代码
    UITextField *addressField;      //企业地址
    UITextField *detailAddressField;//详细地址
    UITextField *userNameField;     //姓名
    UITextField *cardedField;       //身份证号
    UITextField *telePhoneField;    //联系电话
    UITextField *accountField;      //收款账户
    UITextField *payeeField;        //收款人
    UITextField *bankField;         //开户行
    UITextField *branceBankField;   //支行行号
    UILabel *companyAddressLabel;   //公司地址
    UIScrollView *scrollView;//展示视图
    

}

@end

@implementation CompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self cmGetDataSource];
    [self createScrollerView];
    [self createOneView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardshow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardhide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

/**
 获取网络企业信息数据
 */
- (void)cmGetDataSource{

    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *levelDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:GETINFOUSER_URL parameters:levelDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(0, 1400/SCALE_Y);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
}
- (void)createOneView{

    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *companyNameLabel = [[UILabel alloc] init];
    companyNameLabel.font = [UIFont systemFontOfSize:14];
    companyNameLabel.textAlignment = NSTextAlignmentLeft;
    companyNameLabel.text = @"企业名称：";
    [companyNameLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:companyNameLabel];
    [companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    companyNameField = [[UITextField alloc] init];
    [scrollView addSubview:companyNameField];
    companyNameField.delegate = self;
    companyNameField.textAlignment = NSTextAlignmentLeft;
    companyNameField.font = [UIFont systemFontOfSize:14];
    [companyNameField setTextColor:COLORFromRGB(0x333333)];
    companyNameField.placeholder = @"名称";
    [companyNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.right.equalTo(line);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *creditLabel = [[UILabel alloc] init];
    creditLabel.font = [UIFont systemFontOfSize:14];
    creditLabel.textAlignment = NSTextAlignmentLeft;
    creditLabel.text = @"信用代码：";
    [creditLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:creditLabel];
    [creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        
    }];
    UILabel *creditLabelOne = [[UILabel alloc] init];
    creditLabelOne.font = [UIFont systemFontOfSize:14];
    creditLabelOne.textAlignment = NSTextAlignmentLeft;
    creditLabelOne.text = @"统一社会";
    [creditLabelOne setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:creditLabelOne];
    [creditLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(creditLabel.mas_top);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        
    }];
    creditField = [[UITextField alloc] init];
    [scrollView addSubview:creditField];
    creditField.delegate = self;
    creditField.textAlignment = NSTextAlignmentLeft;
    creditField.font = [UIFont systemFontOfSize:14];
    [creditField setTextColor:COLORFromRGB(0x333333)];
    creditField.placeholder = @"信用";
    [creditField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.right.equalTo(lineOne);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.text = @"企业地址：";
    [addressLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    UIButton *selectorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectorBtn  setTitle:@"+" forState:UIControlStateNormal];
    [selectorBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    selectorBtn.backgroundColor = COLORFromRGB(0Xe10000);
    selectorBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [scrollView addSubview:selectorBtn];
    [selectorBtn addTarget:self action:@selector(selectorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom).offset(-5);
        make.left.equalTo(addressLabel.mas_right).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    companyAddressLabel = [[UILabel alloc] init];
    companyAddressLabel.font = [UIFont systemFontOfSize:14];
    companyAddressLabel.textAlignment = NSTextAlignmentLeft;
    [companyAddressLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:companyAddressLabel];
    [companyAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTwo.mas_bottom);
        make.left.equalTo(selectorBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SC_WIDTH-140);
        
    }];
    

    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *detailAddressLabel = [[UILabel alloc] init];
    detailAddressLabel.font = [UIFont systemFontOfSize:14];
    detailAddressLabel.textAlignment = NSTextAlignmentLeft;
    detailAddressLabel.text = @"详细地址：";
    [detailAddressLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:detailAddressLabel];
    [detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThird.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    detailAddressField = [[UITextField alloc] init];
    [scrollView addSubview:detailAddressField];
    detailAddressField.delegate = self;
    detailAddressField.textAlignment = NSTextAlignmentLeft;
    detailAddressField.font = [UIFont systemFontOfSize:14];
    [detailAddressField setTextColor:COLORFromRGB(0x333333)];
    detailAddressField.placeholder = @"详细地址";
    [detailAddressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineThird.mas_bottom);
        make.left.right.equalTo(lineThird);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.text = @"姓        名：";
    [userNameLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFour.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    userNameField = [[UITextField alloc] init];
    [scrollView addSubview:userNameField];
    userNameField.delegate = self;
    userNameField.textAlignment = NSTextAlignmentLeft;
    userNameField.font = [UIFont systemFontOfSize:14];
    [userNameField setTextColor:COLORFromRGB(0x333333)];
    userNameField.placeholder = @"姓名";
    [userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFour.mas_bottom);
        make.left.right.equalTo(lineThird);
        make.height.mas_equalTo(40);
    }];
    
    
    UIImageView *lineFive = [[UIImageView alloc] init];
    lineFive.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *cardedLabel = [[UILabel alloc] init];
    cardedLabel.font = [UIFont systemFontOfSize:14];
    cardedLabel.textAlignment = NSTextAlignmentLeft;
    cardedLabel.text = @"身份证号：";
    [cardedLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:cardedLabel];
    [cardedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFive.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    cardedField = [[UITextField alloc] init];
    [scrollView addSubview:cardedField];
    cardedField.delegate = self;
    cardedField.textAlignment = NSTextAlignmentLeft;
    cardedField.font = [UIFont systemFontOfSize:14];
    [cardedField setTextColor:COLORFromRGB(0x333333)];
    cardedField.placeholder = @"身份证号：";
    [cardedField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineFive.mas_bottom);
        make.left.right.equalTo(lineFive);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIImageView *lineSix = [[UIImageView alloc] init];
    lineSix.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFive.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *telePhoneLabel = [[UILabel alloc] init];
    telePhoneLabel.font = [UIFont systemFontOfSize:14];
    telePhoneLabel.textAlignment = NSTextAlignmentLeft;
    telePhoneLabel.text = @"联系电话：";
    [telePhoneLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:telePhoneLabel];
    [telePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineSix.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    telePhoneField = [[UITextField alloc] init];
    [scrollView addSubview:telePhoneField];
    telePhoneField.delegate = self;
    telePhoneField.textAlignment = NSTextAlignmentLeft;
    telePhoneField.font = [UIFont systemFontOfSize:14];
    [telePhoneField setTextColor:COLORFromRGB(0x333333)];
    telePhoneField.placeholder = @"联系电话";
    [telePhoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineSix.mas_bottom);
        make.left.right.equalTo(lineSix);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *potoLabel = [[UILabel alloc] init];
    potoLabel.font = [UIFont systemFontOfSize:14];
    potoLabel.textAlignment = NSTextAlignmentLeft;
    potoLabel.text = @"上传法人身份证照片";
    [potoLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:potoLabel];
    [potoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSix.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        
    }];
    UIButton *potoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [potoBtn setImage:[UIImage imageNamed:@"身份证正面"] forState:UIControlStateNormal];
    potoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:potoBtn];
    [potoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoLabel.mas_bottom).offset(10);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    UIButton *potoBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [potoBtnOne setImage:[UIImage imageNamed:@"身份证背面"] forState:UIControlStateNormal];
    potoBtnOne.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:potoBtnOne];
    [potoBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(potoBtn.mas_centerY);
        make.left.equalTo(potoBtn.mas_right).offset(15);
        make.width.height.equalTo(potoBtn);
        
    }];

    UILabel *handPotoLabel = [[UILabel alloc] init];
    handPotoLabel.font = [UIFont systemFontOfSize:14];
    handPotoLabel.textAlignment = NSTextAlignmentLeft;
    handPotoLabel.text = @"法人手持身份证照片";
    [handPotoLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:handPotoLabel];
    [handPotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        
    }];
    
    UIButton *handPotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [handPotoBtn setImage:[UIImage imageNamed:@"手持身份证"] forState:UIControlStateNormal];
    handPotoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:handPotoBtn];
    [handPotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handPotoLabel.mas_bottom).offset(10);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    UIButton *handPotoBtnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [handPotoBtnOne setImage:[UIImage imageNamed:@"手持身份证"] forState:UIControlStateNormal];
    handPotoBtnOne.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:handPotoBtnOne];
    [handPotoBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(handPotoBtn.mas_centerY);
        make.left.equalTo(handPotoBtn.mas_right).offset(15);
        make.width.height.equalTo(handPotoBtn);
        
    }];

    UILabel *licenseLabel = [[UILabel alloc] init];
    licenseLabel.font = [UIFont systemFontOfSize:14];
    licenseLabel.textAlignment = NSTextAlignmentLeft;
    licenseLabel.text = @"营业执照(必填)";
    [licenseLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:licenseLabel];
    [licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handPotoBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *doorFhotoLabel = [[UILabel alloc] init];
    doorFhotoLabel.font = [UIFont systemFontOfSize:14];
    doorFhotoLabel.textAlignment = NSTextAlignmentLeft;
    doorFhotoLabel.text = @"门头照图片(必填)";
    [doorFhotoLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:doorFhotoLabel];
    [doorFhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(licenseLabel.mas_centerY);
        make.left.equalTo(licenseLabel.mas_right).offset(15);
        make.width.height.equalTo(licenseLabel);
        
    }];
    
    UIButton *licenseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [licenseBtn setImage:[UIImage imageNamed:@"营业执照"] forState:UIControlStateNormal];
    licenseBtn.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:licenseBtn];
    [licenseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(licenseLabel.mas_bottom).offset(10);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    UIButton *doorFhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doorFhotoBtn setImage:[UIImage imageNamed:@"门头照"] forState:UIControlStateNormal];
    doorFhotoBtn.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:doorFhotoBtn];
    [doorFhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(licenseBtn.mas_centerY);
        make.left.equalTo(licenseBtn.mas_right).offset(15);
        make.width.height.equalTo(licenseBtn);
        
    }];
    
    
    UILabel *placeLabel = [[UILabel alloc] init];
    placeLabel.font = [UIFont systemFontOfSize:14];
    placeLabel.textAlignment = NSTextAlignmentLeft;
    placeLabel.text = @"经营场所(必填)";
    [placeLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:placeLabel];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(licenseBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(16);
        
    }];
    
    
    UILabel *cashierLabel = [[UILabel alloc] init];
    cashierLabel.font = [UIFont systemFontOfSize:14];
    cashierLabel.textAlignment = NSTextAlignmentLeft;
    cashierLabel.text = @"收银台(必填)";
    [cashierLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:cashierLabel];
    [cashierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeLabel.mas_centerY);
        make.left.equalTo(placeLabel.mas_right).offset(15);
        make.width.height.equalTo(placeLabel);
        
    }];
    UIButton *placeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [placeBtn setImage:[UIImage imageNamed:@"经营场所"] forState:UIControlStateNormal];
    placeBtn.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:placeBtn];
    [placeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeLabel.mas_bottom).offset(10);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    UIButton *cashierBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cashierBtn setImage:[UIImage imageNamed:@"收银台"] forState:UIControlStateNormal];
    cashierBtn.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:cashierBtn];
    [cashierBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(placeBtn.mas_centerY);
        make.left.equalTo(placeBtn.mas_right).offset(15);
        make.width.height.equalTo(placeBtn);
        
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = COLORFromRGB(0xffffff);
    [imageView setImage:[UIImage imageNamed:@"组4"]];
    [scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(placeBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView);
        make.width.mas_equalTo(187);
        make.height.mas_equalTo(30);
        
    }];
    
    UIImageView *lineSeven = [[UIImageView alloc] init];
    lineSeven.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineSeven];
    [lineSeven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.font = [UIFont systemFontOfSize:14];
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.text = @"收款账户：";
    [accountLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineSeven.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    accountField = [[UITextField alloc] init];
    [scrollView addSubview:accountField];
    accountField.delegate = self;
    accountField.textAlignment = NSTextAlignmentLeft;
    accountField.font = [UIFont systemFontOfSize:14];
    [accountField setTextColor:COLORFromRGB(0x333333)];
    accountField.placeholder = @"账户";
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineSeven.mas_bottom);
        make.left.right.equalTo(lineSeven);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineEight = [[UIImageView alloc] init];
    lineEight.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineEight];
    [lineEight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineSeven.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *payeeLabel = [[UILabel alloc] init];
    payeeLabel.font = [UIFont systemFontOfSize:14];
    payeeLabel.textAlignment = NSTextAlignmentLeft;
    payeeLabel.text = @"收款人：";
    [payeeLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:payeeLabel];
    [payeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineEight.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    payeeField = [[UITextField alloc] init];
    [scrollView addSubview:payeeField];
    payeeField.delegate = self;
    payeeField.textAlignment = NSTextAlignmentLeft;
    payeeField.font = [UIFont systemFontOfSize:14];
    [payeeField setTextColor:COLORFromRGB(0x333333)];
    payeeField.placeholder = @"收款人";
    [payeeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineEight.mas_bottom);
        make.left.right.equalTo(lineEight);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineNine = [[UIImageView alloc] init];
    lineNine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineNine];
    [lineNine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineEight.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *bankLabel = [[UILabel alloc] init];
    bankLabel.font = [UIFont systemFontOfSize:14];
    bankLabel.textAlignment = NSTextAlignmentLeft;
    bankLabel.text = @"开户行：";
    [bankLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:bankLabel];
    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineNine.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    bankField = [[UITextField alloc] init];
    [scrollView addSubview:bankField];
    bankField.delegate = self;
    bankField.textAlignment = NSTextAlignmentLeft;
    bankField.font = [UIFont systemFontOfSize:14];
    [bankField setTextColor:COLORFromRGB(0x333333)];
    bankField.placeholder = @"开户行";
    [bankField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineNine.mas_bottom);
        make.left.right.equalTo(lineNine);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *lineTen = [[UIImageView alloc] init];
    lineTen.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineTen];
    [lineTen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineNine.mas_bottom).offset(40/SCALE_Y);
        make.left.equalTo(scrollView).offset(95);
        make.width.mas_equalTo(SC_WIDTH-110);
        make.height.mas_equalTo(1);
        
    }];
    UILabel *branceBankLabel = [[UILabel alloc] init];
    branceBankLabel.font = [UIFont systemFontOfSize:14];
    branceBankLabel.textAlignment = NSTextAlignmentLeft;
    branceBankLabel.text = @"支行行号：";
    [branceBankLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:branceBankLabel];
    [branceBankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTen.mas_bottom);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        
    }];
    
    branceBankField = [[UITextField alloc] init];
    [scrollView addSubview:branceBankField];
    branceBankField.delegate = self;
    branceBankField.textAlignment = NSTextAlignmentLeft;
    branceBankField.font = [UIFont systemFontOfSize:14];
    [branceBankField setTextColor:COLORFromRGB(0x333333)];
    branceBankField.placeholder = @"支行行号";
    [branceBankField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineTen.mas_bottom);
        make.left.right.equalTo(lineTen);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [submitBtn.titleLabel setTextColor:COLORFromRGB(0xffffff)];
    submitBtn.backgroundColor = COLORFromRGB(0xe10000);
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [scrollView addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(ccSubmitBtnBlick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTen.mas_bottom).offset(60/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(SC_WIDTH-30);
        make.height.mas_equalTo(50/SCALE_Y);

    }];
    
}
- (void)ccSubmitBtnBlick{


    
}
/**
 城市选择按钮点击事件
 */
- (void)selectorBtnClick{
    LSCityChooseView * view = [[LSCityChooseView alloc] initWithFrame:CGRectMake(0, -124, SC_WIDTH, SC_HEIGHT)];
    view.selectedBlock = ^(NSString * province, NSString * city, NSString * area){
        companyAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    };
    [self.view addSubview:view];

}
//- (void)keyBoardshow:(NSNotification*)notification{
//    
//    NSDictionary * info = [notification userInfo];
//    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
//    double keyboardHeight=keyboardRect.size.height;//键盘的高度
//    CGRect frame =  CGRectMake(0, 0, SC_WIDTH, 1400/SCALE_Y);
//
//    NSLog(@"%f",cp_selectField.frame.origin.y );
//        if ( (cp_selectField.frame.origin.y + keyboardHeight +100) >= ([[UIScreen mainScreen] bounds].size.height-120)){
//            //此时，编辑框被键盘盖住，则对视图做相应的位移
//            frame.origin.y -= cp_selectField.frame.origin.y +100 + keyboardHeight - [[UIScreen mainScreen] bounds].size.height+120;//偏移量=编辑框原点Y值+键盘高度+编辑框高度-屏幕高度
//            scrollView.frame = frame;
//        }
////    [scrollView setContentOffset:CGPointMake(0, frame.origin.y) animated:YES];
//
//}
//- (void)keyBoardhide:(NSNotification*)notification{
//    
//    CGFloat  duration = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    [UIView animateWithDuration:duration animations:^{
////        scrollView.frame = CGRectMake(0, 0,SC_WIDTH, 1400/SCALE_Y);
//    }];
//    
//    
//}
//#pragma ********************UIScrollViewDelegate**************
//// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//
//}
#pragma ********************UITextFieldDelegate**************
/**
 当输入框开始时触发 ( 获得焦点触发)
 
 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{
    
//    cp_selectField = textField;
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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidShowNotification  object:nil];
//    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidHideNotification    object:nil];


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
