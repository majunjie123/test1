//
//  ScanViewController.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/15.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController

@property (strong,nonatomic)AVCaptureDevice * device;

@property (strong,nonatomic)AVCaptureDeviceInput * input;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;

@property (strong,nonatomic)AVCaptureSession * session;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (strong,nonatomic)UIView *boxView;

@property (nonatomic , strong) CALayer *scanLayer;

@property (nonatomic) BOOL lastResult;//判断上一次调用成功

@end
