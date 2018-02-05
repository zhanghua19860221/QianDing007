//
//  MyRequestController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyRequestController.h"
#import "MyRequestModel.h"
#import "MyRequestCell.h"
@interface MyRequestController (){
    UIView *mr_requestView;      //商户邀请记录
    UIScrollView *mr_scrollview; //视图滚动展示
    UIView *mr_requestIconView;  //我要邀请视图
    UIView *mr_maskView;         //蒙板视图
    NSMutableDictionary *mr_Dic; //网络数据字典
    UILabel *mr_requestLabel;    //成功邀请数
    UILabel *mr_codeLabel;       //邀请码

    
}
@end

@implementation MyRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self getDataSource];
    [self createStatistics];
    [self createMaskView];
    [self createRequestView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xe10000);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];

}


/**
 获取网络数据
 */
- (void)getDataSource{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];

    mr_Dic = [[NSMutableDictionary alloc] init];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *Dic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:INVITATION_URL,(long)1];

    
    [manager POST:urlStr parameters:Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject == %@",responseObject);
        
        [mr_Dic addEntriesFromDictionary:responseObject];
        NSString *requestStr = [NSString stringWithFormat:@"%@",responseObject[@"invite_count"]];
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"invite_code"]];
        mr_requestLabel.text = requestStr;
        mr_codeLabel.text    = codeStr;
        
        NSArray *array = responseObject[@"invite_supplier_list"];
        
        NSString *requestList = [NSString stringWithFormat:@"%@",responseObject[@"has_supplier_list"]];

        if ([requestList isEqualToString:@"0"]) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setImage:[UIImage imageNamed:@"暂无2"]];
            [self.view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.mas_centerX);
                make.centerY.equalTo(self.view.mas_centerY).offset(-30);
                make.width.mas_equalTo(90);
                make.height.mas_equalTo(120);

            }];
            [[shareDelegate shareZHProgress] removeFromSuperview];
            
            return;
        }else{
            
            for (NSDictionary * tempDic in array) {
                
                MyRequestModel *model = [[MyRequestModel alloc]init];
                [model setValuesForKeysWithDictionary:tempDic];
                [self.dataArray addObject:model];
                
            }
        }
        [self.tableView reloadData];
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
/**
 懒加载数组
 */
- (NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}
/**
 懒加载tableview
 
 */
- (UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        _tableView.separatorStyle = NO;
        _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(74+90/SCALE_Y);
            make.left.right.equalTo(self.view);
            make.height.mas_offset(SC_HEIGHT-10-90/SCALE_Y);
            
        }];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            
            [self updateData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self updateData];
        }];
        
    }
    return _tableView;
}

/**
 
 停止刷新
 **/
-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
/*
 更新数据.
 数据更新后,会自动更新视图.
 */

