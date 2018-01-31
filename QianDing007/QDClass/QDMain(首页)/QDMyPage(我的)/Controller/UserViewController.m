//
//  UserViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UserViewController.h"
#import "CompanyController.h"
#import "PersonalController.h"
@interface UserViewController (){
    UIView      *topView;   //创建顶部选择按钮
    UIButton  *selectBtn;   //记录选中的按钮
    UILabel *selectLabel;   //选中labelOne
    UILabel *selectLabelOne;//选中labelOne
    UIView  *onePageView;   //第一页展示视图
    UIView  *twoPageView;   //第二页展示视图
    
    UILabel *lableOne;
    UILabel *lableTwo;
    UILabel *lableThree;
    UILabel *lableFour;
    UIImageView *scrollLine;//滚动线条
    
    CompanyController *companyVC;   //企业认证
    PersonalController *personalVC; //个人认证
    
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createChooseView];
    [self createSubViewController];
    [self createScrollerView];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollEnabled:) name:@"changeScrollEnabled" object:nil];

    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)changeScrollEnabled:(NSNotification *)noti{
    _scrollView.scrollEnabled = NO;
    

}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xe10000);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self ;
     _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(SC_WIDTH*2.0, 0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
    for (int i=0; i<2; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [_scrollView addSubview:vc.view];
    }
    
    NSString *type = [[shareDelegate shareNSUserDefaults] objectForKey:@"account_type"];
    
    if ([type isEqualToString:@"1"]) {
        //个人认证
        [_scrollView setContentOffset:CGPointMake(SC_WIDTH, 0) animated:YES];
        scrollLine.frame = CGRectMake(SC_WIDTH/2.0,122,SC_WIDTH/2.0, 2);
        [lableOne setTextColor:COLORFromRGB(0x999999)];
        [lableTwo setTextColor:COLORFromRGB(0x999999)];
        [lableThree setTextColor:COLORFromRGB(0xe10000)];
        [lableFour  setTextColor:COLORFromRGB(0xe10000)];
        
        
    }else if ([type isEqualToString:@"2"]){
        //商户认证
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        scrollLine.frame = CGRectMake(0,122,SC_WIDTH/2.0, 2);
        [lableOne setTextColor:COLORFromRGB(0xe10000)];
        [lableTwo setTextColor:COLORFromRGB(0xe10000)];
        [lableThree setTextColor:COLORFromRGB(0x999999)];
        [lableFour  setTextColor:COLORFromRGB(0x999999)];

 
    }else if ([type isEqualToString:@"3"]){
        //未认证
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        scrollLine.frame = CGRectMake(0,122,SC_WIDTH/2.0, 2);
        _scrollView.scrollEnabled = YES;


    }
    
}
/**
 创建子控制器
 */
- (void)createSubViewController{
    companyVC = [[CompanyController alloc] init];
    personalVC = [[PersonalController alloc] init];

    [self addChildViewController:companyVC];
    [self addChildViewController:personalVC];
}

- (void)createChooseView{

    topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
        
    }];

    UIButton *tempBtn = nil;
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = COLORFromRGB(0xffffff);
        button.tag = 300+i;
        [topView addSubview:button];
        [button addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right);
            }else{
                make.left.equalTo(self.view);
            }
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(SC_WIDTH/2.0);
            
        }];
        
        tempBtn = button;
    }
    
        lableOne = [[UILabel alloc] init];
        lableOne.text = @"企业认证";
        lableOne.textAlignment = NSTextAlignmentRight;
        [lableOne setTextColor:COLORFromRGB(0xe10000)];
        lableOne.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:lableOne];
        [lableOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.left.equalTo(self.view).offset(-5);
            make.width.mas_equalTo(SC_WIDTH/4.0);
            make.height.mas_equalTo(60);
    
        }];
    
        lableTwo = [[UILabel alloc] init];
        lableTwo.text = @"(有营业执照)";
        lableTwo.textAlignment = NSTextAlignmentLeft;
        [lableTwo setTextColor:COLORFromRGB(0xe10000)];
        lableTwo.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:lableTwo];
        [lableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.left.equalTo(lableOne.mas_right);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(SC_WIDTH/4.0);
    
        }];

    
        lableThree = [[UILabel alloc] init];
        lableThree.text = @"个人认证";
        lableThree.textAlignment = NSTextAlignmentRight;
        [lableThree setTextColor:COLORFromRGB(0x999999)];
        lableThree.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:lableThree];
        [lableThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.left.equalTo(lableTwo.mas_right).offset(-5);
            make.width.mas_equalTo(SC_WIDTH/4.0);
            make.height.mas_equalTo(60);
        
        }];
    
        lableFour = [[UILabel alloc] init];
        lableFour.text = @"(无营业执照)";
        lableFour.textAlignment = NSTextAlignmentLeft;
        [lableFour setTextColor:COLORFromRGB(0x999999)];
        lableFour.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:lableFour];
        [lableFour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64);
            make.left.equalTo(lableThree.mas_right);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(SC_WIDTH/4.0);
        
        }];
    //滚动线条
    scrollLine = [[UIImageView alloc] init];
    scrollLine.backgroundColor = COLORFromRGB(0xe10000);
    scrollLine.frame = CGRectMake(0,122,SC_WIDTH/2.0 , 2);
    [self.view addSubview:scrollLine];
    
    NSString *is_Checked = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_checked"];
    if ([is_Checked isEqualToString:@"0"]) {
        [self createShowView:@"未认证"];
    
    }else if ([is_Checked isEqualToString:@"1"]){
        [self createShowView:@"认证已通过"];

    }else if ([is_Checked isEqualToString:@"2"]){
        [self createShowView:@"认证被拒绝"];

    }
    
}
- (void)createShowView:(NSString *)str{
    
    UIView *promptBox = [[UIView alloc] init];
    
    [[UIApplication sharedApplication].keyWindow addSubview:promptBox];
    [UIView animateWithDuration:1 animations:^{
        
        promptBox.backgroundColor = [COLORFromRGB(0x000000) colorWithAlphaComponent:0.5];
        promptBox.layer.cornerRadius = 8;
        promptBox.layer.masksToBounds = YES;
        [promptBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo([UIApplication sharedApplication].keyWindow.mas_centerX);
            make.centerY.equalTo([UIApplication sharedApplication].keyWindow.mas_centerY).offset(50);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(40);
            
        }];
        UILabel*lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = str;
        [lable setTextColor:COLORFromRGB(0xffffff)];
        lable.font = [UIFont boldSystemFontOfSize:16];
        [promptBox addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(promptBox);
            make.centerY.equalTo(promptBox.mas_centerY);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(16);
            
        }];
        
    } completion:^(BOOL finished) {
        
        [promptBox removeFromSuperview];
        
    }];

}
/**
  选择框导航栏
 */
