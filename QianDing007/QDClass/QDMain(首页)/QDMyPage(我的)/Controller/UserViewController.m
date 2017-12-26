//
//  UserViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController (){
    
    UIView *topView;    //创建顶部选择按钮
    UIButton *selectBtn;//记录选中的按钮
    UIView *onePageView;//第一页展示视图
    UIView *twoPageView;//第二页展示视图
    
    UITextField *companyNameField;//企业名称
    UITextField *creditField;     //信用代码
    UITextField *addressField;    //详细地址
    UITextField *userNameField;   //姓名
    UITextField *cardedField;     //身份证号
    UITextField *telePhoneField;  //联系电话

    
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createChooseView];
    [self createScrollerView];
    [self createOneView];
    [self createTwoView];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xffffff);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    
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
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
}

- (void)createOneView{
    onePageView = [[UIView alloc] init];
    onePageView.backgroundColor = COLORFromRGB(0xffffff);
    [_scrollView addSubview:onePageView];
    [onePageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView);
        make.left.equalTo(_scrollView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(SC_HEIGHT);
        
    }];

}
- (void)createTwoView{
    twoPageView = [[UIView alloc] init];
    twoPageView.backgroundColor = COLORFromRGB(0x333333);
    [_scrollView addSubview:twoPageView];
    [twoPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView);
        make.left.equalTo(onePageView.mas_right);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(SC_HEIGHT);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);

    }];
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    UIImageView *lineTwo = [[UIImageView alloc] init];
    lineTwo.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    UIImageView *lineThird = [[UIImageView alloc] init];
    lineThird.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:lineThird];
    [lineThird mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwo.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    UIImageView *lineFour = [[UIImageView alloc] init];
    lineFour.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:lineFour];
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineThird.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    UIImageView *lineFive = [[UIImageView alloc] init];
    lineFive.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:lineFive];
    [lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFour.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    UIImageView *lineSix = [[UIImageView alloc] init];
    lineSix.backgroundColor = COLORFromRGB(0xf9f9f9);
    [twoPageView addSubview:lineSix];
    [lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineFive.mas_bottom).offset(50);
        make.left.equalTo(topView);
        make.width.mas_equalTo(SC_WIDTH);
        make.height.mas_equalTo(1);
        
    }];
    
    
    
}
- (void)createChooseView{

    topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60/SCALE_Y);
        
    }];

    NSArray *oneArray = @[@"企业认证",@"个人认证"];
    NSArray *twoArray = @[@"(有营业执照)",@"(无营业执照)"];
    
    UIButton *tempBtn = nil;
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = COLORFromRGB(0xebebeb);
        button.tag = 300+i;
        [topView addSubview:button];
        [button addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            button.backgroundColor = COLORFromRGB(0xe10000);
            selectBtn = button;
        }
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
        
        UILabel *lableOne = [[UILabel alloc] init];
        lableOne.text = oneArray[i];
        lableOne.textAlignment = NSTextAlignmentCenter;
        [lableOne setTextColor:COLORFromRGB(0xffffff)];
        lableOne.font = [UIFont systemFontOfSize:16];
        [button addSubview:lableOne];
        [lableOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button).offset(15);
            make.left.right.equalTo(button);
            make.height.mas_equalTo(16);
    
        }];
        UILabel *lableTwo = [[UILabel alloc] init];
        lableTwo.text = twoArray[i];
        lableTwo.textAlignment = NSTextAlignmentCenter;
        [lableTwo setTextColor:COLORFromRGB(0xffffff)];
        lableTwo.font = [UIFont systemFontOfSize:14];
        [button addSubview:lableTwo];
        [lableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lableOne.mas_bottom);
            make.left.right.equalTo(button);
            make.height.mas_equalTo(14);
            
        }];
        
        tempBtn = button;
    }
}

/**
  选择框导航栏
 */
- (void)changeClick:(UIButton*)btn{
    
    if (selectBtn!=btn) {
        selectBtn.selected=NO;
        selectBtn.backgroundColor = COLORFromRGB(0xebebeb);
        btn.selected=YES;
        btn.backgroundColor = COLORFromRGB(0xe10000);
        selectBtn=btn;
    }
    
    switch (btn.tag) {
        case 300:
            _scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 301:
            _scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
            break;
        default:
            break;
    }

}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"商家认证";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标黑色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

}
/**
 导航栏左侧按钮点击事件
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma ********************UIScrollViewDelegate**************
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x/SC_WIDTH;
    
    UIButton *tempButton = (UIButton *)[self.view viewWithTag:300+x];
    if (selectBtn != tempButton) {
        selectBtn.selected=NO;
        selectBtn.backgroundColor = COLORFromRGB(0xebebeb);
        tempButton.selected = YES;
        tempButton.backgroundColor = COLORFromRGB(0xe10000);
        selectBtn = tempButton;
    }
    [_scrollView setContentOffset:CGPointMake(x*SC_WIDTH, 0) animated:YES];
    
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
