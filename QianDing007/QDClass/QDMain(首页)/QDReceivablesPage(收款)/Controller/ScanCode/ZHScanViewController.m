//
//  ZHScanViewController.m
//  ZhangHuaSummary
//
//  Created by 张华 on 17/12/7.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import "ZHScanViewController.h"
#import "SuccessScanController.h"
#import "ReceivablesPage.h"
@interface ZHScanViewController (){
    
    int num;
    BOOL upOrdown;
    CAShapeLayer *cropLayer;
    NSString *Str;
}
@end

@implementation ZHScanViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatAllClass];
    [self connectInputAndOutput];
    [self setTypeCode];
    [self creatCropLayer];
    [self addQRView];
    [self startScan];
    [self zhCreateNavgation];

    
    // Do any additional setup after loading the view.
}

/**
 判断是否有摄像头／创建必要对象
 */
- (void)creatAllClass{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.inPut  = [AVCaptureDeviceInput deviceInputWithDevice:self.device  error:nil];
    
    self.outPut = [[AVCaptureMetadataOutput alloc] init];
    [self.outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SC_HEIGHT;
    CGFloat left = LEFT/SC_WIDTH;
    CGFloat width = 220/SCALE_X;
    CGFloat height = 220/SCALE_X;
    ///top 与 left 互换  width 与 height 互换
    [self.outPut setRectOfInterest:CGRectMake(top,left, height, width)];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
}

/**
 连接输入输出
*/
- (void)connectInputAndOutput{
    
    if ([self.session canAddInput:self.inPut]){
        
        [self.session addInput:self.inPut];
    }
    
    if ([self.session canAddOutput:self.outPut]){
        
        [self.session addOutput:self.outPut];
    }
}

/**
 设置条码类型
 */
- (void)setTypeCode{
    
    self.outPut.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,//二维码
                                 //以下为条形码，如果项目只需要扫描二维码，下面都不要写
                                 AVMetadataObjectTypeEAN13Code,
                                 AVMetadataObjectTypeEAN8Code,
                                 AVMetadataObjectTypeUPCECode,
                                 AVMetadataObjectTypeCode39Code,
                                 AVMetadataObjectTypeCode39Mod43Code,
                                 AVMetadataObjectTypeCode93Code,
                                 AVMetadataObjectTypeCode128Code,
                                 AVMetadataObjectTypePDF417Code];
    
}
/**
 创建透明度蒙板
 */
- (void)creatCropLayer{
    
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, kScanRect);
    CGPathAddRect(path, nil, self.view.bounds);
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    [cropLayer setNeedsDisplay];
    [self.view.layer addSublayer:cropLayer];
    
}

/**
 添加扫描画面
 */
- (void)addQRView{

    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
}

/**
 开始扫描
 */
- (void)startScan{

    [self.session startRunning];
}

/**
 扫描外部二维码获取数据结果
 
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    sleep(2);
    if ([metadataObjects count] >0){
        [self.session stopRunning];
        //    //创建请求菊花进度条
        [[UIApplication sharedApplication].keyWindow addSubview:[shareDelegate shareZHProgress]];
        [[shareDelegate shareZHProgress] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo([UIApplication sharedApplication].keyWindow);
            make.height.width.mas_equalTo(100);
        }];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = [NSString stringWithFormat:@"%@",metadataObject.stringValue];
        NSLog(@"stringValue = %@",stringValue);
        
        if([shareDelegate deptNumInputShouldNumber:stringValue]){
            [self backController:@"无法识别的二维码。"];
            
            return;
        }

        [self getUrlDateSource:stringValue];
 
    }
    

}

/**
  导航栏返回按钮
 */
- (void)zhCreateNavgation{
    
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
        
    }];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhBackBtnClick)];
    
    [view addGestureRecognizer:tapGesturRecognizer];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"返回图标白色"] forState:UIControlStateNormal];
    [view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(zhBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.left.equalTo(view).offset(15);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"返回上一页";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:18];
    [label setTextColor:COLORFromRGB(0xffffff)];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.left.equalTo(backBtn.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(44);
    }];
    
}
- (void)zhBackBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 获取完二维码数据之后 ，调取支付接口
 */
- (void)getUrlDateSource:(NSString*)urlStr{

    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    NSString *moneyStr = [[shareDelegate shareNSUserDefaults] objectForKey:@"money_count"];
    NSString *telePhone = [[shareDelegate shareNSUserDefaults] objectForKey:@"phone"];
    NSString *token = [NSString stringWithFormat:@"%@%@%@",urlStr,moneyStr,telePhone];
    NSString *md5_token = [MyMD5 md5:token];
    
    NSDictionary *Dic =@{@"auth_session":oldSession,
                         @"money":moneyStr,
                         @"coupon_pwd":urlStr,
                         @"amount_token":md5_token
                         
                         };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:[shareDelegate stringBuilder:SCANME_URL] parameters:Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            SuccessScanController *successVc = [[SuccessScanController alloc] init];
            successVc.order_num = responseObject[@"orderNo"];
            successVc.order_time = responseObject[@"reqTime"];
            successVc.money_count = responseObject[@"money"];
            successVc.order_status = responseObject[@"status"];
            [self.navigationController pushViewController:successVc animated:YES];
            
        }else{
            [self alertControllerMessage:responseObject[@"info"]];

        }
        //移除菊花进度条
        [[shareDelegate shareZHProgress] removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}
//由于要写两次，所以就封装了一个方法
-(void)alertControllerMessage:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@" 确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
//二维码不正确的时候 调取次弹出框
-(void)backController:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@" 确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ReceivablesPage class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning{
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
