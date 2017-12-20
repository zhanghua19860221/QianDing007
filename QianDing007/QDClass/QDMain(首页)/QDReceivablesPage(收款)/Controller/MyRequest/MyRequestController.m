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
    UIView *requestView;//商户邀请记录
}

@end

@implementation MyRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self createStatistics];
    [self createMainView];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)createMainView{
//    @property (strong , nonatomic) NSString *userName;      //用户姓名
//    @property (strong , nonatomic) NSString *userTelePhone; //手机号
//    @property (strong , nonatomic) NSString *merchantName;  //商户名称
//    @property (strong , nonatomic) NSString *address;       //地址
//    @property (strong , nonatomic) NSString *activationTime;//激活时间
//    @property (strong , nonatomic) NSString *receivables;   //收款
//    @property (strong , nonatomic) NSString *list;          //订单
    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 0 ; i <2; i++) {
      
        MyRequestModel *model = [[MyRequestModel alloc] init];
        model.userName = @"张三";
        model.userTelePhone = @"1889998899";
        model.merchantName = @"北京南站";
        model.address = @"北京丰台";
        model.activationTime = @"2017-11-11";
        model.receivables = @"234";
        model.list = @"432";
        [dataArray addObject:model];
    }
    CustomRequestView *oldView = nil;
    for (int i = 0; i<2; i++) {
        CustomRequestView *view = [[CustomRequestView alloc] initView:dataArray[i]];
        view.layer.borderColor = [COLORFromRGB(0xe10000) CGColor];
        view.layer.borderWidth =1;
        view.layer.masksToBounds = YES ;
        view.layer.cornerRadius = 5 ;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (oldView) {
                make.top.equalTo(oldView.mas_bottom).offset(10);
            }else{
                make.top.equalTo(requestView.mas_bottom).offset(5);
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
    requestView.layer.borderColor = [COLORFromRGB(0xe10000) CGColor];
    requestView.layer.borderWidth = 1 ;
    requestView.layer.masksToBounds = YES;
    requestView.layer.cornerRadius = 5;
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
        make.left.equalTo(self.view).offset(15);
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
    codeView.layer.borderColor = [COLORFromRGB(0xe10000) CGColor];
    codeView.layer.borderWidth = 1 ;
    codeView.layer.masksToBounds = YES;
    codeView.layer.cornerRadius = 5;
    [self.view addSubview:codeView];
    
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(requestView.mas_centerY);
        make.left.equalTo(requestView.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(requestView.mas_height);
        
    }];
    
    
    
    UILabel *telephoneLabel = [[UILabel alloc] init];
    telephoneLabel.font = [UIFont systemFontOfSize:18];
    telephoneLabel.text = @"18999999999";
    [telephoneLabel setTextColor:COLORFromRGB(0xe10000)];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    [codeView addSubview:telephoneLabel];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.font = [UIFont systemFontOfSize:14];
    codeLabel.text = @"邀请码";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [codeView addSubview:codeLabel];
    
    [telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView).offset(25/SCALE_Y);
        make.left.equalTo(codeView).offset(10);
        make.width.mas_equalTo(135/SCALE_X);
        make.height.mas_equalTo(18);
        
    }];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telephoneLabel.mas_bottom).offset(10);
        make.centerX.equalTo(telephoneLabel.mas_centerX);
        make.width.equalTo(telephoneLabel.mas_width);
        make.height.mas_equalTo(14);
        
    }];
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [copyBtn setTitleColor:COLORFromRGB(0x999999) forState:UIControlStateNormal];
    [codeView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeView.mas_centerY);
        make.right.equalTo(codeView).offset(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
        
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