- (void)changeClick:(UIButton*)btn{
    
    NSString *type = [[shareDelegate shareNSUserDefaults] objectForKey:@"account_type"];

    //未认证情况下可以点击出现效果

    if ([type isEqualToString:@"3"]){
        
        switch (btn.tag) {
            case 300:{
                [lableOne setTextColor:COLORFromRGB(0xe10000)];
                [lableTwo setTextColor:COLORFromRGB(0xe10000)];
                [lableThree setTextColor:COLORFromRGB(0x999999)];
                [lableFour  setTextColor:COLORFromRGB(0x999999)];
                _scrollView.contentOffset = CGPointMake(0, 0);
                [UIView animateWithDuration:0.3 animations:^{
                    scrollLine.frame = CGRectMake(0,122,SC_WIDTH/2.0, 2);
                }];
            }
                break;
            case 301:{
                [lableThree setTextColor:COLORFromRGB(0xe10000)];
                [lableFour  setTextColor:COLORFromRGB(0xe10000)];
                [lableOne setTextColor:COLORFromRGB(0x999999)];
                [lableTwo setTextColor:COLORFromRGB(0x999999)];
                _scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
                [UIView animateWithDuration:0.3 animations:^{
                    scrollLine.frame = CGRectMake(SC_WIDTH/2.0,122,SC_WIDTH/2.0, 2);
                }];
            }
                break;
            default:
                break;
        }

    }else if([type isEqualToString:@"2"]){
    
        if (btn.tag == 301) {
            [self uvShowAlert:@"您已提交商户认证，请勿重复提交个人认证"];

        }

    }else if([type isEqualToString:@"1"]){
        
        if (btn.tag == 300) {
            [self uvShowAlert:@"您已提交个人认证，请勿重复提交商户认证"];
            
        }
        
    }
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"商家认证";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    [leftButton setImage:[UIImage imageNamed:@"返回图标白色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

}
/**
 导航栏左侧按钮点击事件
 */
- (void)leftBackClick{
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma ********************UIScrollViewDelegate**************
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSString *type = [[shareDelegate shareNSUserDefaults] objectForKey:@"account_type"];
    
    //未认证情况下可以点击出现效果
    if ([type isEqualToString:@"3"]){
        int x = scrollView.contentOffset.x/SC_WIDTH;
        //滚动线条处理
        if (x == 0) {
            [lableOne setTextColor:COLORFromRGB(0xe10000)];
            [lableTwo setTextColor:COLORFromRGB(0xe10000)];
            [lableThree setTextColor:COLORFromRGB(0x999999)];
            [lableFour  setTextColor:COLORFromRGB(0x999999)];
            [UIView animateWithDuration:0.3 animations:^{
                scrollLine.frame = CGRectMake(0,122,SC_WIDTH/2.0, 2);
            }];
            
        }else if (x == 1){
            [lableThree setTextColor:COLORFromRGB(0xe10000)];
            [lableFour  setTextColor:COLORFromRGB(0xe10000)];
            [lableOne setTextColor:COLORFromRGB(0x999999)];
            [lableTwo setTextColor:COLORFromRGB(0x999999)];
            [UIView animateWithDuration:0.3 animations:^{
                scrollLine.frame = CGRectMake(SC_WIDTH/2.0,122,SC_WIDTH/2.0, 2);
            }];
            
        }
        
        [_scrollView setContentOffset:CGPointMake(x*SC_WIDTH, 0) animated:YES];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 弹出框
 */
- (void)uvShowAlert:(NSString *)warning{
    
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
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated ];

    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:@"changeScrollEnabled"  object:nil];

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
