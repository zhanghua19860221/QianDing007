//
//  CallViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CallViewController.h"

@interface CallViewController (){
    UIView *teleView;//客服电话视图
    UIView *mailView;//客服邮箱


}

@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
  
    
}
- (void)createSubView{

    teleView = [[UIView alloc] init];
    teleView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:teleView];
    [teleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [teleView addGestureRecognizer:tapGesturRecognizer];

    
    UILabel *teleLabel = [[UILabel alloc] init];
    teleLabel.text = @"客服电话";
    teleLabel.textAlignment = NSTextAlignmentLeft;
    teleLabel.font = [UIFont systemFontOfSize:16];
    [teleLabel setTextColor:COLORFromRGB(0x333333)];
    [teleView addSubview:teleLabel];
    [teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teleView.mas_centerY);
        make.left.equalTo(teleView).offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);

    }];
    
    UIButton *teleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teleBtn setImage:[UIImage imageNamed:@"更多图标"] forState:UIControlStateNormal];
    [teleView addSubview:teleBtn];
    [teleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teleView.mas_centerY);
        make.right.equalTo(teleView).offset(-15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        
    }];
    UILabel *teleLabelOne = [[UILabel alloc] init];
    teleLabelOne.text = @"010-53536650";
    teleLabelOne.textAlignment = NSTextAlignmentRight;
    teleLabelOne.font = [UIFont systemFontOfSize:16];
    [teleLabelOne setTextColor:COLORFromRGB(0x999999)];
    [teleView addSubview:teleLabelOne];
    [teleLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teleView.mas_centerY);
        make.right.equalTo(teleBtn.mas_left).offset(-5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
        
    }];

    mailView = [[UIView alloc] init];
    mailView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:mailView];
    [mailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(teleView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *mailLabel = [[UILabel alloc] init];
    mailLabel.text = @"客服邮箱";
    mailLabel.textAlignment = NSTextAlignmentLeft;
    mailLabel.font = [UIFont systemFontOfSize:16];
    [mailLabel setTextColor:COLORFromRGB(0x333333)];
    [mailView addSubview:mailLabel];
    [mailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(mailView.mas_centerY);
        make.left.equalTo(mailView).offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    
    UILabel *mailLabelOne = [[UILabel alloc] init];
    mailLabelOne.text = @"miaoyinkefu@gyjfgroup.com ";
    mailLabelOne.textAlignment = NSTextAlignmentRight;
    mailLabelOne.font = [UIFont systemFontOfSize:16];
    [mailLabelOne setTextColor:COLORFromRGB(0x999999)];
    [mailView addSubview:mailLabelOne];
    [mailLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(mailView.mas_centerY);
        make.right.equalTo(mailView).offset(-15);
        make.width.mas_equalTo(230);
        make.height.mas_equalTo(16);
        
    }];
    
    
}
- (void)changeButtonStatus{
    teleView.userInteractionEnabled = YES;
    
}
/**
 客服电话视图点击事件
 */
-(void)tapAction:(id)tap{
    
    //防止重复点击
    teleView.userInteractionEnabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"01053536650"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"联系我们";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    [leftButton setImage:[UIImage imageNamed:@"返回图标"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
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
