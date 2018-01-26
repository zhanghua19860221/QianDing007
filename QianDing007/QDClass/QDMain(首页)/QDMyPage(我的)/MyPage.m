//
//  MyPage.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyPage.h"
#import "MyPageModel.h"
#import "MyPageCell.h"
#import "UserViewController.h"
#import "MydelegateViewController.h"
#import "SecuritySetController.h"
#import "AboutWeController.h"
#import "CallViewController.h"
#import "UpdateController.h"
#import "BecomeDelegateController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MyPage (){
    
    NSMutableArray*mp_allArray;  //table分组数组
    UIImageView *mp_topView ;    //顶视图
    UIButton *mp_codeButton ;    //二维码展示button
    UIButton *mp_headViewBtn;    //头像视图按钮
    NSString *mp_localVersion;   //记录本地版本号
    NSString *mp_serverVersion;  //记录服务器版本号
    UILabel  *mp_requestLabel;   //蒙板邀请文本
    UIView   *mp_showCodeView;   //二维码背景视图
    
    UIView *mp_myCodeMaskView;   //二维码蒙板视图
    UIImageView *mp_maskCodeView;//二维码展示视图

    UIView *mp_myHeadMaskView;   //头像蒙板视图
    UIView *mp_myShowHeadView;   //头像展示视图

    


}
@end

@implementation MyPage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self mpCreateTopView];
    [self mpCreateTabelView];
    [self mpTestingVersion];//检查更新
    [self mpCreateMaskView];//创建二维码弹出视图
    [self mpHeadMaskView];//创建头像视图点击事件蒙板视图


    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //获取商户的代理状态
    NSString *is_agency = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_agency"];
    if(![is_agency isEqualToString:@"1"]){
        [self getAgencyState];

    }


}
/**
 获取商户的 代理状态
 */
- (void)getAgencyState{
    
    //创建请求菊花进度条
    [self.view addSubview:[shareDelegate shareZHProgress]];
    [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];
    [self.view bringSubviewToFront:[shareDelegate shareZHProgress]];
    
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *bdDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:DELEGATEGETINFO_URL parameters:bdDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        if ([responseObject[@"status"]  isEqualToString:@"1"]) {
            
            [[shareDelegate shareNSUserDefaults] setObject:responseObject[@"is_agency"] forKey:@"is_agency"];
            
        }else{
            
            [self mpShowAlert:responseObject[@"info"]];
        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        
        
    }];
    
}

/**
 获取本地版本号 和 服务器版本号
 */
- (void)mpTestingVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    mp_localVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
 
//获取AppStore上的版本号
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",@"1319671449"];//后数字修改成自己项目的APPID
    
    [self Postpath:url];
    

}
-(void)Postpath:(NSString *)path{
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:0];
    
    [request setHTTPMethod:@"POST"];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        
        NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = receiveDic[@"results"];
        NSDictionary *dict = [array lastObject];
        mp_serverVersion = dict[@"version"];
        
    }];
    
}

/**
 tableview创建 加载数据
 */
- (void)mpCreateTabelView{
    

    NSString *is_checked = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_checked"];
    
    NSArray *imageFirstArray = @[@"商户认证",@"我的代理"];
    NSArray *stateFirstArray = @[is_checked,@"空"];
    NSArray *imageSecondArray = @[@"安全设置",@"关于我们",@"联系我们",@"检查更新"];
    NSArray *stateSecondArray= @[@"空",@"空",@"空",@"空"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc] init];
    NSMutableArray *secondArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<imageFirstArray.count ; i++) {
        
        MyPageModel *dataModle = [[MyPageModel alloc] init];
        dataModle.firstStr  = imageFirstArray[i];
        dataModle.secondStr = imageFirstArray[i];
        dataModle.thirdStr  = stateFirstArray[i];
        dataModle.fourStr   = @"更多图标";
        [firstArray addObject:dataModle];
        
    }
    for (int i = 0; i<imageSecondArray.count ; i++) {
        
        MyPageModel *dataModle = [[MyPageModel alloc] init];
        dataModle.firstStr  = imageSecondArray[i];
        dataModle.secondStr = imageSecondArray[i];
        dataModle.thirdStr  = stateSecondArray[i];
        dataModle.fourStr   = @"更多图标";
        [secondArray addObject:dataModle];
    }
    
    mp_allArray = [[NSMutableArray alloc] initWithCapacity:2];
    [mp_allArray addObject:firstArray];
    [mp_allArray addObject:secondArray];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_topView.mas_bottom).offset(40/SCALE_Y);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SC_HEIGHT);
    }];

}

