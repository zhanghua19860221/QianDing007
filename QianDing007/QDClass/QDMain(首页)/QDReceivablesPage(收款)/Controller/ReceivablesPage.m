//
//  ReceivablesPage.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ReceivablesPage.h"
#import "MoreOrderController.h"
#import "ChannelSetingController.h"
#import "MyLevelController.h"
#import "MyRequestController.h"
#import "UserViewController.h"
#import "ScanCodeController.h"
#import "SweepMeController.h"

@interface ReceivablesPage (){
    
    UIView *mebInfoView;//会员信息展示视图
    UIView *profitView;//商家收益视图
    UIView *myView;//我的等级视图
    UIView *codeView;//二维码扫描视图
    NSMutableDictionary *rp_Dic;//数据字典
    UILabel *rp_telePhone;//头部商户电话
    UIButton *rp_verificationBtn;//头部认证按钮
    UILabel *rp_mebLeveLabel;//头部会员等级
    UIImageView *rp_mebIconView;//头部会员图标
    UILabel *rp_scaleLabel;//费率百分比
    UILabel *rp_orderNum;  //订单数
    UILabel *rp_orderScale;//订单环比
    UILabel *rp_moneyNum;  //收款数
    UILabel *rp_moneyScale;//收款环比

    
}
@end

