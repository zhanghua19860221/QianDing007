//
//  CompanyController.m
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CompanyController.h"

@interface CompanyController (){
    UITextField *companyNameField;  //企业名称
    UITextField *creditField;       //信用代码
    UITextField *addressField;      //企业地址
    UITextField *detailAddressField;//详细地址
    UITextField *userNameField;     //姓名
    UITextField *cardedField;       //身份证号
    UITextField *telePhoneField;    //联系电话
    UIScrollView *scrollView;//展示视图


}

@end

@implementation CompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self createScrollerView];
    [self createOneView];

    // Do any additional setup after loading the view.
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    //    _scrollView.scrollEnabled = NO;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(0, 1600);
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
        make.top.equalTo(scrollView.mas_bottom).offset(50);
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
    }];
    
    
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(40);
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
    }];
    
    
    
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(40);
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
        make.height.mas_equalTo(16);
        
    }];
    
    
    
    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(40);
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
    }];
    
    
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(40);
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
    }];
    
    
    UIImageView *lineFive = [[UIImageView alloc] init];
    lineFive.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(40);
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
    }];
    
    
    
    UIImageView *lineSix = [[UIImageView alloc] init];
    lineSix.backgroundColor = COLORFromRGB(0xf9f9f9);
    [scrollView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFive.mas_bottom).offset(40);
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
        make.height.mas_equalTo(16);
        
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
        make.height.mas_equalTo(16);
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
    UIImageView *potoView = [[UIImageView alloc] init];
    potoView.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:potoView];
    [potoView setImage:[UIImage imageNamed:@"身份证正面"]];
    [potoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoLabel.mas_bottom).offset(10);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    UIImageView *potoViewOne = [[UIImageView alloc] init];
    potoViewOne.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:potoViewOne];
    [potoViewOne setImage:[UIImage imageNamed:@"身份证背面"]];
    [potoViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(potoView.mas_centerY);
        make.left.equalTo(potoView.mas_right).offset(15);
        make.width.height.equalTo(potoView);
        
    }];
    
    UILabel *handPotoLabel = [[UILabel alloc] init];
    handPotoLabel.font = [UIFont systemFontOfSize:14];
    handPotoLabel.textAlignment = NSTextAlignmentLeft;
    handPotoLabel.text = @"法人手持身份证照片";
    [handPotoLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:handPotoLabel];
    [handPotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoView.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        
    }];
    UIImageView *handPotoView = [[UIImageView alloc] init];
    handPotoView.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:handPotoView];
    [handPotoView setImage:[UIImage imageNamed:@"手持身份证"]];
    [handPotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoLabel.mas_bottom).offset(10);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
        make.height.mas_equalTo(100/SCALE_Y);
        
    }];
    
    UIImageView *handPotoViewOne = [[UIImageView alloc] init];
    handPotoViewOne.backgroundColor = COLORFromRGB(0xffffff);
    [scrollView addSubview:handPotoViewOne];
    [handPotoViewOne setImage:[UIImage imageNamed:@"手持身份证"]];
    [handPotoViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(handPotoView.mas_centerY);
        make.left.equalTo(handPotoView.mas_right).offset(15);
        make.width.height.equalTo(handPotoView);
        
    }];
    
    UILabel *licenseLabel = [[UILabel alloc] init];
    licenseLabel.font = [UIFont systemFontOfSize:14];
    licenseLabel.textAlignment = NSTextAlignmentLeft;
    licenseLabel.text = @"营业执照(必填)";
    [licenseLabel setTextColor:COLORFromRGB(0x333333)];
    [scrollView addSubview:licenseLabel];
    [licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(potoView.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(scrollView).offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
        
    }];
    
    
//    UIImageView *handPotoView = [[UIImageView alloc] init];
//    handPotoView.backgroundColor = COLORFromRGB(0xffffff);
//    [scrollView addSubview:handPotoView];
//    [handPotoView setImage:[UIImage imageNamed:@"手持身份证"]];
//    [handPotoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(potoLabel.mas_bottom).offset(10);
//        make.left.equalTo(scrollView).offset(15);
//        make.width.mas_equalTo((SC_WIDTH-45)/2.0);
//        make.height.mas_equalTo(100/SCALE_Y);
//        
//    }];
//    
//    UIImageView *handPotoViewOne = [[UIImageView alloc] init];
//    handPotoViewOne.backgroundColor = COLORFromRGB(0xffffff);
//    [scrollView addSubview:handPotoViewOne];
//    [handPotoViewOne setImage:[UIImage imageNamed:@"手持身份证"]];
//    [handPotoViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(handPotoView.mas_centerY);
//        make.left.equalTo(handPotoView.mas_right).offset(15);
//        make.width.height.equalTo(handPotoView);
//        
//    }];
    
    
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
    [companyNameField resignFirstResponder];
    [creditField resignFirstResponder];
    [addressField resignFirstResponder];
    [detailAddressField resignFirstResponder];
    [userNameField resignFirstResponder];
    [cardedField resignFirstResponder];
    [telePhoneField resignFirstResponder];
    
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
