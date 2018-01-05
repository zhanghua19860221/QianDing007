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

    NSMutableArray *mr_dataArray;//数据数组
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


- (void)getDataSource{
    
    mr_Dic = [[NSMutableDictionary alloc] init];
    mr_dataArray = [NSMutableArray arrayWithCapacity:2];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *Dic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:INVITATION_URL parameters:Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mr_Dic addEntriesFromDictionary:responseObject];
        NSLog(@"%@",[shareDelegate logDic:mr_Dic]);
        [self mlGetUrlDataToSubview:mr_Dic];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

/**
 获取网络下载数据，更新视图数据
 
 */
- (void)mlGetUrlDataToSubview:(NSDictionary*)dic{
    
    
    NSString *requestStr = [NSString stringWithFormat:@"%@",dic[@"invite_count"]];
    NSString *codeStr = [NSString stringWithFormat:@"%@",dic[@"invite_code"]];
    mr_requestLabel.text = requestStr;
    mr_codeLabel.text    = codeStr;
    
    NSArray *array = dic[@"invite_supplier_list"];
    
    if ([requestStr isEqualToString:@"0"]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"暂无邀请记录"]];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).offset(-30);
            make.width.height.mas_equalTo(90);
        }];
       return;
    }else{
    
        for (NSDictionary * tempDic in array) {
            
            MyRequestModel *model = [[MyRequestModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [mr_dataArray addObject:model];
        }
    }
    [self createTabelView];
}

/**
 创建tableview
 */
-(void)createTabelView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(74+90/SCALE_Y);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-74-90/SCALE_Y);
        
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
    [rightButton addTarget:self action:@selector(rightBackClick) forControlEvents:UIControlEventTouchUpInside];
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
- (void)rightBackClick{
    
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
-(void)createMaskView{

    mr_maskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    mr_maskView.hidden = YES;
    mr_maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:mr_maskView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];

    [mr_maskView addGestureRecognizer:tapGesturRecognizer];

}

/**

 蒙板点击事件
 */
-(void)tapAction:(id)tap{
    
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
        case 180:
            
            break;
        case 181:
            
            break;
        case 182:
            
            break;
            
        default:
            break;
    }

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
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma *********************tabelViewDelegate*************************





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return mr_dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    MyRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[MyRequestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceToCell:mr_dataArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220/SCALE_Y;
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
