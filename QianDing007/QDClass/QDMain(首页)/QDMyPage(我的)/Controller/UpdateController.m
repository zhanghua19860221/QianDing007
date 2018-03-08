//
//  UpdateController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UpdateController.h"

@interface UpdateController ()

@end

@implementation UpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
//    [self createNavgation];
//    [self createSubView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    
    
}
///**
// 版本号对比方法
// */
//- (void)createSubView{
//    
//    UIView *versionView = [[UIView alloc] init];
//    versionView.backgroundColor = COLORFromRGB(0xffffff);
//    [self.view addSubview:versionView];
//    [versionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(84);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(50);
//    }];
//
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    
//    UILabel *versionLabel = [[UILabel alloc] init];
//    versionLabel.text = [NSString stringWithFormat:@"当前版本号为：%@",app_Version];
//    versionLabel.textAlignment = NSTextAlignmentLeft;
//    versionLabel.font = [UIFont systemFontOfSize:16];
//    [versionLabel setTextColor:COLORFromRGB(0x333333)];
//    [versionView addSubview:versionLabel];
//    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(versionView.mas_centerY);
//        make.left.equalTo(versionView).offset(15);
//        make.width.mas_equalTo(SC_WIDTH-30);
//        make.height.mas_equalTo(16);
//        
//    }];
//    
////    //获取AppStore上的版本号
//    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"1319671449"];//后数字修改成自己项目的APPID
//    
//    [self Postpath:url];
//
//    
//}
//-(void)Postpath:(NSString *)path
//
//{
//    
//    
//    NSURL *url = [NSURL URLWithString:path];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                        cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                      timeoutInterval:0];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    NSOperationQueue *queue = [NSOperationQueue new];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
//        
//        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
//
//        NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSArray *array = receiveDic[@"results"];
//        NSDictionary *dict = [array lastObject];
//        NSLog(@"当前版本为：%@",dict[@"version"]);
//        
//    }];
//    
//}
/**
 创建导航栏
 */
//- (void)createNavgation{
//    self.navigationItem.title = @"当前版本号";
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 0, 20,20);
//    [leftButton setImage:[UIImage imageNamed:@"返回箭头红色"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//}
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
