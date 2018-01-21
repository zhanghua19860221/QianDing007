//
//  ProfitController.m
//  QianDing007
//
//  Created by 张华 on 17/12/21.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ProfitController.h"
#import "GetProfitController.h"
#import "UpProfitController.h"
@interface ProfitController (){
    UIView *topView;//创建头视图
    UIButton *selectBtn;//记录选中按钮
    UIImageView *imageLine;//滚动红色线条
    GetProfitController *getProfitVC;//收款分润视图
    UpProfitController *upProfitVC;//升级分润视图
    UILabel *pc_nowLabel;  //今日分润
    UILabel *pc_totalLabel;//总分润


}

@end

@implementation ProfitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pcGetUrlDataSource];
    [self createTopView];
    [self createSubViewController];
    [self createScrollerView];

    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}
- (void)pcGetUrlDataSource{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *pcDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:PROFIT_URL parameters:pcDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//       NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"]  isEqualToString:@"1"]) {
            pc_nowLabel.text = responseObject[@"now_distribute"];
            pc_totalLabel.text = responseObject[@"total_distribute"];
        }else{
        
            [self pcShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        
    }];
    
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self ;
    //    _scrollView.scrollEnabled = NO;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(SC_WIDTH*2.0, 0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageLine.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
    for (int i=0; i<2; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [_scrollView addSubview:vc.view];
    }
}
- (void)createTopView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, SC_WIDTH, 20);
    imageView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:imageView];
    
    topView= [[UIView alloc] init];
    topView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(120/SCALE_Y);
        
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(11);
        make.left.equalTo(topView).offset(15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"分润明细";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView);
        make.centerX.equalTo(topView.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    pc_nowLabel = [[UILabel alloc] init];
    pc_nowLabel.text = @"";
    pc_nowLabel.font = [UIFont systemFontOfSize:22];
    pc_nowLabel.textAlignment = NSTextAlignmentCenter;
    [pc_nowLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:pc_nowLabel];
    
    UILabel *nowName = [[UILabel alloc] init];
    nowName.text = @"今日分润";
    nowName.font = [UIFont systemFontOfSize:14];
    nowName.textAlignment = NSTextAlignmentCenter;
    [nowName setTextColor:COLORFromRGB(0xebebeb)];
    [topView addSubview:nowName];
    
    pc_totalLabel= [[UILabel alloc] init];
    pc_totalLabel.text = @"";
    pc_totalLabel.font = [UIFont systemFontOfSize:22];
    pc_totalLabel.textAlignment = NSTextAlignmentCenter;
    [pc_totalLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:pc_totalLabel];
    
    UILabel *allName = [[UILabel alloc] init];
    allName.text = @"总分润";
    allName.font = [UIFont systemFontOfSize:14];
    allName.textAlignment = NSTextAlignmentCenter;
    [allName setTextColor:COLORFromRGB(0xebebeb)];
    [topView addSubview:allName];
    
    [pc_nowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH/2.0);
        make.height.mas_equalTo(22);

    }];
    [nowName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pc_nowLabel.mas_bottom).offset(10);
        make.centerX.equalTo(pc_nowLabel.mas_centerX);
        make.width.mas_equalTo(pc_nowLabel.mas_width);
        make.height.mas_equalTo(14);
        
        
    }];
    [pc_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backBtn.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(pc_nowLabel.mas_right);
        make.width.mas_equalTo(pc_nowLabel.mas_width);
        make.height.mas_equalTo(22);
        
    }];
    [allName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pc_totalLabel.mas_bottom).offset(10);
        make.centerX.equalTo(pc_totalLabel.mas_centerX);
        make.width.mas_equalTo(pc_totalLabel.mas_width);
        make.height.mas_equalTo(14);
    
    }];
    
    UIButton *tempBtn = nil;
    NSArray *textBtnArray = @[@"收款分润",@"升级分润"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = COLORFromRGB(0xffffff);
        [button setTitle:textBtnArray[i] forState:UIControlStateNormal];
        [button setTitleColor:COLORFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateSelected];
        button.tag = 230+i;
        [button addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if (i == 0) {
            button.selected = YES;
            selectBtn = button;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right);
            }else{
                make.left.equalTo(self.view);
            }
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(SC_WIDTH/2.0);
        }];
        tempBtn = button;
    }
    imageLine = [[UIImageView alloc] init];
    imageLine.backgroundColor = COLORFromRGB(0xe10000);
    imageLine.frame = CGRectMake(0,120/SCALE_Y+70,SC_WIDTH/2.0 , 2);
    [self.view addSubview:imageLine];

    
}
-(void)changeView:(UIButton*)btn{
    if (selectBtn!=btn) {
        selectBtn.selected=NO;
        btn.selected=YES;
        selectBtn=btn;
    }
    switch (btn.tag) {
        case 230:{
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(0,120/SCALE_Y+70,SC_WIDTH/2.0, 2);
            }];
    
            _scrollView.contentOffset = CGPointMake(0, 0);

        }
            break;
        case 231:{
        
            [UIView animateWithDuration:0.3 animations:^{
                imageLine.frame = CGRectMake(SC_WIDTH/2.0,120/SCALE_Y+70,SC_WIDTH/2.0, 2);
            }];
            _scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);

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
    getProfitVC = [[GetProfitController alloc] init];
    upProfitVC = [[UpProfitController alloc] init];
    
    [self addChildViewController:getProfitVC];
    [self addChildViewController:upProfitVC];
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];
}
#pragma ********************UIScrollViewDelegate**************
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x/SC_WIDTH;
    UIButton *tempButton = (UIButton *)[self.view viewWithTag:230+x];
    if (selectBtn != tempButton) {
        selectBtn.selected = NO;
        tempButton.selected = YES;
        selectBtn = tempButton;
    }
    [UIView animateWithDuration:0.3 animations:^{
        imageLine.frame = CGRectMake(x*SC_WIDTH/2.0,120/SCALE_Y+70,SC_WIDTH/2.0, 2);
    }];
    
    
    //    [_scrollView setContentOffset:CGPointMake(0, 500) animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
/**
 警示 弹出框
 */
- (void)pcShowAlert:(NSString *)warning{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
