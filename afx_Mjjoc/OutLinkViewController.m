//
//  OutLinkViewController.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/15.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "OutLinkViewController.h"

@interface OutLinkViewController ()

@end

@implementation OutLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, -20,SCREEN_WIDTH, SCREEN_HEIGHT+84)];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.outLink]]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.tabBarController.tabBar.hidden =YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.tabBarController.tabBar.hidden = YES;
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
