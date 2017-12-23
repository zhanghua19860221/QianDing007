//
//  MyRequestController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyRequestController.h"
#import "MyRequestModel.h"
#import "CustomRequestView.h"
@interface MyRequestController (){

    NSMutableArray *dataArray;//数据数组
    UIView *requestView;      //商户邀请记录
    UIScrollView *scrollview; //视图滚动展示
    UIView *requestIconView;  //我要邀请视图
    UIView *maskView;         //蒙板视图
}

@end

@implementation MyRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self getDataSource];
    [self createStatistics];
    [self createMainView];
    [self createMaskView];
    [self createRequestView];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)getDataSource{

    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 0 ; i <5; i++) {
        
        MyRequestModel *model = [[MyRequestModel alloc] init];
        model.userName = @"姓名：张三";
        model.userTelePhone = @"手机号：1889998899";
        model.merchantName = @"商户名称：北京南站";
        model.address = @"地址：北京丰台";
        model.activationTime = @"激活时间：2017-11-11";
        model.receivables = @"收款：234";
        model.list = @"订单：432";
        [dataArray addObject:model];
        
    }

}
- (void)createMainView{
    
    
    scrollview  = [[UIScrollView alloc] init];
    scrollview.contentSize = CGSizeMake(0,210*dataArray.count);
    [self.view addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(requestView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(SC_HEIGHT-170/SCALE_Y);

    }];

    CustomRequestView *oldView = nil;
    for (int i = 0; i<5; i++) {
        CustomRequestView *view = [[CustomRequestView alloc] initView:dataArray[i]];
        
        view.backgroundColor = COLORFromRGB(0xffffff);
        view.layer.cornerRadius = 3;
        view.layer.shadowOffset =  CGSizeMake(0, 0);
        view.layer.shadowRadius = 3;
        view.layer.shadowOpacity = 1;
        view.layer.shadowColor = COLORFromRGB(0xe10000).CGColor;
        
        [scrollview addSubview:view];
    
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (oldView) {
                make.top.equalTo(oldView.mas_bottom).offset(10);
            }else{
                make.top.equalTo(scrollview).offset(5);
            }
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.height.mas_equalTo(190);
        }];
        oldView = view;
    }
    
}
/**
 顶部统计视图
 */
- (void)createStatistics{
    
    requestView = [[UIView alloc] init];
    requestView.backgroundColor = COLORFromRGB(0xffffff);
    requestView.layer.cornerRadius = 3;
    requestView.layer.shadowOffset =  CGSizeMake(0, 0);
    requestView.layer.shadowRadius = 3;
    requestView.layer.shadowOpacity = 1;
    requestView.layer.shadowColor = COLORFromRGB(0xe10000).CGColor;
    
    [self.view addSubview:requestView];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.font = [UIFont systemFontOfSize:18];
    numLabel.text = @"234";
    [numLabel setTextColor:COLORFromRGB(0xe10000)];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [requestView addSubview:numLabel];

    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.text = @"已成功邀请商家";
    textLabel.textAlignment = NSTextAlignmentCenter;
    [requestView addSubview:textLabel];

    
    [requestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80/SCALE_Y);
        make.left.equalTo(self.view).offset(15/SCALE_X);
        make.width.mas_equalTo(135/SCALE_X);
        make.height.mas_equalTo(81/SCALE_Y);

    }];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(requestView).offset(25/SCALE_Y);
        make.centerX.equalTo(requestView.mas_centerX);
        make.width.equalTo(requestView.mas_width);
        make.height.mas_equalTo(18);
        
    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLabel.mas_bottom).offset(10);
        make.centerX.equalTo(requestView.mas_centerX);
        make.width.equalTo(requestView.mas_width);
        make.height.mas_equalTo(14);
        
    }];
    
    UIView *codeView = [[UIView alloc] init];
    codeView.backgroundColor = COLORFromRGB(0xffffff);
    codeView.layer.cornerRadius = 3;
    codeView.layer.shadowOffset =  CGSizeMake(0, 0);
    codeView.layer.shadowRadius = 3;
    codeView.layer.shadowOpacity = 1;
    codeView.layer.shadowColor = COLORFromRGB(0xe10000).CGColor;
    
    [self.view addSubview:codeView];
    
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(requestView.mas_centerY);
        make.left.equalTo(requestView.mas_right).offset(10/SCALE_X);
        make.right.equalTo(self.view).offset(-15/SCALE_X);
        make.height.equalTo(requestView.mas_height);
        
    }];

    UILabel *telephoneLabel = [[UILabel alloc] init];
    telephoneLabel.font = [UIFont systemFontOfSize:18];
    telephoneLabel.text = @"18241499999";
    [telephoneLabel setTextColor:COLORFromRGB(0xe10000)];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    [codeView addSubview:telephoneLabel];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.font = [UIFont systemFontOfSize:14];
    codeLabel.text = @"邀请码";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [codeView addSubview:codeLabel];
    
    UIImageView *leftLine = [[UIImageView alloc] init];
    leftLine.backgroundColor = COLORFromRGB(0xf9f9f9);
    [codeView addSubview:leftLine];
    
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [copyBtn setTitleColor:COLORFromRGB(0x999999) forState:UIControlStateNormal];
    [codeView addSubview:copyBtn];
    
    UIImageView *bottomLine = [[UIImageView alloc] init];
    bottomLine.backgroundColor = COLORFromRGB(0x999999);
    [codeView addSubview:bottomLine];
    
    [telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView).offset(25/SCALE_Y);
        make.left.equalTo(codeView).offset(10/SCALE_X);
        make.width.mas_equalTo(140/SCALE_X);
        make.height.mas_equalTo(18);
        
    }];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telephoneLabel.mas_bottom).offset(10);
        make.centerX.equalTo(telephoneLabel.mas_centerX);
        make.width.equalTo(telephoneLabel.mas_width);
        make.height.mas_equalTo(14);
        
    }];
    

    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeView.mas_centerY);
        make.right.equalTo(codeView).offset(-10/SCALE_X);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
        
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(copyBtn.mas_bottom).offset(3) ;
        make.right.equalTo(copyBtn);
        make.width.mas_equalTo(copyBtn);
        make.height.mas_equalTo(2);
        
    }];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView).offset(15) ;
        make.right.equalTo(copyBtn.mas_left).offset(-5);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(codeView).offset(-15) ;

    }];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setStatusBarBackgroundColor:COLORFromRGB(0xe10000)];

}
- (void)createTopView{
    
    UIImageView *topView = [[UIImageView alloc] init];
    [self.view addSubview:topView];
    topView.backgroundColor = COLORFromRGB(0xe10000);
    topView.userInteractionEnabled = YES;

    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [topView addSubview:leftbutton];
    [leftbutton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"邀请";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:titleLabel];
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setTitle:@"我要邀请" forState:UIControlStateNormal];
    rightbutton.titleLabel.textAlignment =  NSTextAlignmentRight;
    [rightbutton setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [topView addSubview:rightbutton];
    [rightbutton addTarget:self action:@selector(rightBackClick) forControlEvents:UIControlEventTouchUpInside];
    

    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(110/SCALE_Y);
        
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(topView).offset(26/SCALE_Y);
        make.height.mas_equalTo(18/SCALE_Y);
        make.width.mas_equalTo(44);
    }];
    
    
    [leftbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(topView).offset(15);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);

    }];
    
    [rightbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.right.equalTo(topView).offset(-10);
        make.height.mas_equalTo(14/SCALE_Y);
        make.width.mas_equalTo(100);

    }];
    
}

