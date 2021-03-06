//
//  UserListController.m
//  QianDing007
//
//  Created by 张华 on 17/12/23.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UserListController.h"
#import "AllMerchantController.h"
#import "ComMerchantController.h"
#import "SilverMerchantController.h"
#import "GoldMerchantController.h"
#import "DiamondsMerchantController.h"



@interface UserListController (){
    UIView *tabbarView;//头部选择视图
    UIImageView *imageLine;//滚动红色线条
    AllMerchantController *allLevel;
    ComMerchantController *commonLevel;
    SilverMerchantController *silverLevel;
    GoldMerchantController *goldLevel;
    DiamondsMerchantController *diamondLevel;
    
}
@end
@implementation UserListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createNavgation];
    [self createSubViewController];
    [self createTabbar];
    [self createScrollerView];
    
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)createTabbar{
    tabbarView = [[UIView alloc] init];
    tabbarView .backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:tabbarView];
    [tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (SC_HEIGHT == 812) {
            make.top.mas_equalTo(84);

        }else{
            make.top.mas_equalTo(64);

        }
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
        
    }];
    UIButton *tempBtn = nil;
    NSArray *textBtnArray = @[@"全部商户",@"普通商户",@"银牌商户",@"金牌商户",@"钻石商户"];
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = COLORFromRGB(0xffffff);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:textBtnArray[i] forState:UIControlStateNormal];
        [button setTitleColor:COLORFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateSelected];
        button.tag = 260+i;
        [button addTarget:self action:@selector(changeSubView:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _selectUserButton = button;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tabbarView);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right);
            }else{
                make.left.equalTo(tabbarView);
            }
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(SC_WIDTH/5.0);
        }];
        tempBtn = button;
    }
    imageLine = [[UIImageView alloc] init];
    imageLine.backgroundColor = COLORFromRGB(0xe10000);
    imageLine.frame = CGRectMake(0,48,SC_WIDTH/5.0 , 2);
    [tabbarView addSubview:imageLine];

}
- (void)changeSubView:(UIButton*)btn{
    if (_selectUserButton!=btn) {
        _selectUserButton.selected=NO;
        btn.selected=YES;
        _selectUserButton=btn;
    }
    switch (btn.tag) {
            
        case 260:{
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(0,48,SC_WIDTH/5.0, 2);
            }];
            _scrollView.contentOffset = CGPointMake(0, 0);
        }
            break;
        case 261:{
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(SC_WIDTH/5.0,48,SC_WIDTH/5.0, 2);
            }];
            
            _scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
        }
            
            break;
        case 262:{
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(SC_WIDTH/5.0*2,48,SC_WIDTH/5.0, 2);
            }];
            
            _scrollView.contentOffset = CGPointMake(SC_WIDTH*2, 0);
        }
            
            break;
        case 263:{
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(SC_WIDTH/5.0*3,48,SC_WIDTH/5.0, 2);
            }];
            
            _scrollView.contentOffset = CGPointMake(SC_WIDTH*3, 0);
        }
            
            break;
        case 264:{
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(SC_WIDTH/5.0*4,48,SC_WIDTH/5.0, 2);
            }];
            
            _scrollView.contentOffset = CGPointMake(SC_WIDTH*4, 0);
        }
            
            break;
        default:
            break;
    }
}
/**
 创建子控制器
 */
- (void)createSubViewController{
    
    allLevel = [[AllMerchantController alloc] init];
    
    commonLevel = [[ComMerchantController alloc] init];
    
    silverLevel = [[SilverMerchantController alloc] init];
    
    goldLevel = [[GoldMerchantController alloc] init];
    
    diamondLevel = [[DiamondsMerchantController alloc] init];

    [self addChildViewController:allLevel];
    [self addChildViewController:commonLevel];
    [self addChildViewController:silverLevel];
    [self addChildViewController:goldLevel];
    [self addChildViewController:diamondLevel];

}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self ;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.contentSize = CGSizeMake(SC_WIDTH*5, 0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabbarView.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(SC_HEIGHT-124);
        
    }];
    
    for (int i=0; i<5; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT-124);
        [_scrollView addSubview:vc.view];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xe10000);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];
    //修改状态栏颜色 为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"商户列表";
    CUSTOMBACKCONCTORLLER(leftBackClick,self,self.view,@"返回图标白色",12,20)

}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma ********************UIScrollViewDelegate**************
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x/SC_WIDTH;
    UIButton *tempButton = (UIButton *)[self.view viewWithTag:230+x];
    if (_selectUserButton != tempButton) {
        _selectUserButton.selected = NO;
        tempButton.selected = YES;
        _selectUserButton = tempButton;
    }
    [UIView animateWithDuration:0.3 animations:^{
        imageLine.frame = CGRectMake(x*SC_WIDTH/5.0,48,SC_WIDTH/5.0, 2);
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //修改状态栏颜色 为黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

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