/**
 二维码按钮点击事件
 
 */
- (void)myCodeButton:(UIButton*)btn{
    
    NSString *is_checked = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_checked"];
    
    if ([is_checked isEqualToString:@"1"]) {
        [mp_showCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(mp_myCodeMaskView);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(220);
            
        }];
        
        [mp_requestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mp_showCodeView).offset(10);
            make.left.equalTo(mp_showCodeView).offset(17);
            make.right.equalTo(mp_showCodeView);
            make.height.mas_equalTo(20);
            
        }];
        
        [mp_maskCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mp_showCodeView).offset(20);
            make.left.right.equalTo(mp_showCodeView);
            make.height.mas_equalTo(200);
            
        }];
        [UIView animateWithDuration:0.5 animations:^{
            [mp_myCodeMaskView layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            mp_requestLabel.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                mp_requestLabel.alpha = 1;
            }];
        }];
        
        mp_myCodeMaskView.hidden = NO;
        btn.hidden = YES;

    }else{
        
        [self mpShowAlert:@"点击－>商户认证"];
    }
    
    
    

}

/**
 创建二维码点击事件 弹出的蒙板视图
 
 */
-(void)mpCreateMaskView{
    
    
    
    mp_myCodeMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    mp_myCodeMaskView.hidden = YES;
    mp_myCodeMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:mp_myCodeMaskView];
    
    mp_showCodeView  = [[UIView alloc] init];
    mp_showCodeView.backgroundColor = COLORFromRGB(0xffffff);
    [mp_myCodeMaskView addSubview:mp_showCodeView];
    [mp_showCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myCodeMaskView).offset(20);
        make.right.equalTo(mp_myCodeMaskView).offset(-15);
        make.width.height.mas_equalTo(45);
    
    }];
    
    
    mp_maskCodeView = [[UIImageView alloc] init];
    mp_maskCodeView.backgroundColor = COLORFromRGB(0xe10000);
    [mp_showCodeView addSubview:mp_maskCodeView];
    [mp_maskCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_showCodeView).offset(1);
        make.left.right.equalTo(mp_showCodeView);
        make.width.height.mas_equalTo(44);
        
    }];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *imageUrl = [NSString stringWithFormat:@"%@&auth_session=%@&type=%@",REQUESTCODE_URL,oldSession,@"supplier"];
    NSString *tempUrlStr = [imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [mp_maskCodeView sd_setImageWithURL:[NSURL URLWithString:tempUrlStr]];

    mp_requestLabel = [[UILabel alloc] init];
    mp_requestLabel.text = @"扫我吧 ！";
    mp_requestLabel.alpha = 0;
    mp_requestLabel.hidden = YES;
    mp_requestLabel.backgroundColor = COLORFromRGB(0xffffff);
    mp_requestLabel.textAlignment = NSTextAlignmentLeft;
    [mp_requestLabel setTextColor:COLORFromRGB(0x333333)];
    mp_requestLabel.font = [UIFont systemFontOfSize:18];
    [mp_showCodeView addSubview:mp_requestLabel];
    [mp_requestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_showCodeView);
        make.left.right.equalTo(mp_showCodeView);
        make.height.mas_equalTo(1);
        
    }];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTapAction:)];
    [mp_myCodeMaskView addGestureRecognizer:tapGesturRecognizer];
    
}
/**
 
 蒙板点击事件
 */
