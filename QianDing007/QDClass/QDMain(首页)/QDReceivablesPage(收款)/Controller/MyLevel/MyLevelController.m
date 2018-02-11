//
//  MyLevelController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyLevelController.h"
#import "MyLeveLModel.h"
@interface MyLevelController (){

    NSMutableArray *lv_tableArray;//tableView 数组
    UIImageView *lv_topView;//顶部视图
    UILabel *lv_upLabel;//升级提示文本
    NSMutableDictionary *lv_TopDic;//数据字典
    UIImageView *lv_headView ;//头视图会员等级icon
    UILabel *lv_levelLabel;//头视图等级
    

}
@end

@implementation MyLevelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self createTableView];
    [self getDataSource];

    self.view.backgroundColor = COLORFromRGB(0xffffff);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMyLevel:) name:@"refreshMyLevel" object:nil];
    
}
- (void)refreshMyLevel:(NSNotification *)noti{
    [self getDataSource];


}
- (void)getDataSource{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    lv_TopDic = [[NSMutableDictionary alloc] init];
    lv_tableArray = [NSMutableArray arrayWithCapacity:2];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *levelDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:LEVEL_URL parameters:levelDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
//           NSLog(@"%@",[shareDelegate logDic:responseObject]);
            [lv_TopDic addEntriesFromDictionary:responseObject];
            [self mlGetUrlDataToSubview:lv_TopDic[@"my_level_info"]];
            NSArray *dicArray  =  lv_TopDic[@"promote_level_list"] ;
            int ID = [lv_TopDic[@"my_level_info"][@"id"] intValue];
            NSLog(@"ID == %d",ID);
            if (ID>=4) {
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView setImage:[UIImage imageNamed:@"组3"]];
                [self.view addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(self.view);
                    make.width.mas_equalTo(143);
                    make.height.mas_equalTo(100);

                }];
                
            }else{
            
                [self addDataToTabelAarry:dicArray];

            }
            
        }else{
            
            [self mlShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
/**
 添加头视图数据
 
 */
- (void)mlGetUrlDataToSubview:(NSDictionary*)dic{
    
    NSString *amount = dic[@"amount"];
    lv_upLabel.text = [NSString stringWithFormat:@"还差%@元升级",amount];
    
    if ([dic[@"id"] isEqualToString:@"4"]) {
        lv_upLabel.text = @"您已是最高级别会员";
    }
    
    switch ([dic[@"id"] intValue]) {
        case 1:
            [lv_headView setImage:[UIImage imageNamed:@"普通会员110*110"]];
            lv_levelLabel.text = @"普通商户";
            break;
        case 2:
            [lv_headView setImage:[UIImage imageNamed:@"银牌会员110*110"]];
            lv_levelLabel.text = @"银牌商户";
            break;
        case 3:
            [lv_headView setImage:[UIImage imageNamed:@"金牌会员110*110"]];
            lv_levelLabel.text = @"金牌商户";
            break;
        case 4:
            [lv_headView setImage:[UIImage imageNamed:@"钻石会员110*110"]];
            lv_levelLabel.text = @"钻石商户";
            break;
            
        default:
            break;
    }

    
}

/**
 添加tabelArray数组数据
 */
- (void)addDataToTabelAarry:(NSArray*)array{

    
    
    for (NSDictionary * dic in array) {
        MyLeveLModel *model = [[MyLeveLModel alloc] init];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:3];
        model.mebID      = dic[@"id"];
        model.mebLevel   = dic[@"level_name"];
        model.mebRate    = dic[@"scale"];
        model.mebMoney   = dic[@"amount"];
        model.mebRequest = dic[@"invite_num"];
        model.mebBuyMoney= dic[@"price"];
        [tempArray addObject:model];
        [lv_tableArray addObject:tempArray];
    }
    [_tableView reloadData];
}
/**
 创建tableview
 */
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lv_topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SC_HEIGHT-213/SCALE_Y);
        
    }];
    
}

- (void)createTopView{

    lv_topView = [[UIImageView alloc] init];
    [lv_topView setImage:[UIImage imageNamed:@"等级红色背景"]];
    [self.view addSubview:lv_topView];
    lv_topView.userInteractionEnabled = YES;
    [lv_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(210/SCALE_Y);
        
    }];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [lv_topView addSubview:button];
    [button addTarget:self action:@selector(leftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lv_topView).offset(35/SCALE_Y);
        make.left.equalTo(lv_topView).offset(15);
        make.height.mas_equalTo(22/SCALE_Y);
    }];

    UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lv_topView addSubview:maskBtn];
    [maskBtn addTarget:self action:@selector(leftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    [maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(button);
        make.height.width.mas_equalTo(30/SCALE_Y);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"等级";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    [lv_topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lv_topView.mas_centerX);
        make.top.equalTo(lv_topView).offset(35/SCALE_Y);
        make.height.mas_equalTo(22/SCALE_Y);
    }];

    lv_headView = [[UIImageView alloc] init];
    lv_headView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [lv_topView addSubview:lv_headView];
    lv_headView.layer.masksToBounds = YES;
    lv_headView.layer.cornerRadius  = 27.5;
    [lv_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lv_topView.mas_bottom).offset(-63/SCALE_Y);
        make.centerX.equalTo(lv_topView.mas_centerX);
        make.height.width.mas_equalTo(55);

    }];
    
    lv_levelLabel = [[UILabel alloc] init];
    lv_levelLabel.text = @"会员等级";
    lv_levelLabel.textAlignment = NSTextAlignmentCenter;
    [lv_levelLabel setTextColor:COLORFromRGB(0xffffff)];
    lv_levelLabel.font = [UIFont systemFontOfSize:16];
    [lv_topView addSubview:lv_levelLabel];
    [lv_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lv_headView.mas_centerX);
        make.top.equalTo(lv_headView.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
    
    }];
    
    lv_upLabel = [[UILabel alloc] init];
    lv_upLabel.text = @"还差000元升级";
    lv_upLabel.textAlignment = NSTextAlignmentCenter;
    [lv_upLabel setTextColor:COLORFromRGB(0xffffff)];
    lv_upLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lv_upLabel];
    [lv_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lv_levelLabel.mas_centerX);
        make.top.equalTo(lv_levelLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(150);

    }];
    
}

/**
 返回按钮
 */
- (void)leftBackClick:(UIButton*)btn{
    
//    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma ******************tabelViewDelegate*****************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return  lv_tableArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lv_tableArray[section] count];;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"reuseIdentifier";
    MyLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell= [[MyLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }

    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addDataToCell:lv_tableArray[indexPath.section][indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 235/SCALE_Y;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = COLORFromRGB(0xf9f9f9);
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
/**
 警示 弹出框
 */
- (void)mlShowAlert:(NSString *)warning{
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];
    //移除通知
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:@"refreshMyLevel"  object:nil];

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