@implementation ReceivablesPage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBasicView];
    [self createMebInfoView];
    [self createProfitView];
    [self createMyView];
    [self createCodeView];

    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self getDateSource];

}
- (void)getDateSource{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    rp_Dic = [[NSMutableDictionary alloc] init];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *rootDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:HOME_URL parameters:rootDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        //本地保存用户 登录标志 数据
        NSString *checked = [responseObject objectForKey:@"checked"];
        [[shareDelegate shareNSUserDefaults] setObject:checked forKey:@"is_checked"];
        
        [rp_Dic addEntriesFromDictionary:responseObject];
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self addDataToSubview];
            
        }else{
            [self rvShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
- (void)addDataToSubview{
    
// 商户信息视图填充网络数据
    rp_telePhone.text = [NSString stringWithFormat:@"您好！%@",[rp_Dic objectForKey:@"supplier_name"]];
    
    if ([rp_Dic[@"checked"] isEqualToString:@"0"]) {
        [rp_verificationBtn setImage:[UIImage imageNamed:@"去认证"] forState:UIControlStateNormal];
    }else if ([rp_Dic[@"checked"] isEqualToString:@"1"]){
        [rp_verificationBtn setImage:[UIImage imageNamed:@"已认证"] forState:UIControlStateNormal];
    }
    [rp_verificationBtn addTarget:self action:@selector(verificationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rp_mebLeveLabel.text = [rp_Dic objectForKey:@"level_name"];
    
    NSString *levelName = rp_Dic[@"level_name"];
    if ([levelName isEqualToString:@"普通商户"]) {
        [rp_mebIconView setImage:[UIImage imageNamed:@"普通会员"]];
    }else if ([levelName isEqualToString:@"银牌商户"]){
        [rp_mebIconView setImage:[UIImage imageNamed:@"银牌会员44*44"]];
    }else if ([levelName isEqualToString:@"金牌商户"]){
        [rp_mebIconView setImage:[UIImage imageNamed:@"金牌会员44*44"]];
    }else if ([levelName isEqualToString:@"钻石商户"]){
        [rp_mebIconView setImage:[UIImage imageNamed:@"钻石会员44*44"]];
    }
    rp_scaleLabel.text =  rp_Dic[@"level_scale"];

    
    int orderCount = [rp_Dic[@"count"] intValue];
    NSString *str = [NSString stringWithFormat:@"%d",orderCount];
    rp_orderNum.text = str;
    
    NSString *orderScale = [NSString stringWithFormat:@"环比%@",rp_Dic[@"relative_count"]];
    rp_orderScale.text = orderScale;
    rp_moneyNum.text = rp_Dic[@"sum"];
    
    NSString *moneyScale = [NSString stringWithFormat:@"环比%@",rp_Dic[@"relative_sum"]];
    rp_moneyScale.text = moneyScale;

}
/**
 会员信息视图
 */
- (void)createMebInfoView{
    
    rp_telePhone = [[UILabel alloc] init];
    rp_telePhone.text = @"您好！";
    [rp_telePhone setTextColor:COLORFromRGB(0x333333)];
    rp_telePhone.font = [UIFont systemFontOfSize:16];
    rp_telePhone.textAlignment = NSTextAlignmentLeft;
    [mebInfoView addSubview:rp_telePhone];
    [rp_telePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mebInfoView).offset(15/SCALE_Y);
        make.left.equalTo(mebInfoView).offset(15);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(16);
        
    }];
    rp_verificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mebInfoView addSubview:rp_verificationBtn];
    [rp_verificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rp_telePhone.mas_centerY);
        make.left.equalTo(rp_telePhone.mas_right).offset(10);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(23);
        
    }];
    
    rp_mebLeveLabel = [[UILabel alloc] init];
    rp_mebLeveLabel.text = @"";
    rp_mebLeveLabel.textAlignment = NSTextAlignmentLeft;
    rp_mebLeveLabel.font = [UIFont systemFontOfSize:16];
    [rp_mebLeveLabel setTextColor:COLORFromRGB(0x333333)];
    [mebInfoView addSubview:rp_mebLeveLabel];
    [rp_mebLeveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rp_telePhone.mas_bottom).offset(33/SCALE_Y);
        make.left.equalTo(mebInfoView).offset(55/SCALE_X);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    
    rp_mebIconView = [[UIImageView alloc] init];
    [mebInfoView addSubview:rp_mebIconView];
    [rp_mebIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rp_mebLeveLabel.mas_centerY);
        make.left.equalTo(rp_mebLeveLabel.mas_right).offset(10);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
        
    }];
    
    
    UILabel *mebRateLabel = [[UILabel alloc] init];
    mebRateLabel.text = @"费        率";
    mebRateLabel.textAlignment = NSTextAlignmentLeft;
    [rp_telePhone setTextColor:COLORFromRGB(0x333333)];
    mebRateLabel.font = [UIFont systemFontOfSize:16];
    [mebInfoView addSubview:mebRateLabel];
    [mebRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rp_mebLeveLabel.mas_bottom).offset(25/SCALE_Y);
        make.left.equalTo(rp_mebLeveLabel);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    
    rp_scaleLabel = [[UILabel alloc] init];
    rp_scaleLabel.text =  @"";
    rp_scaleLabel.font = [UIFont systemFontOfSize:21];
    [mebInfoView addSubview:rp_scaleLabel];
    [rp_scaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mebRateLabel.mas_bottom);
        make.left.equalTo(mebRateLabel.mas_right).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
        
    }];
    
    UIButton *upGradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upGradeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [upGradeBtn setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
    [upGradeBtn setTitle:@"去升级" forState:UIControlStateNormal];
    [upGradeBtn addTarget:self action:@selector(upGradeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mebInfoView addSubview:upGradeBtn];
    [upGradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(mebRateLabel.mas_centerY);
        make.right.equalTo(mebInfoView).offset(-55/SCALE_X);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
        
    }];
    
    UIImageView *upGradeView = [[UIImageView alloc] init];
    [upGradeView setImage:[UIImage imageNamed:@"去升级图标"]];
    [mebInfoView addSubview:upGradeView];
    [upGradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(upGradeBtn.mas_centerX);
        make.bottom.equalTo(upGradeBtn.mas_top).offset(-5);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(38);
        
    }];

}
/**
 未认证点击事件
 */