-(void)myTapAction:(id)tap{
    
    [mp_showCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myCodeMaskView).offset(20);
        make.right.equalTo(mp_myCodeMaskView).offset(-15);
        make.width.height.mas_equalTo(45);
    }];
    [mp_requestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_showCodeView);
        make.left.right.equalTo(mp_showCodeView);
        make.height.mas_equalTo(1);
        
    }];
    [mp_maskCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_showCodeView).offset(1);
        make.left.right.equalTo(mp_showCodeView);
        make.width.height.mas_equalTo(44);
        
    }];
    mp_requestLabel.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        [mp_myCodeMaskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        mp_codeButton.hidden = NO;
        mp_myCodeMaskView.hidden = YES;

    }];

}
/**
 创建头视图
 */
- (void)mpCreateTopView{
    
    mp_topView = [[UIImageView alloc] init];
    mp_topView.frame = CGRectMake(0,0, SC_WIDTH, 210/SCALE_Y);
    [mp_topView setImage:[UIImage imageNamed:@"红色背景"]];
    [self.view addSubview:mp_topView];
    
    
    mp_codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mp_codeButton setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    [self.view addSubview:mp_codeButton];
    [mp_codeButton addTarget:self action:@selector(myCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [mp_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-15);
        make.width.height.mas_equalTo(44);
        
        
    }];
    
    mp_headViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mp_headViewBtn.layer.cornerRadius = 35;
    mp_headViewBtn.layer.masksToBounds = YES;
    mp_headViewBtn.layer.borderWidth = 1;
    mp_headViewBtn.layer.borderColor = [COLORFromRGB(0xf39f34)CGColor];
    NSData *dataImage = [[shareDelegate shareNSUserDefaults] objectForKey:@"LOGO"];
    UIImage *image = [UIImage imageWithData:dataImage]; // 取得图片
    if (dataImage == NULL) {
        [mp_headViewBtn setImage:[UIImage imageNamed:@"图层1"] forState:UIControlStateNormal];
        
    }else{
        [mp_headViewBtn setImage:image forState:UIControlStateNormal];
        
    }
    [mp_headViewBtn addTarget:self action:@selector(choseGetType) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mp_headViewBtn];
    
    
    
    
    UILabel *stateLabel = [[UILabel alloc] init];
    
    NSString *is_checked = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_checked"];
    
    //判断是否认证
    if ([is_checked isEqualToString:@"1"]) {
        
        stateLabel.text = @"已认证";

    }else{
    
        stateLabel.text = @"未认证";
        
    }
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textColor = COLORFromRGB(0xffffff);
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.font = [UIFont systemFontOfSize:16];
    [mp_topView addSubview:stateLabel];
    
    [mp_headViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.center.equalTo(mp_topView);
        
    }];

    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_headViewBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        make.centerX.equalTo(mp_topView.mas_centerX);
    }];
    
}

/**
 点击头像 处理事件
 
 */
- (void)choseGetType{
    mp_myHeadMaskView.hidden = NO;

    //修改下边距约束
    [mp_myShowHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myHeadMaskView.mas_bottom).offset(-160/SCALE_Y);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [mp_myHeadMaskView layoutIfNeeded];
    }];
}
/**
 创建头像点击事件 弹出的蒙板视图
 
 */
