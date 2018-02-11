//
//  SweepMeController.m
//  QianDing007
//
//  Created by 张华 on 18/1/5.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "SweepMeController.h"

@interface SweepMeController (){
    NSString *sm_url;//网络图片地址
    UIButton *sm_saveCodeButton; //保存二维码图片按钮
    UIImageView *sm_codeView; //二维码展示
    
}
@end

@implementation SweepMeController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self smCreateSubView];
      [self smCreateTopView];
    self.view.backgroundColor = COLORFromRGB(0xe10000);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xe10000);
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    //二维码展示视图
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];//可有可无

    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",SWEEPME_URL,oldSession];
    sm_url = imageUrl;
    
    NSString *tempUrlStr = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"tempUrlStr = %@",tempUrlStr);

    
    [sm_codeView sd_setImageWithURL:[NSURL URLWithString:tempUrlStr] placeholderImage:[UIImage imageNamed:@"二维码占位图"]];
}
/**
 创建顶部导航栏 视图
 */
- (void)smCreateTopView{

    UIImageView *backView = [[UIImageView alloc] init];
    [backView setImage:[UIImage imageNamed:@"返回箭头白色"]];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(31);
        make.left.equalTo(self.view).offset(15);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(22);

    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"扫我吧";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
}
- (void)smCreateSubView{
    
    UIView *firstBjView = [[UIView alloc] init];
    firstBjView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:firstBjView];
    firstBjView.layer.masksToBounds = YES;
    firstBjView.layer.cornerRadius = 10;
    [firstBjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+30/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(365/SCALE_Y);
        
    }];
    
    NSString *name = [[shareDelegate shareNSUserDefaults] objectForKey:@"merchantName"];
    //商户名称
    UILabel *merchantNameLabel = [[UILabel alloc] init];
    merchantNameLabel.text = name;
    merchantNameLabel.font = [UIFont systemFontOfSize:16];
    [merchantNameLabel setTextColor:COLORFromRGB(0x333333)];
    merchantNameLabel.textAlignment = NSTextAlignmentCenter;
    [firstBjView addSubview:merchantNameLabel];
    [merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBjView).offset(25/SCALE_Y);
        make.left.equalTo(firstBjView);
        make.right.equalTo(firstBjView);
        make.height.mas_equalTo(16);
        
    }];
    
    //二维码展示视图
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",SWEEPME_URL,oldSession];
    sm_url = imageUrl;
    