- (void)updateData{
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSDictionary *mrDic =@{@"auth_session":oldSession
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    NSString * urlStr = [NSString stringWithFormat:INVITATION_URL,(long)self.page++];
    
    NSLog(@"urlStr == %@",urlStr);


    [manager POST:urlStr parameters:mrDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self endRefresh];
        if (2 == self.page) { // 说明是在重新请求数据.
            self.dataArray = nil;
        }
        NSLog(@"%@",responseObject);

        NSArray *array = responseObject[@"invite_supplier_list"];
        NSString *requestList = [NSString stringWithFormat:@"%@",responseObject[@"has_supplier_list"]];
        
        if (![requestList isEqualToString:@"0"] && self.page != 1) {
            
            for (NSDictionary * tempDic in array) {
                MyRequestModel *model = [[MyRequestModel alloc]init];
                [model setValuesForKeysWithDictionary:tempDic];
                [self.dataArray addObject:model];
                
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        [self endRefresh];
        
    }];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"我的邀请";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标白色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40,40);
    [rightButton setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [rightButton setTitle:@"邀请" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(mrRightBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
/**
 导航栏左侧按钮
 */
- (void)leftBackClick{
    
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 导航栏右侧按钮
 */
- (void)mrRightBackClick{
    
    mr_maskView.hidden = NO;
    
    //修改下边距约束
    [mr_requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_maskView.mas_bottom).offset(-190/SCALE_Y);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [mr_maskView layoutIfNeeded];
    }];
    
}

/**
 顶部统计视图
 */
- (void)createStatistics{
    
    mr_requestView = [[UIView alloc] init];
    mr_requestView.backgroundColor = COLORFromRGB(0xffffff);
    mr_requestView.layer.shadowColor = COLORFromRGB(0xe10000).CGColor;
    [self.view addSubview:mr_requestView];
    [mr_requestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(90/SCALE_Y);
        
    }];

    mr_requestLabel = [[UILabel alloc] init];
    mr_requestLabel.font = [UIFont systemFontOfSize:20];
    mr_requestLabel.text = @"0";
    [mr_requestLabel setTextColor:COLORFromRGB(0xe10000)];
    mr_requestLabel.textAlignment = NSTextAlignmentCenter;
    [mr_requestView addSubview:mr_requestLabel];
    [mr_requestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_requestView).offset(30/SCALE_Y);
        make.left.equalTo(mr_requestView).offset(50/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        
    }];

    UILabel *orderLabelOne = [[UILabel alloc] init];
    orderLabelOne.font = [UIFont systemFontOfSize:14];
    orderLabelOne.text = @"成功邀请";
    orderLabelOne.textAlignment = NSTextAlignmentCenter;
    [mr_requestView addSubview:orderLabelOne];
    [orderLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_requestLabel.mas_bottom).offset(10);
        make.left.equalTo(mr_requestLabel);
        make.width.equalTo(mr_requestLabel);
        make.height.mas_equalTo(14);
        
    }];

    mr_codeLabel = [[UILabel alloc] init];
    mr_codeLabel.font = [UIFont systemFontOfSize:20];
    mr_codeLabel.text = @"00000000000";
    [mr_codeLabel setTextColor:COLORFromRGB(0xe10000)];
    mr_codeLabel.textAlignment = NSTextAlignmentRight;
    [mr_requestView addSubview:mr_codeLabel];
    [mr_codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(mr_requestLabel.mas_centerY);
        make.right.equalTo(mr_requestView).offset(-50/SCALE_X);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    
    }];

    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.font = [UIFont systemFontOfSize:14];
    codeLabel.text = @"邀请码";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [mr_requestView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_codeLabel.mas_bottom).offset(10);
        make.left.equalTo(mr_codeLabel.mas_left).offset(20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(14);
    
    }];

    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    copyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [copyBtn setTitleColor:COLORFromRGB(0x999999) forState:UIControlStateNormal];
    [mr_requestView addSubview:copyBtn];
    [copyBtn addTarget:self action:@selector(mrCopyClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeLabel.mas_centerY);
        make.left.equalTo(codeLabel.mas_right);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(14);
    
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0x999999);
    [mr_requestView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(copyBtn.mas_bottom).offset(1);
        make.left.right.equalTo(copyBtn);
        make.height.mas_equalTo(2);
    }];
}

/**
 复制按钮点击事件
 */
- (void)mrCopyClickBtn:(UIButton*)btn{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = mr_codeLabel.text;
    [self mrShowAlert:@"复制成功"];
}
/**
 创建邀请视图
 */
- (void)createRequestView{
    
    mr_requestIconView = [[UIView alloc] init];
    mr_requestIconView.backgroundColor = COLORFromRGB(0xffffff);
    [mr_maskView addSubview:mr_requestIconView];
    
    UILabel *typeLable = [[UILabel alloc] init];
    typeLable.text = @"邀请方式:";
    typeLable.textAlignment = NSTextAlignmentLeft;
    typeLable.font = [UIFont systemFontOfSize:18];
    [typeLable setTextColor:COLORFromRGB(0x333333)];
    [mr_requestIconView addSubview:typeLable];
    
    [mr_requestIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mr_maskView).offset(190/SCALE_Y);
        make.left.right.equalTo(mr_maskView);
        make.height.mas_equalTo(190/SCALE_Y);
        
    }];
    [typeLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(mr_requestIconView).offset(25/SCALE_Y);
        make.left.equalTo(mr_requestIconView).offset(15);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(100);

    }];
    
    UIView *iconBJView = [[UIView alloc] init];
    iconBJView.backgroundColor = COLORFromRGB(0xffffff);
    [mr_requestIconView addSubview:iconBJView];
    [iconBJView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLable.mas_bottom).offset(5/SCALE_Y);
        make.left.equalTo(mr_requestIconView).offset(50/SCALE_X);
        make.right.equalTo(mr_requestIconView).offset(-50/SCALE_X);
        make.height.mas_equalTo(95/SCALE_Y);
        
    }];
    
    NSArray *loginViewArray = @[@"微信@2x",@"QQ",@"通讯录"];
    NSArray *loginLabelArrya = @[@"微信邀请",@"QQ邀请",@"通讯录邀请"];
    UIButton *tempBtn = nil;
    for (int i = 0; i<3 ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:loginViewArray[i]] forState:UIControlStateNormal];
        button.tag = 180+i;
        [iconBJView addSubview:button];
        [button addTarget:self action:@selector(requestViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = loginLabelArrya[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [label setTextColor:COLORFromRGB(0x333333)];
        [iconBJView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.top.equalTo(button.mas_bottom).offset(10);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(80);
            
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBJView).offset(15);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right).offset(46/SCALE_X);
            }else{
                
                make.left.equalTo(iconBJView);
            }
            make.width.height.mas_equalTo(60/SCALE_Y);
            
        }];
        tempBtn = button;
    }
    
}
/**
 创建蒙板视图
 */