- (void)mpHeadMaskView{
    mp_myHeadMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    mp_myHeadMaskView.hidden = YES;
    mp_myHeadMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:mp_myHeadMaskView];
    
    mp_myShowHeadView = [[UIView alloc] init];
    mp_myShowHeadView.backgroundColor = COLORFromRGB(0xffffff);
    [mp_myHeadMaskView addSubview:mp_myShowHeadView];
    mp_myShowHeadView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
    [mp_myShowHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myHeadMaskView.mas_bottom);
        make.left.right.equalTo(mp_myHeadMaskView);
        make.height.mas_equalTo(160/SCALE_Y);
    }];
    
    UIButton * openCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [openCameraButton setTitle:@"拍一张" forState:UIControlStateNormal];
    openCameraButton.backgroundColor = COLORFromRGB(0xffffff);
    [openCameraButton addTarget:self action:@selector(cameraButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [openCameraButton setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
    [mp_myShowHeadView addSubview:openCameraButton];
    [openCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myShowHeadView);
        make.left.right.equalTo(mp_myShowHeadView);
        make.height.mas_equalTo(50/SCALE_Y);
        
        
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [mp_myShowHeadView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(openCameraButton.mas_bottom);
        make.left.right.equalTo(mp_myShowHeadView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton * openAlbumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [openAlbumButton setTitle:@"相册选择" forState:UIControlStateNormal];
    openAlbumButton.backgroundColor = COLORFromRGB(0xffffff);
    [openAlbumButton setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
    [openAlbumButton addTarget:self action:@selector(albumButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mp_myShowHeadView addSubview:openAlbumButton];
    [openAlbumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(openCameraButton.mas_bottom).offset(1);
        make.left.right.equalTo(mp_myShowHeadView);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    UIButton * cancelShowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelShowButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelShowButton.backgroundColor = COLORFromRGB(0xffffff);
    [cancelShowButton setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
    [cancelShowButton addTarget:self action:@selector(cancelShowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [mp_myShowHeadView addSubview:cancelShowButton];
    [cancelShowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mp_myShowHeadView.mas_bottom);
        make.left.right.equalTo(mp_myShowHeadView);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mpTapAction:)];
    [mp_myHeadMaskView addGestureRecognizer:tapGesturRecognizer];
    
    
}

/**
 萌版点击事件
 
 */
- (void)mpTapAction:(id)tap{
    //修改下边距约束
    [mp_myShowHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myHeadMaskView.mas_bottom);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [mp_myHeadMaskView layoutIfNeeded];
    }completion:^(BOOL finished) {
        mp_myHeadMaskView.hidden = YES;

    }];
    
}

/**
 取消按钮点击事件
 */
- (void)cancelShowButtonClick:(UIButton*)btn{
    //修改下边距约束
    [mp_myShowHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myHeadMaskView.mas_bottom);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [mp_myHeadMaskView layoutIfNeeded];
    }completion:^(BOOL finished) {
        mp_myHeadMaskView.hidden = YES;
        
    }];

}
/**
 打开相机
 */
- (void)cameraButtonClick:(UIButton*)btn{
    
    //修改下边距约束
    [mp_myShowHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myHeadMaskView.mas_bottom);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [mp_myHeadMaskView layoutIfNeeded];
    }completion:^(BOOL finished) {
        mp_myHeadMaskView.hidden = YES;
        
    }];
    
    // 判断有摄像头，并且支持拍照功能
    if([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]){
        // 初始化图片选择控制器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        /*设置媒体来源，即调用出来的UIImagePickerController所显示出来的界面，有一下三种来源
         typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) { UIImagePickerControllerSourceTypePhotoLibrary, UIImagePickerControllerSourceTypeCamera, UIImagePickerControllerSourceTypeSavedPhotosAlbum };分别表示：图片列表，摄像头，相机相册*/
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];
        // 设置所支持的媒体功能，即只能拍照，或则只能录像，或者两者都可以
        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
        [controller setMediaTypes:arrMediaTypes];
        // 设置录制视频的质量
        [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
        //设置最长摄像时间
        [controller setVideoMaximumDuration:10.f];
        // 设置是否可以管理已经存在的图片或者视频
        [controller setAllowsEditing:YES];
        // 设置代理
        [controller setDelegate:self];
        [self presentViewController:controller animated:YES completion:nil];
    }else {
        NSLog(@"Camera is not available.");
    }

}
/**
 打开相册
 */
- (void)albumButtonClick:(UIButton*)btn{
    //修改下边距约束
    [mp_myShowHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mp_myHeadMaskView.mas_bottom);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [mp_myHeadMaskView layoutIfNeeded];
    }completion:^(BOOL finished) {
        mp_myHeadMaskView.hidden = YES;
        
    }];
    // 初始化图片选择控制器
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    /*设置媒体来源，即调用出来的UIImagePickerController所显示出来的界面，有一下三种来源
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) { UIImagePickerControllerSourceTypePhotoLibrary, UIImagePickerControllerSourceTypeCamera, UIImagePickerControllerSourceTypeSavedPhotosAlbum };分别表示：图片列表，摄像头，相机相册*/
    [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 设置所支持的媒体功能，即只能拍照，或则只能录像，或者两者都可以
    NSString *requiredMediaType = ( NSString *)kUTTypeImage;
    NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType,nil];
    [controller setMediaTypes:arrMediaTypes];
    
    // 设置是否可以管理已经存在的图片或者视频
    [controller setAllowsEditing:YES];
    // 设置代理
    [controller setDelegate:self];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma **************UITableViewDelegate**************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return mp_allArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [mp_allArray[section] count];;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    MyPageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[MyPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.layer.borderColor = [COLORFromRGB(0xf9f9f9) CGColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addDataSourceView:mp_allArray[indexPath.section][indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPageModel *tempModel = [[MyPageModel alloc] init];
    tempModel = mp_allArray[indexPath.section][indexPath.row];
    NSString *tempStr = tempModel.firstStr;
    if ([tempStr isEqual:@"商户认证"]) {
            UserViewController *tempVc = [[UserViewController alloc] init];
            [self.navigationController pushViewController:tempVc animated:YES];
        
    }else if([tempStr isEqual:@"我的代理"]){

    NSString *is_agency = [[shareDelegate shareNSUserDefaults] objectForKey:@"is_agency"];

        if ([is_agency isEqualToString:@"0"]) {
            BecomeDelegateController *tempVc = [[BecomeDelegateController alloc] init];
            [self.navigationController pushViewController:tempVc animated:YES];
            
        }else{
            
            MydelegateViewController *tempVc1 = [[MydelegateViewController alloc] init];
            [self.navigationController pushViewController:tempVc1 animated:YES];
            
        }
    
    }else if([tempStr isEqual:@"安全设置"]){
        SecuritySetController *tempVc2 = [[SecuritySetController alloc] init];
        [self.navigationController pushViewController:tempVc2 animated:YES];
        
    }else if([tempStr isEqual:@"关于我们"]){
        AboutWeController *tempVc3 = [[AboutWeController alloc] init];
        [self.navigationController pushViewController:tempVc3 animated:YES];
        
    }else if([tempStr isEqual:@"联系我们"]){
        CallViewController *tempVc4 = [[CallViewController alloc] init];
        [self.navigationController pushViewController:tempVc4 animated:YES];
        
    }else if([tempStr isEqual:@"检查更新"]){
        
        if ([mp_localVersion isEqualToString:mp_serverVersion]) {
            [self mpShowAlert:@"当前已是最新版本！"];
            
        }else{
            [self mpShowAlertUPdata:@"发现新的应用版本，是否立即更新！"];
        }
    }
}
/**
 提示 弹出框
 */
- (void)mpShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
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
/**
 提示更新 弹出框
 */
- (void)mpShowAlertUPdata:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/%E6%81%92%E4%B8%B0%E5%B9%BF%E7%9B%8A/id1319671449?mt=8"]];
                                                              
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


#pragma **************UIImagePickerControllerDelegate**************************


/**
 保存图片后到相册后，调用的相关方法，查看是否保存成功
 
 @param paramImage <#paramImage description#>
 @param paramError <#paramError description#>
 @param paramContextInfo <#paramContextInfo description#>
 */
-(void)imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}
// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSLog(@"Picker returned successfully.");
    NSLog(@"%@---", info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    picker.allowsEditing = NO;
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
            // 保存图片到相册中
            SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
            
            UIImageWriteToSavedPhotosAlbum(theImage, self,selectorToCall, NULL);
            
        } else {
            // 照片的原数据
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        [mp_headViewBtn setImage:theImage forState:UIControlStateNormal];
        [self pushHeadViewToServer:theImage];
        
        
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        // 判断获取类型：视频 //获取视频文件的url
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //创建ALAssetsLibrary对象并将视频保存到媒体库
        // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        // 将视频保存到相册中
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
            if (!error) {
                NSLog(@"captured video saved with no error.");
            }else{
                NSLog(@"error occured while saving the video:%@", error);
            } }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushHeadViewToServer:(UIImage *)image{
    
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    [[shareDelegate shareNSUserDefaults] setObject:imageData forKey:@"LOGO"];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSDictionary *mpDic =@{@"auth_session":oldSession,
                           @"logo":@"头像.png"
                           };
    [manager POST:PUSHLOGO_URL parameters:mpDic constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
       
        NSData *imageData =UIImageJPEGRepresentation(image,0.3);
        NSString *fileName = @"头像.png";
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"logo"
                                fileName:fileName
                                mimeType:@"image/png"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        //上传成功
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
    }];

}