//    NSLog(@"imageUrl == %@",imageUrl);
    
    NSString *tempUrlStr = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    sm_codeView = [[UIImageView alloc] init];
    [firstBjView addSubview:sm_codeView];
    [sm_codeView sd_setImageWithURL:[NSURL URLWithString:tempUrlStr]];
    [sm_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(merchantNameLabel.mas_bottom).offset(5);
        make.centerX.equalTo(firstBjView.mas_centerX);
        make.height.width.mas_equalTo(240/SCALE_Y);
        
    }];
    
    UILabel *showLabel = [[UILabel alloc] init];
    showLabel.text = @"扫一扫，优惠买单";
    showLabel.font = [UIFont systemFontOfSize:12];
    [showLabel setTextColor:COLORFromRGB(0x999999)];
    showLabel.textAlignment = NSTextAlignmentCenter;
    [firstBjView addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sm_codeView.mas_bottom).offset(-10);
        make.centerX.equalTo(firstBjView.mas_centerX);
        make.width.equalTo(firstBjView.mas_width);
        make.height.mas_equalTo(12);

    }];
    
    
    UIButton *saveCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveCodeButton setTitle:@"保存二维码" forState:UIControlStateNormal];
    [saveCodeButton setTitleColor:COLORFromRGB(0x666666) forState:UIControlStateNormal];
    saveCodeButton.backgroundColor = COLORFromRGB(0xf5f5f5);
    [firstBjView addSubview:saveCodeButton];
    [saveCodeButton addTarget:self action:@selector(savePictureToAlbum) forControlEvents:UIControlEventTouchUpInside];
    [saveCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(firstBjView.mas_bottom);
        make.left.equalTo(firstBjView);
        make.right.equalTo(firstBjView);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    UIImageView *downloadImageView = [[UIImageView alloc] init];
    [downloadImageView setImage:[UIImage imageNamed:@"下载"]];
    [self.view addSubview:downloadImageView];
    [downloadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(saveCodeButton.mas_centerY);
        make.left.mas_equalTo(115/SCALE_X);
        make.height.width.mas_equalTo(22/SCALE_Y);
        
    }];

    
    UIView *scondeBjView = [[UIView alloc] init];
    scondeBjView.backgroundColor = COLORFromRGB(0xffffff);
    scondeBjView.layer.masksToBounds = YES;
    scondeBjView.layer.cornerRadius = 10;
    [self.view addSubview:scondeBjView];
    [scondeBjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBjView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(180/SCALE_Y);
        
    }];

    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"支持方式";
    typeLabel.font = [UIFont systemFontOfSize:16];
    [typeLabel setTextColor:COLORFromRGB(0x333333)];
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [scondeBjView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scondeBjView).offset(30/SCALE_Y);
        make.centerX.equalTo(scondeBjView.mas_centerX);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf5f5f5);
    [scondeBjView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeLabel.mas_centerY);
        make.right.equalTo(typeLabel.mas_left).offset(-15/SCALE_X);
        make.width.mas_equalTo(100/SCALE_X);
        make.height.mas_equalTo(1);
        
    }];
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf5f5f5);
    [scondeBjView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(typeLabel.mas_centerY);
        make.left.equalTo(typeLabel.mas_right).offset(30/SCALE_X);
        make.width.mas_equalTo(100/SCALE_X);
        make.height.mas_equalTo(1);
        
    }];
    
    UIImageView *aliView = [[UIImageView alloc] init];
    [scondeBjView addSubview:aliView];
    [aliView setImage:[UIImage imageNamed:@"支付宝"]];
    [aliView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).offset(30/SCALE_Y);
        make.left.equalTo(scondeBjView).offset(75);
        make.height.mas_equalTo(50/SCALE_X);
        make.width.mas_equalTo(50/SCALE_X);

        
    }];
    UIImageView *weChatView = [[UIImageView alloc] init];
    [scondeBjView addSubview:weChatView];
    [weChatView setImage:[UIImage imageNamed:@"微信"]];
    [weChatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).offset(30/SCALE_Y);
        make.right.equalTo(scondeBjView).offset(-75);
        make.height.mas_equalTo(50/SCALE_X);
        make.width.mas_equalTo(50/SCALE_X);
        
    }];
    
    UILabel *aliLabel = [[UILabel alloc] init];
    aliLabel.text = @"支付宝";
    aliLabel.font = [UIFont systemFontOfSize:14];
    [aliLabel setTextColor:COLORFromRGB(0x999999)];
    aliLabel.textAlignment = NSTextAlignmentCenter;
    [scondeBjView addSubview:aliLabel];
    [aliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliView.mas_bottom).offset(10);
        make.centerX.equalTo(aliView.mas_centerX);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
        
    }];
    UILabel *weChatLabel = [[UILabel alloc] init];
    weChatLabel.text = @"微信";
    weChatLabel.font = [UIFont systemFontOfSize:14];
    [weChatLabel setTextColor:COLORFromRGB(0x999999)];
    weChatLabel.textAlignment = NSTextAlignmentCenter;
    [scondeBjView addSubview:weChatLabel];
    [weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weChatView.mas_bottom).offset(10);
        make.centerX.equalTo(weChatView.mas_centerX);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
        
    }];
    
}
//防止重复点击
- (void)changeButtonStatus{
    sm_saveCodeButton.enabled = YES;
    
}

/**
 保存二维码图片到相册
 */
- (void)savePictureToAlbum{

    //防止重复点击
    sm_saveCodeButton.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];
    
    NSString *urlString = sm_url;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
        if (success == 1) {
            [self smShowAlert:@"二维码保存成功"];
        }else{
            [self smShowAlert:@"二维码保存失败"];
            
        }
        
    }];

}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 弹出框
 */
- (void)smShowAlert:(NSString *)warning{
    
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
