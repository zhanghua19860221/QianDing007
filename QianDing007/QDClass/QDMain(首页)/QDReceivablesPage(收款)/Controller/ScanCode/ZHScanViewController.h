//
//  ZHScanViewController.h
//  ZhangHuaSummary
//
//  Created by 张华 on 17/12/7.
//  Copyright © 2017年 zhanghua0221. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define TOP (SC_HEIGHT-220)/2
#define LEFT (SC_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface ZHScanViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong , nonatomic) AVCaptureDevice * device;
@property (strong , nonatomic) AVCaptureDeviceInput * inPut;
@property (strong , nonatomic) AVCaptureMetadataOutput * outPut;
@property (strong , nonatomic) AVCaptureSession * session;
@property (strong , nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (strong , nonatomic) UIImageView * line;
@property (strong ,nonatomic) UIButton *butPhotoList;// 调用相册图片列表
@property (strong ,nonatomic) UIImageView *imageView;//把相册里面的图片展示在此视图上

@end