-(void)createMaskView{

    mr_maskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    mr_maskView.hidden = YES;
    mr_maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:mr_maskView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mrTapAction:)];

    [mr_maskView addGestureRecognizer:tapGesturRecognizer];

}

/**

 蒙板点击事件
 */
-(void)mrTapAction:(id)tap{
    
    [mr_requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_maskView.mas_bottom).offset(190/SCALE_Y);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [mr_maskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        mr_maskView.hidden = YES;

    }];
    //更新约束
    
}

/**
 邀请对应类型按钮点击事件
 */
- (void)requestViewClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 180:{
            [self mrShareWeChat];
        }
            break;
        case 181:{
            [self mrShareTencent];
        
        }
            break;
        case 182:{
            [self mrShareMailList];
            
        }
            break;
            
        default:
            break;
    }

}
//弹出 分享结果 视图初始化
-(void)shareStataView:(NSString * ) stata{
    //收藏时提示框 视图
    UIView *promptBox = [[UIView alloc] init];
    [self.view addSubview:promptBox];

    [UIView animateWithDuration:1 animations:^{

        promptBox.backgroundColor = [COLORFromRGB(0x000000) colorWithAlphaComponent:0.5];
        promptBox.layer.cornerRadius=8;
        promptBox.layer.masksToBounds=YES;
        [promptBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view.mas_centerY).offset(50);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(40);
            
        }];
        
        UILabel*lable=[[UILabel alloc] init];
        lable.text= stata ;
        lable.textAlignment=NSTextAlignmentCenter;
        [lable setTextColor:COLORFromRGB(0xffffff)];
        lable.font=[UIFont boldSystemFontOfSize:16];
        [promptBox addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(promptBox);
            make.centerY.equalTo(promptBox.mas_centerY);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
            
        }];
        
    } completion:^(BOOL finished) {
        
        [promptBox removeFromSuperview];
        
    }];
}
/**
 微信分享
 */
- (void)mrShareWeChat{
       mr_maskView.hidden = YES;
       [mr_requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(mr_maskView.mas_bottom).offset(190/SCALE_Y);
       }];
       [mr_maskView layoutIfNeeded];
    
    //本地保存用户 手机号 数据
    NSString *sharePhone = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    NSString *tempStr = @"http://101.201.117.15/wap/index.php?ctl=qd_user&act=Register&invite_code=";
    NSString *inviteUrl = [NSString stringWithFormat:@"%@%@",tempStr,sharePhone];

        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"钱叮"
                                         images:[UIImage imageNamed:@"图层1"]
                                            url:[NSURL URLWithString:inviteUrl]
                                          title:@"钱叮0001"
                                           type:SSDKContentTypeWebPage
         ];
        //开始进行分享
        [ShareSDK showShareEditor:SSDKPlatformTypeWechat
               otherPlatformTypes:nil
                      shareParams:shareParams
              onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end){

             switch (state) {
                     
                 case SSDKResponseStateSuccess:{
                     [self shareStataView:@"分享成功"];
                     
                     
                 }
                     break;
                 case SSDKResponseStateFail:{
                     [self shareStataView:@"分享失败"];
                     
                 }
                     break;

                 case SSDKResponseStateCancel:{
//                     [self shareStataView:@"取消分享"];
    
                 }
                    break;
                 default:
                     break;
             }
             
         }];
}
/**
 qq分享
 */
