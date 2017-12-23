//
//  AboutWeController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "AboutWeController.h"

@interface AboutWeController (){
    UIImageView *logoImageView;//logo视图

}

@end

@implementation AboutWeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createMainTextView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xffffff);
    

}
- (void)createMainTextView{
    logoImageView = [[UIImageView alloc] init];
    [logoImageView setImage:[UIImage imageNamed:@"组2"]];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(SC_HEIGHT-64);
        make.width.mas_equalTo(SC_WIDTH);
        
    }];
    
//    UILabel *companyName = [[UILabel alloc] init];
//    companyName.text = @"秒银 (中国) 网络科技发展有限公司";
//    companyName.textAlignment = NSTextAlignmentCenter;
//    companyName.font = [UIFont systemFontOfSize:18];
//    [companyName setTextColor:COLORFromRGB(0x333333)];
//    [self.view addSubview:companyName];
//    [companyName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(logoImageView.mas_bottom).offset(30/SCALE_Y);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.equalTo(self.view.mas_width);
//        make.height.mas_equalTo(18);
//    }];
//    
//    
//    UILabel *describeLabel = [[UILabel alloc] init];
//    describeLabel.text = @"\t钱叮作为秒银（中国）网络科技发展有限公司主导品牌，专注于聚合支付领域，帮助商家，消费者与合伙人实现公营互通，并且有效提高商家发簪速度及知名度。秒银（中国）成立于2017年6月26日，注册资金一亿人民币。作为恒丰集团众多子公司的一员，秒银（中国）是其中实力最为雄厚，专业程度最高的一家以科技为主导的电商企业。依托雄厚的技术实力、专业的服务团队和强大的实仓资源，开发一聚合支付为基础的钱叮购物商城。";
//    describeLabel.font = [UIFont systemFontOfSize:16];
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//    paragraph.lineSpacing = 13; //设置行间距
//    describeLabel.numberOfLines = 0; //设置分行显示，必须必须设置这个属性
//    NSDictionary *attributeDict = @{
//                                    NSFontAttributeName: [UIFont systemFontOfSize:16],
//                                    NSForegroundColorAttributeName:COLORFromRGB(0x333333),
//                                    NSKernAttributeName:@0, NSParagraphStyleAttributeName: paragraph};
   
//    CGSize contentSize = [describeLabel.text boundingRectWithSize:CGSizeMake(SC_WIDTH-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:nil].size;//计算文字大小
//    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:describeLabel.text attributes:attributeDict];
//    describeLabel.attributedText = attributed;
//    [self.view addSubview:describeLabel];
//    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(companyName.mas_bottom).offset(20/SCALE_Y);
//        make.left.equalTo(self.view).offset(20);
//        make.right.equalTo(self.view).offset(-20);
//        make.height.mas_equalTo(contentSize.height);
//        
//    }];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"关于我们";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
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