/**
 创建邀请视图
 */
- (void)createRequestView{
    
    requestIconView = [[UIView alloc] init];
    requestIconView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:requestIconView];
    
    UILabel *typeLable = [[UILabel alloc] init];
    typeLable.text = @"邀请方式:";
    typeLable.textAlignment = NSTextAlignmentLeft;
    typeLable.font = [UIFont systemFontOfSize:18];
    [typeLable setTextColor:COLORFromRGB(0x333333)];
    [requestIconView addSubview:typeLable];
    
    [requestIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(190/SCALE_Y);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(190/SCALE_Y);
        
    }];
    
    [typeLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(requestIconView).offset(25/SCALE_Y);
        make.left.equalTo(requestIconView).offset(15);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(100);

    }];
   
    UIView *iconBJView = [[UIView alloc] init];
    iconBJView.backgroundColor = COLORFromRGB(0xffffff);
    [requestIconView addSubview:iconBJView];
    [iconBJView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(requestIconView);
        make.left.equalTo(requestIconView).offset(50/SCALE_X);
        make.right.equalTo(requestIconView).offset(-50/SCALE_X);
        make.height.mas_equalTo(95/SCALE_Y);
        
    }];
    
    NSArray *loginViewArray = @[@"微信@2x",@"QQ",@"通讯录"];
    NSArray *loginLabelArrya = @[@"微信邀请",@"QQ邀请",@"通讯录邀请"];
    UIButton *tempBtn = nil;
    UILabel  *tempLabel = nil;
    for (int i = 0; i<3 ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:loginViewArray[i]] forState:UIControlStateNormal];
        button.tag = 180+i;
        [iconBJView addSubview:button];
        [button addTarget:self action:@selector(requestViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = loginLabelArrya[i];
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
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBJView).offset(15);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right).offset(46/SCALE_X);
            }else{
                
                make.left.equalTo(iconBJView);
            }
            make.width.height.mas_equalTo(60/SCALE_Y);
            
        }];
        tempBtn = button;
    }
    
}
-(void)createMaskView{

    maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5 ;
    maskView.hidden = YES;
    [self.view addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];

    [maskView addGestureRecognizer:tapGesturRecognizer];

}

/**

 蒙板点击事件
 */
-(void)tapAction:(id)tap{
    
    [requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(190/SCALE_Y);
    }];
    //更新约束

    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        maskView.hidden = YES;
    }];
    
}

/**
 邀请对应类型按钮点击事件
 */
- (void)requestViewClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 180:
            
            break;
        case 181:
            
            break;
        case 182:
            
            break;
            
        default:
            break;
    }

}
/**
 导航栏左侧返回按钮
 */
- (void)leftBackClick{
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self setStatusBarBackgroundColor:COLORFromRGB(0xffffff)];
    [self.navigationController popViewControllerAnimated:YES];

}

/**
 导航栏右侧按钮
 */
- (void)rightBackClick{

    maskView.hidden = NO;
    
    //修改下边距约束
    [requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    //更新约束
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
   
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
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