- (void)mrShareTencent{
    mr_maskView.hidden = YES;
    [mr_requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_maskView.mas_bottom).offset(190/SCALE_Y);
    }];
    [mr_maskView layoutIfNeeded];
    
    //本地保存用户 手机号 数据
    NSString *sharePhone = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    NSString *tempStr = @"http://101.201.117.15/wap/index.php?ctl=qd_user&act=Register&invite_code=";
    NSString *inviteUrl = [NSString stringWithFormat:@"%@%@",tempStr,sharePhone];

    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"钱叮"
                                     images:[UIImage imageNamed:@"QQ"]
                                        url:[NSURL URLWithString:inviteUrl]
                                      title:@"钱叮0001"
                                       type:SSDKContentTypeWebPage
     ];
        //开始进行分享
        [ShareSDK showShareEditor:SSDKPlatformTypeQQ
               otherPlatformTypes:nil
                      shareParams:shareParams
              onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end){
                  NSLog(@"(unsigned long)state==%lu",(unsigned long)state);
             switch (state) {
                 case SSDKResponseStateSuccess:{
                     [self shareStataView:@"分享成功"];
                     
                 }
                     break;
                 case SSDKResponseStateFail:{
                     [self shareStataView:@"分享失败"];
                     
                 }
                     break;
                 case SSDKResponseStateCancel:{
                     [self shareStataView:@"取消分享"];
                     
                 }
                     break;
                 default:
                     break;
             }
             
         }];
    
}
/**
 通讯录分享
 */
- (void)mrShareMailList{
    mr_maskView.hidden = YES;
    [mr_requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mr_maskView.mas_bottom).offset(190/SCALE_Y);
    }];
    [mr_maskView layoutIfNeeded];
    //让用户给权限,没有的话会被拒的各位
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"没有授权, 需要去设置中心设置授权");
            }else{
                NSLog(@"用户已授权限");
                CNContactPickerViewController * picker = [CNContactPickerViewController new];
                picker.delegate = self;
                // 加载手机号
                picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
                [self presentViewController: picker  animated:YES completion:nil];
            }
        }];
    }
    if (status == CNAuthorizationStatusAuthorized) {
        
        //有权限时
        CNContactPickerViewController * picker = [CNContactPickerViewController new];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController: picker  animated:YES completion:nil];
    }
    else{
        NSLog(@"您未开启通讯录权限,请前往设置中心开启");
    }
    
}
#pragma *********************tabelViewDelegate*************************


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    MyRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[MyRequestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceToCell:self.dataArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     MyRequestModel *model = self.dataArray[indexPath.row];
    float heightInfo = [shareDelegate labelHeightText:model.address Font:16 Width:(SC_WIDTH-125)/SCALE_X];
    float heightCell = 0;
    heightCell = 220/SCALE_Y + heightInfo;
    return heightCell;
}
#pragma ************ 通讯录代理方法********************************

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    CNContact *contact = contactProperty.contact;
    
    //获取姓名 和 电话
    //NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
    
    if (![contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        NSLog(@"提示用户选择11位的手机号");
        return;
    }
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString * Str = phoneNumber.stringValue;
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *phoneStr = [[Str componentsSeparatedByCharactersInSet:setToRemove]componentsJoinedByString:@""];
    if (phoneStr.length != 11) {
        
        NSLog(@"提示用户选择11位的手机号");
    }
//    NSString * textName = [NSString stringWithFormat:@"姓名:%@-电话:%@",contact.familyName,phoneStr];
    

    
     NSString * requestPhone = [NSString stringWithFormat:@"%@",phoneStr];

     NSString * authSession = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSDictionary *mrDic =@{@"phone":requestPhone,
                           @"auth_session":authSession,
                           @"type":@"supplier"

                           };
    NSLog(@"mrDic == %@",mrDic);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];

    [manager POST:REQUESTESMS_URL parameters:mrDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self mrShowAlert:@"邀请成功"];
        }else{
        
            [self mrShowAlert:responseObject[@"info"]];

        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 弹出框
 */
- (void)mrShowAlert:(NSString *)warning{
    
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
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];



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