// 当用户取消时，调用该方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 从相册获取图片和视频数据
- (void)ClickShowPhotoAction:(id)sender{
    if ([self isPhotoLibraryAvailable]){
        UIImagePickerController *controller = [[UIImagePickerController alloc] init]; [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        // 设置类型
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        if ([self canUserPickPhotosFromPhotoLibrary]){
            [mediaTypes addObject:( NSString *)kUTTypeImage];
        }
        if ([self canUserPickVideosFromPhotoLibrary]){
            [mediaTypes addObject:( NSString *)kUTTypeMovie];
        }
        [controller setMediaTypes:mediaTypes]; [controller setDelegate:self];
        // 设置代理
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除菊花进度条
    [[shareDelegate shareZHProgress] removeFromSuperview];
}
/**
 
 @return 判断设备是否有摄像头
 */
-(BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/**
 
 @return 判断设备前摄像头是否可用
 */
-(BOOL)isFrontCameraAvailable{
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

/**
 
 @return 判断设备后摄像头是否可用
 */
-(BOOL)isRearCameraAvailable{
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

/**
 @param paramMediaType 拍照
 @param paramSourceType 视频
 @return  判断是否支持的媒体类型
 
 */
-(BOOL)cameraSupportsMedia:(NSString*)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result=NO;
    if ([paramMediaType length]==0) {
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray*availableMediaTypes=[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
    /**
     
     @return 检测摄像头是否支持录音
     */
}
-(BOOL)doesCameraSupportShootingVideos{
    /*在此处注意我们要将MobileCoreServices 框架添加到项目中， 然后将其导入：#import <MobileCoreServices/MobileCoreServices.h> 。
     不然后出现错误使用未声明的标识符 'kUTTypeMovie' */
    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

/**
 
 @return 检测摄像头是否支持拍照
 */
-(BOOL)doesCameraSupportTakingPhotos{
    /*在此处注意我们要将MobileCoreServices 框架添加到项目中， 然后将其导入：#import <MobileCoreServices/MobileCoreServices.h> 。不然后出现错误使用未声明的标识符 'kUTTypeImage' */
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

/**
 
 @return 检测相册是否可用
 */
-(BOOL)isPhotoLibraryAvailable{
    
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 
 @return 是否可以在相册中选择 视频
 */
-(BOOL)canUserPickVideosFromPhotoLibrary{
    
    return [self cameraSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 
 @return 检测是否可在相册中选着 照片
 */
-(BOOL)canUserPickPhotosFromPhotoLibrary{
    
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
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
