//
//  ScanViewController.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/15.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "OutLinkViewController.h"
#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ScanViewController () <AVCaptureMetadataOutputObjectsDelegate> {

    AVCaptureVideoPreviewLayer *scanView;
    NSTimer *timer;
}

@end

@implementation ScanViewController

- (void)viewDidLoad {

    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [leftBtn addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(27);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];

    // Device

    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    // Input

    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    // Output

    _output = [[AVCaptureMetadataOutput alloc] init];

    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    // Session

    _session = [[AVCaptureSession alloc] init];

    [_session setSessionPreset:AVCaptureSessionPresetHigh];

    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    // Preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];

    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;

    _preview.frame = self.view.layer.bounds;

    [self.view.layer insertSublayer:_preview atIndex:0];

    //10.设置扫描范围
    _output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.5f, 0.6f);

    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f, self.view.bounds.size.height * 0.3f, self.view.bounds.size.width - self.view.bounds.size.width * 0.4f, self.view.bounds.size.height - self.view.bounds.size.height * 0.6f)];
    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [self.view addSubview:_boxView];

    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    // Start
    [_session startRunning];
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {

            result = metadataObj.stringValue;
            NSRange range = [result rangeOfString:@"http"];
            if (range.length > 0) {
                OutLinkViewController *outLinkView = [[OutLinkViewController alloc] init];
                outLinkView.outLink = result;
                [self.navigationController pushViewController:outLinkView animated:NO];
                //[self presentViewController:outLinkView animated:YES completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:NO];
            }
            [self stopReading];
        }
    }
}
- (void)reportScanResult:(NSString *)result {
    [self stopReading];
    if (!_lastResult) {
        return;
    }
    _lastResult = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"二维码扫描"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:nil];
    [alert show];
    // 以下处理了结果，继续下次扫描
    _lastResult = YES;
}
- (void)stopReading {
    // 停止会话
    [_session stopRunning];
    [timer invalidate];
    _session = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveScanLayer:(NSTimer *)timer {
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    } else {
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.tabBarController.tabBar.hidden = YES;
}
- (void)popView {

    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
  
    self.navigationController.tabBarController.tabBar.hidden = NO;
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
