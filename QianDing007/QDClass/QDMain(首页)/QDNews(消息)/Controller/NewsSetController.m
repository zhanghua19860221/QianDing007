//
//  NewsSetController.m
//  QianDing007
//
//  Created by 张华 on 17/12/21.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "NewsSetController.h"

@interface NewsSetController ()

@end

@implementation NewsSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubView];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

}
- (void)createSubView{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(self.view);
        
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"屏蔽语音";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(100);
    
        
    }];
    UISwitch *switchView = [[UISwitch alloc] init];
    BOOL is_OpenSound =  [[shareDelegate shareNSUserDefaults] boolForKey:@"is_OpenSound"];
    NSLog(@"is_OpenSoundTwo == %d",is_OpenSound);

    if (is_OpenSound) {
        switchView.on = YES;//默认打开

    }else{
        switchView.on = NO; //设置初始为ON的一边
        
    }
    switchView.onTintColor = COLORFromRGB(0xe10000);
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [view addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.right.equalTo(self.view).offset(-30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);

    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    [lineView setImage:[UIImage imageNamed:@"分割线"]];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(1);
        make.left.equalTo(view);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SC_WIDTH);
    }];
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(self.view);
        
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"清空历史消息";
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2.mas_centerY);
        make.left.equalTo(view2).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(200);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clearDataBtn:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2.mas_centerY);
        make.left.equalTo(view2).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(200);
        
    }];
}
- (void)clearDataBtn:(UIButton *)btn{
    
    [self nsShowAlertFail:@"是否清空消息数据"];
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"消息设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)switchAction:(id)sender{
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        //打开开关
        NSLog(@"打开开关");
        [[shareDelegate shareNSUserDefaults] setBool:YES forKey:@"is_OpenSound"];
        BOOL is_OpenSound =  [[shareDelegate shareNSUserDefaults] boolForKey:@"is_OpenSound"];
        NSLog(@"is_OpenSoundThire == %d",is_OpenSound);
        
    }else {
        //关闭开关
        NSLog(@"关闭开关");
        [[shareDelegate shareNSUserDefaults] setBool:NO forKey:@"is_OpenSound"];
        BOOL is_OpenSound =  [[shareDelegate shareNSUserDefaults] boolForKey:@"is_OpenSound"];
        NSLog(@"is_OpenSoundfour == %d",is_OpenSound);

    }
    
}
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 提示框
 */
- (void)nsShowAlertFail:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
      //删除的语句    delete from 表名 where 条件
       BOOL isSucceed =[[shareDelegate shareFMDatabase] executeUpdate: @"delete from collectBase where userId = ?",[shareDelegate sharedManager].b_userID];
                                                              
          if (isSucceed) {
              [self createShowView:@"删除成功"];
          }else{
              [self createShowView:@"删除失败"];
          }
        }];
    UIAlertAction* CancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              
                                                          }];
    
    
    [alert addAction:defaultAction];
    [alert addAction:CancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

/**
删除弹出框
 */
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
