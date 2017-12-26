//
//  ReceivablesPage.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ReceivablesPage.h"
#import "CustomShowDataView.h"
#import "MoreOrderController.h"
#import "ChannelSetingController.h"
#import "MyLevelController.h"
#import "MyRequestController.h"
@interface ReceivablesPage (){
    
    UIView *mebInfoView;//会员信息展示视图
    UIView *profitView;//商家收益视图
    UIView *myView;//我的等级视图
    UIView *codeView;//二维码扫描视图

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

    
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self createMebInfoView];
    [self createProfitView];
    [self createMyView];
    [self createCodeView];
    
}
/**
 会员信息视图
 */
- (void)createMebInfoView{
    UILabel *telePhone = [[UILabel alloc] init];
    telePhone.text = @"您好！13466358453";
    telePhone.frame = CGRectMake(15, 15, 160, 16);
    [telePhone setTextColor:COLORFromRGB(0x333333)];
    telePhone.font = [UIFont systemFontOfSize:16];
    [mebInfoView addSubview:telePhone];
    
    UIButton *verificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verificationBtn.frame = CGRectMake(telePhone.frame.origin.x+telePhone.frame.size.width+10, 10,56, 23);
    [verificationBtn setImage:[UIImage imageNamed:@"未认证"] forState:UIControlStateNormal];
    [mebInfoView addSubview:verificationBtn];
    
    UILabel *mebLeveLabel = [[UILabel alloc] init];
    mebLeveLabel.text = @"普通会员";
    mebLeveLabel.font = [UIFont systemFontOfSize:16];
    mebLeveLabel.frame = CGRectMake(55/SCALE_X,telePhone.frame.origin.y+telePhone.frame.size.height+30/SCALE_Y,70, 16);
    [telePhone setTextColor:COLORFromRGB(0x333333)];
    [mebInfoView addSubview:mebLeveLabel];
    
    
    UIImageView *mebIconView = [[UIImageView alloc] init];
    [mebIconView setImage:[UIImage imageNamed:@"普通会员132*132"]];
    mebIconView.frame = CGRectMake(mebLeveLabel.frame.origin.x+mebLeveLabel.frame.size.width+10,mebLeveLabel.frame.origin.y-3, 22, 22);
    [mebInfoView addSubview:mebIconView];
    
    UILabel *mebRateLabel = [[UILabel alloc] init];
    mebRateLabel.text = @"费        率";
    [telePhone setTextColor:COLORFromRGB(0x333333)];
    mebRateLabel.font = [UIFont systemFontOfSize:16];
    mebRateLabel.frame = CGRectMake(55/SCALE_X,mebInfoView.frame.size.height-20/SCALE_Y-16,70, 16);
    [mebInfoView addSubview:mebRateLabel];

    
    UILabel *percentBtn = [[UILabel alloc] init];
    percentBtn.text = @"0.4%";
    percentBtn.font = [UIFont systemFontOfSize:21];
    percentBtn.frame = CGRectMake(mebRateLabel.frame.origin.x+mebRateLabel.frame.size.width+10,mebInfoView.frame.size.height-20/SCALE_Y-21,50, 21);
    [mebInfoView addSubview:percentBtn];
    
    UIImageView *upGradeView = [[UIImageView alloc] init];
    [upGradeView setImage:[UIImage imageNamed:@"去升级图标"]];
    upGradeView.frame = CGRectMake(SC_WIDTH-95/SCALE_X,mebInfoView.frame.size.height-20/SCALE_Y-16-43, 25, 38);
    [mebInfoView addSubview:upGradeView];

    UILabel *upGradeLabel = [[UILabel alloc] init];
    upGradeLabel.font = [UIFont systemFontOfSize:16];
    upGradeLabel.text = @"去升级";
    upGradeLabel.frame = CGRectMake(mebInfoView.frame.size.width-55/SCALE_X-50,mebInfoView.frame.size.height-20/SCALE_Y-16,50, 16);
    [mebInfoView addSubview:upGradeLabel];
  
}
/**
 创建商户收益视图
 */
- (void)createProfitView{
    
    profitView.userInteractionEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(15, 15, 116, 20);
    [imageView setImage:[UIImage imageNamed:@"商家收益"]];
    [profitView addSubview:imageView];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"更多..." forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreBtn setTitleColor:COLORFromRGB(0x999999) forState:UIControlStateNormal];
    moreBtn.frame = CGRectMake(SC_WIDTH-70, 18,60, 17);
    moreBtn.userInteractionEnabled = YES;
    [moreBtn addTarget:self action:@selector(showMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [profitView addSubview:moreBtn];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(0, 50, SC_WIDTH, 1);
    lineView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [profitView addSubview:lineView];
    
    NSArray *firstArray = @[@"25",@"353.23"];
    NSArray *secondArray = @[@"环比－25%",@"环比+155%"];
    NSArray *thirdArray = @[@"今日订单",@"今日收款"];

    for (int i = 0; i<2; i++) {
        
        CustomShowDataView *showView = [[CustomShowDataView alloc] initNumber:firstArray[i] ratioMoney:secondArray[i] nameType:thirdArray[i]];
        showView.frame = CGRectMake(i*SC_WIDTH/2.0,lineView.frame.origin.y+1,SC_WIDTH/2.0, 52/SCALE_Y);
        [profitView addSubview:showView];
        
    }
    
    
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
    

    NSArray *myViewArray = @[@"我的等级图标",@"我的邀请图标",@"通道设置图标"];
    NSArray *textArray = @[@"我的等级",@"我的邀请",@"通道设置"];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(i*SC_WIDTH/3.0,25.0/SCALE_Y,SC_WIDTH/3.0,55);
        [button setImage:[UIImage imageNamed:myViewArray[i]] forState:UIControlStateNormal];
        [myView addSubview:button];
        [button addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = textArray[i];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.frame = CGRectMake(i*SC_WIDTH/3.0,myView.frame.size.height-20/SCALE_Y-16,SC_WIDTH/3.0, 16);
        textLabel.textAlignment = NSTextAlignmentCenter;
        [myView addSubview:textLabel];
        
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
    
    NSArray *codeArray = @[@"我扫吧",@"扫我吧"];
    for (int i=0; i<codeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(i*SC_WIDTH/2.0, 0,SC_WIDTH/2.0,codeView.frame.size.height);
        [button setImage:[UIImage imageNamed:codeArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [codeView addSubview:button];
    }
}
/**
 创建四大基础视图
 */
- (void)createBasicView{
    
    mebInfoView = [[UIView alloc] init];
    mebInfoView.frame =CGRectMake(0, 20, SC_WIDTH, 140.0/SCALE_Y);
    mebInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mebInfoView];

    profitView = [[UIView alloc] init];
    profitView.backgroundColor = [UIColor whiteColor];
    profitView.frame =CGRectMake(0,mebInfoView.frame.origin.y+mebInfoView.frame.size.height+20,SC_WIDTH,155.0/SCALE_Y);
    [self.view addSubview:profitView];

    myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor whiteColor];
    myView.frame =CGRectMake(0, profitView.frame.origin.y+profitView.frame.size.height+20, SC_WIDTH,125.0/SCALE_Y);
    [self.view addSubview:myView];

    codeView = [[UIView alloc] init];
    [self.view addSubview:myView];
    codeView.backgroundColor = [UIColor whiteColor];
    codeView.frame =CGRectMake(0, myView.frame.origin.y+myView.frame.size.height, SC_WIDTH,self.view.frame.size.height-myView.frame.origin.y-myView.frame.size.height-44);
    [self.view addSubview:codeView];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

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