- (void)verificationBtnClick{

    if (![rp_Dic[@"checked"] isEqualToString:@"1"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
        
        UserViewController *verificationVc = [[UserViewController alloc] init];
        [self.navigationController pushViewController:verificationVc animated:YES];
    }
}
/**
 去升级
 */
- (void)upGradeBtnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    MyLevelController *VC = [[MyLevelController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 创建商户收益视图
 */
- (void)createProfitView{
    
    profitView.userInteractionEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"商家收益"]];
    [profitView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profitView).offset(15/SCALE_Y);
        make.left.equalTo(profitView).offset(15);
        make.width.mas_equalTo(116);
        make.height.mas_equalTo(20);
        
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"更多..." forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreBtn setTitleColor:COLORFromRGB(0x999999) forState:UIControlStateNormal];
    moreBtn.userInteractionEnabled = YES;
    [moreBtn addTarget:self action:@selector(showMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [profitView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView.mas_centerY);
        make.right.equalTo(profitView).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
        
    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(0, 50, SC_WIDTH, 1);
    lineView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [profitView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(15/SCALE_Y);
        make.left.equalTo(profitView).offset(15);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    
    rp_orderNum = [[UILabel alloc] init];
    rp_orderNum.text = @"0";
    rp_orderNum.textAlignment = NSTextAlignmentCenter;
    rp_orderNum.font = [UIFont systemFontOfSize:20];
    [rp_orderNum setTextColor:COLORFromRGB(0xe10000)];
    [profitView addSubview:rp_orderNum];
    [rp_orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(profitView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(20);
        
    }];
    
    rp_moneyNum = [[UILabel alloc] init];
    rp_moneyNum.text = @"0";
    rp_moneyNum.font = [UIFont systemFontOfSize:20];
    [rp_moneyNum setTextColor:COLORFromRGB(0xe10000)];
    rp_moneyNum.textAlignment = NSTextAlignmentCenter;
    [profitView addSubview:rp_moneyNum];
    [rp_moneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rp_orderNum.mas_centerY);
        make.left.equalTo(rp_orderNum.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(20);
        
    }];
    
    rp_orderScale = [[UILabel alloc] init];
    rp_orderScale.text = @"0";
    rp_orderScale.font = [UIFont systemFontOfSize:12];
    [rp_orderScale setTextColor:COLORFromRGB(0xe10000)];
    rp_orderScale.textAlignment = NSTextAlignmentCenter;
    [profitView addSubview:rp_orderScale];
    [rp_orderScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rp_orderNum.mas_bottom).offset(10);
        make.left.equalTo(profitView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(12);
        
    }];
    rp_moneyScale = [[UILabel alloc] init];
    rp_moneyScale.text = @"0";
    rp_moneyScale.font = [UIFont systemFontOfSize:12];
    [rp_moneyScale setTextColor:COLORFromRGB(0xe10000)];
    rp_moneyScale.textAlignment = NSTextAlignmentCenter;
    [profitView addSubview:rp_moneyScale];
    [rp_moneyScale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rp_orderScale.mas_centerY);
        make.left.equalTo(rp_orderScale.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(12);
        
    }];
    
    
    UILabel *orderLabel = [[UILabel alloc] init];
    orderLabel.text = @"今日订单";
    orderLabel.font = [UIFont systemFontOfSize:15];
    orderLabel.textAlignment = NSTextAlignmentCenter;
    [orderLabel setTextColor:COLORFromRGB(0x333333)];
    [profitView addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rp_orderScale.mas_bottom).offset(10);
        make.left.equalTo(profitView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(15);
        
    }];
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"今日收款";
    moneyLabel.font = [UIFont systemFontOfSize:15];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [moneyLabel setTextColor:COLORFromRGB(0x333333)];
    [profitView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderLabel.mas_centerY);
        make.left.equalTo(orderLabel.mas_right);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(15);
        
    }];

}
-(void)showMoreBtn{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    MoreOrderController *orderVc = [[MoreOrderController alloc] init];
    [self.navigationController pushViewController:orderVc animated:YES];
}
/**
 创建我的等级
 */
