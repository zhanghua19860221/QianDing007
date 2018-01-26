//
//  SuccessScanController.m
//  QianDing007
//
//  Created by 张华 on 18/1/5.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "SuccessScanController.h"
#import "ReceivablesPage.h"
@interface SuccessScanController (){

    AVSpeechSynthesizer*zh_voice;//语音播报

}
@end

@implementation SuccessScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scCreateSubView];
    [self createNavgation];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];

}

- (void)scCreateSubView{
    UIImageView *imageView = [[UIImageView alloc] init];
    if ([_order_status isEqualToString:@"0"]) {
        [imageView setImage:[UIImage imageNamed:@"图标"]];
        
    }else{
        [imageView setImage:[UIImage imageNamed:@"成功收款图标"]];

    }
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(64+60/SCALE_Y);
        make.width.height.mas_equalTo(100);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    if ([_order_status isEqualToString:@"0"]) {
        moneyLabel.text = [NSString stringWithFormat:@"资金通道处理失败%@元",_money_count];
    }else{
        moneyLabel.text = [NSString stringWithFormat:@"成功收款：%@元",_money_count];
        
    }
    [self.view addSubview:moneyLabel];
    moneyLabel.font = [UIFont systemFontOfSize:16];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(65);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(16);
 
    }];
    UILabel *orderLabel = [[UILabel alloc] init];
    if ([_order_status isEqualToString:@"0"]) {
        orderLabel.text = @"订单处理失败。";

    }else{
    
        orderLabel.text = [NSString stringWithFormat:@"订单号：%@",_order_num];
    }
    [self.view addSubview:orderLabel];
    [orderLabel setTextColor:COLORFromRGB(0x666666)];
    orderLabel.textAlignment = NSTextAlignmentLeft;
    orderLabel.font = [UIFont systemFontOfSize:14];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(65);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(14);
        
    }];
    
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd  HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[_order_time intValue]];
    NSString *orderTime = [stampFormatter stringFromDate:stampDate2];
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.text = [NSString stringWithFormat:@"收款时间：%@",orderTime];
    [self.view addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(65);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(16);
        
    }];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.backgroundColor = COLORFromRGB(0xe10000);
    [buttonBack setTitle:@"完成" forState:UIControlStateNormal];
    [buttonBack setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    buttonBack.titleLabel.font = [UIFont systemFontOfSize: 18];
    buttonBack.layer.masksToBounds = YES;
    buttonBack.layer.cornerRadius = 3;
    [buttonBack addTarget:self action:@selector(buttonBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    [buttonBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(60/SCALE_Y);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);

    }];
    NSString *voiceStr = [NSString stringWithFormat:@"收款到账：%@元。",_money_count];
    [self zhPlayVoice:voiceStr];
}
- (void)buttonBackClick{
    
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ReceivablesPage class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"我扫吧";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标黑色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ReceivablesPage class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}

/**
 语音播报方法
 
 */
- (void)zhPlayVoice:(NSString*)moneySter{
    
    zh_voice= [[AVSpeechSynthesizer alloc]init];
    
    zh_voice.delegate=self;//挂上代理
    
    AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:moneySter];//需要转换的文字
    
    utterance.rate=0.52;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
    
    AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
    
    utterance.voice= voice;
    
    [zh_voice speakUtterance:utterance];//开始
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma *************AVSpeechSynthesizerDelegate语音播报代理*********************

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---开始播放");
    
}


- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---完成播放");
    
}


- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放中止");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---恢复播放");
    
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
