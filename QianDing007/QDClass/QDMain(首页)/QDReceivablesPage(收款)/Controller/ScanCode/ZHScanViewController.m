//
//  ZHScanViewController.m
//  ZhangHuaSummary
//
//  Created by 张华 on 17/12/7.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import "ZHScanViewController.h"

@interface ZHScanViewController (){
    
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;

}
@end

@implementation ZHScanViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatAllClass];
    [self connectInputAndOutput];
    [self setTypeCode];
    [self creatCropLayer];
    [self configView];
    [self addQRView];
    [self startScan];
    [self zhCreateNavgation];

//  可以扫描相册二维码
//  [self createButtonForPhotoList];
    
    // Do any additional setup after loading the view.
}

/**
 创建设置扫描框
 */
-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}
-(void)animation1{
    
    if (upOrdown == NO) {
        
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
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
    
    self.outPut.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
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
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    if ([metadataObjects count] >0){
        
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];

        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
}


/**
 调用系统相册列表按钮
 */
-(void)createButtonForPhotoList{
    
    self.butPhotoList = [UIButton buttonWithType:UIButtonTypeCustom];
    self.butPhotoList.frame = CGRectMake(LEFT,TOP+220,200,50);
    self.butPhotoList.backgroundColor = [UIColor grayColor];
    [self.butPhotoList setTitle:@"相册列表操作按钮" forState:UIControlStateNormal];
    [self.butPhotoList addTarget:self action:@selector(butPhotoListClick) forControlEvents:UIControlEventTouchUpInside];
    self.butPhotoList.layer.cornerRadius = 20;
    self.butPhotoList.layer.masksToBounds = YES;
    [self.view addSubview:self.butPhotoList];
    
}
/**
 相册列表操作按钮点击事件
 */
-(void)butPhotoListClick{
    
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
#pragma ****************二维码扫描输出结果协议方法*******************************
/**
 二维码扫描输出结果协议方法

 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //设置数组，放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(image)]];
        //判断是否有数据（即是否是二维码）
        if (features.count >= 1) {
            //取第一个元素就是二维码所存放的文本信息
            CIQRCodeFeature *feature = features[0];
            NSString *scannedResult = feature.messageString;
            //通过对话框的形式呈现
            [self alertControllerMessage:scannedResult];
            
            
            
        }else{
            [self alertControllerMessage:@"这不是一个二维码"];
        }
    }];
}

//由于要写两次，所以就封装了一个方法
-(void)alertControllerMessage:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@" 确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
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