- (void)createMyView{
    

    NSArray *myViewArray = @[@"我的等级图标",@"我的邀请图标",@"通道设置"];
    NSArray *textArray = @[@"我的等级",@"我的邀请",@"通道设置"];
    
    UIButton *tempBtn = nil;
    
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(i*SC_WIDTH/3.0,25.0/SCALE_Y,SC_WIDTH/3.0,55);
        [button setImage:[UIImage imageNamed:myViewArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myView).offset(25/SCALE_Y);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right);
            }else{
                make.left.equalTo(myView);
            }
            make.width.mas_equalTo(SC_WIDTH/3.0);
            make.height.mas_equalTo(55);
        }];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = textArray[i];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.top.equalTo(button.mas_bottom).offset(5);
            make.width.mas_equalTo(button);
            make.height.mas_equalTo(16);
            
        }];
        tempBtn = button;
    }
}
-(void)buttonType:(UIButton *)btn{
    switch (btn.tag) {
        case 100:{
            MyLevelController *levelVc = [[MyLevelController alloc] init];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
            [self.navigationController pushViewController:levelVc animated:YES];
        }
            break;
        case 101:{
            MyRequestController *requestVc = [[MyRequestController alloc] init];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
            [self.navigationController pushViewController:requestVc animated:YES];
        }
            break;
        case 102:{
            ChannelSetingController*setVc = [[ChannelSetingController alloc] init];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
            [self.navigationController pushViewController:setVc animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}
/**
 创建二维码视图
 */
- (void)createCodeView{
    
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setImage:[UIImage imageNamed:@"我扫吧"] forState:UIControlStateNormal];
    [codeView addSubview:scanBtn];
    [scanBtn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView).offset(25/SCALE_Y);
        make.left.equalTo(codeView).offset(75/SCALE_X);
        make.bottom.equalTo(codeView).offset(-28/SCALE_Y);
        make.width.mas_equalTo(55/SCALE_X);

    }];
    
    UIButton *sweepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sweepBtn setImage:[UIImage imageNamed:@"扫我吧"] forState:UIControlStateNormal];
    [codeView addSubview:sweepBtn];
    [sweepBtn addTarget:self action:@selector(sweepBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sweepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView).offset(25/SCALE_Y);
        make.right.equalTo(codeView).offset(-75/SCALE_X);
        make.bottom.equalTo(codeView).offset(-28/SCALE_Y);
        make.width.mas_equalTo(55/SCALE_X);
        
    }];
    
/**
 我扫吧按钮点击事件

 */
}

- (void)scanBtnClick:(UIButton*)btn{
    
    NSString *checkedState = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_checked"];
    if ([checkedState isEqualToString:@"1"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
        ScanCodeController *scanVc = [[ScanCodeController alloc] init];
        [self.navigationController pushViewController:scanVc animated:YES];
    }else{
    
        [self rvShowAlert:@"前往－>我的－>商户认证"];
    }

}
/**
 扫我吧按钮点击事件
 
 */

- (void)sweepBtnClick:(UIButton*)btn{
    
    NSString *checkedState = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_checked"];
    if ([checkedState isEqualToString:@"1"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
        SweepMeController *scanVc = [[SweepMeController alloc] init];
        [self.navigationController pushViewController:scanVc animated:YES];
    }else{
        
        [self rvShowAlert:@"前往－>我的－>商户认证"];
    }
    
}
/**
 创建四大基础视图
 */
- (void)createBasicView{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, SC_WIDTH, 20);
    imageView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:imageView];
    
    mebInfoView = [[UIView alloc] init];
    mebInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mebInfoView];
    [mebInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(140.0/SCALE_Y);

    }];

    profitView = [[UIView alloc] init];
    profitView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:profitView];
    [profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mebInfoView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(155.0/SCALE_Y);
        
    }];

    myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myView];
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profitView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(125.0/SCALE_Y);
        
    }];

    codeView = [[UIView alloc] init];
    [self.view addSubview:myView];
    codeView.backgroundColor = COLORFromRGB(0xe10000);
    codeView.frame =CGRectMake(0, myView.frame.origin.y+myView.frame.size.height, SC_WIDTH,self.view.frame.size.height-myView.frame.origin.y-myView.frame.size.height-44);
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];

}
/**
 警示 弹出框
 */
- (void)rvShowAlert:(NSString *)warning{
    
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
