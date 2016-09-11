//
//  SuperViewController.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/9.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "ConsumerAddressViewController.h"
#import "ScanViewController.h"
#import "SuperViewController.h"
@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
}
- (void)setNav {
    self.navigationController.navigationBarHidden = YES;
    UIView *ui_bgView = [[UIView alloc] init];
    ui_bgView.backgroundColor = HOMETTABAR_color;
    [self.view addSubview:ui_bgView];
    [ui_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.height.equalTo(@64);
    }];

    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_magnifying_glass"] forState:UIControlStateNormal];
    [ui_bgView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ui_bgView.mas_right).offset(-10);
        make.top.equalTo(ui_bgView.mas_top).offset(27);
        make.height.width.equalTo(@30);
    }];

    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn addTarget:self action:@selector(pushScanView) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_black_scancode"] forState:UIControlStateNormal];
    [ui_bgView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_bgView.mas_left).offset(10);
        make.top.equalTo(ui_bgView.mas_top).offset(27);
        make.height.width.equalTo(@30);
    }];

    UIButton *centerBgButton = [[UIButton alloc] init];
    centerBgButton.backgroundColor = [UIColor clearColor];
    [centerBgButton addTarget:self action:@selector(pushLocationView) forControlEvents:UIControlEventTouchUpInside];
    [ui_bgView addSubview:centerBgButton];
    [centerBgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_bgView.mas_top).offset(37);
        make.centerX.equalTo(ui_bgView.mas_centerX).offset(0);
        make.width.equalTo(@120);
        make.height.equalTo(@25);
    }];

    UILabel *centerLeftLabel = [[UILabel alloc] init];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"配送至"];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 3)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
    centerLeftLabel.attributedText = AttributedStr;
    [centerBgButton addSubview:centerLeftLabel];
    [centerLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerBgButton.mas_top).offset(5);
        make.left.equalTo(centerBgButton.mas_left).offset(5);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    UILabel *centerRightLabel = [[UILabel alloc] init];
    centerRightLabel.text = @"地址";
    [centerBgButton addSubview:centerRightLabel];
    [centerRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerBgButton.mas_top).offset(0);
        make.right.equalTo(centerBgButton.mas_right).offset(-5);
        make.width.equalTo(@60);
        make.height.equalTo(@25);
    }];
}
- (void)pushLocationView {
    ConsumerAddressViewController *ConsumerAddressView = [[ConsumerAddressViewController alloc] init];
    [self.navigationController pushViewController:ConsumerAddressView animated:NO];
}
- (void)pushScanView {

    ScanViewController *ScanView = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:ScanView animated:NO];
}

//- (void)viewWillDisappear:(BOOL)animated {
//
//    self.navigationController.tabBarController.tabBar.hidden = YES;
//}
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
