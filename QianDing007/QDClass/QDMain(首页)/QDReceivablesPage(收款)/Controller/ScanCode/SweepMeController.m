//
//  SweepMeController.m
//  QianDing007
//
//  Created by 张华 on 18/1/5.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "SweepMeController.h"

@interface SweepMeController (){
    UIImageView *sm_codeView;//二维码展示视图
    NSString *sm_url;//网络图片地址
    UIButton *sm_saveCode;//保存二维码图片按钮

}
@end

@implementation SweepMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self smCreateNavgation];
    [self smCreateSubView];
    [self smGetImageCode];

    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
- (void)smCreateSubView{
    
    UIView *bjView = [[UIView alloc] init];
    bjView.backgroundColor = COLORFromRGB(0xf5f5f5);
    [self.view addSubview:bjView];
    [bjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(171/SCALE_X,171/SCALE_X));
        
    }];
    sm_codeView = [[UIImageView alloc] init];
    sm_codeView.backgroundColor = COLORFromRGB(0xffffff);
    [bjView addSubview:sm_codeView];
    [sm_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bjView).offset(6);
        make.left.equalTo(bjView).offset(6);
        make.bottom.equalTo(bjView).offset(-6);
        make.right.equalTo(bjView).offset(-6);

    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"扫一扫，优惠买单";
    label.font = [UIFont systemFontOfSize:16];
    [label setTextColor:COLORFromRGB(0x333333)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bjView.mas_bottom).offset(15);
        make.centerX.equalTo(bjView.mas_centerX);
        make.width.equalTo(bjView.mas_width);
        
    }];
    
    sm_saveCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [sm_saveCode setTitle:@"保存二维码" forState:UIControlStateNormal];
    [sm_saveCode setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    sm_saveCode.layer.masksToBounds = YES;
    sm_saveCode.layer.cornerRadius = 5;
    sm_saveCode.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:sm_saveCode];
    [sm_saveCode addTarget:self action:@selector(savePictureToAlbum) forControlEvents:UIControlEventTouchUpInside];
    [sm_saveCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);

    }];
    
}
//防止重复点击
- (void)changeButtonStatus{
    sm_saveCode.enabled = YES;
    
}

/**
 保存二维码图片到相册
 */
- (void)savePictureToAlbum{

    //防止重复点击
    sm_saveCode.enabled = NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];
    
    NSString *urlString = sm_url;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data]; // 取得图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

/**
 添加二维码图片
 */
- (void)smGetImageCode{

    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",SWEEPME_URL,oldSession];
    sm_url = imageUrl;
    
    NSString *tempUrlStr = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"tempUrlStr == %@",tempUrlStr);
    
    [sm_codeView sd_setImageWithURL:[NSURL URLWithString:tempUrlStr]];
 

}
/**
 创建导航栏
 */
- (void)smCreateNavgation{
    self.navigationItem.title = @"扫我吧";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
