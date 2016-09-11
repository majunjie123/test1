//
//  ConsumerAddressViewController.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/9.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "ConsumerAddressViewController.h"
#import "AddAdressViewController.h"
#import "adressViewCell.h"
@interface ConsumerAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    UIButton *addAddressBtn;
    NSArray *infoAddressArr;
}
@end

@implementation ConsumerAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBarHidden=NO;
    infoAddressArr=[FMDBManage getDataFromTable:@"UserAddressModel"];
    [self setNav];
   
}

- (void)setNav {
    self.view.backgroundColor=TABELVIEWBG_color;
    self.navigationController.navigationBarHidden = YES;
    UIView *ui_bgView = [[UIView alloc] init];
    ui_bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ui_bgView];
    [ui_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.height.equalTo(@64);
    }];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn addTarget:self action:@selector(popRootView) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
    [ui_bgView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ui_bgView.mas_left).offset(10);
        make.top.equalTo(ui_bgView.mas_top).offset(27);
        make.height.width.equalTo(@30);
    }];
    
    UILabel *centerBgLab = [[UILabel alloc] init];
    centerBgLab.backgroundColor = [UIColor clearColor];
    centerBgLab.textAlignment=NSTextAlignmentCenter;
    centerBgLab.text=@"我的收货地址";
    [ui_bgView addSubview:centerBgLab];
    [centerBgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_bgView.mas_top).offset(27);
        make.centerX.equalTo(ui_bgView.mas_centerX).offset(0);
        make.width.equalTo(@120);
        make.height.equalTo(@25);
    }];
    myTableView=[[UITableView alloc]init];
    myTableView.backgroundColor=TABELVIEWBG_color;
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(74);
        make.bottom.equalTo(self.view.mas_bottom).offset(-54);
         make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.tableFooterView=
    
    addAddressBtn=[[UIButton alloc]init];
    [addAddressBtn setBackgroundColor:[UIColor colorWithRed:105 green:105 blue:105 alpha:1.0]];
    [self.view addSubview:addAddressBtn];
    [addAddressBtn addTarget:self action:@selector(PushAddAdressView) forControlEvents:UIControlEventTouchUpInside];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
         make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@54);
    }];
    
    UILabel *addAdressTextLab=[[UILabel alloc]init];
    addAdressTextLab.backgroundColor=HOMETTABAR_color;
    addAdressTextLab.textAlignment=NSTextAlignmentCenter;
    addAdressTextLab.text=@"新增收货地址";
    [addAddressBtn addSubview:addAdressTextLab];
    [addAdressTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addAddressBtn.mas_top).offset(7);
        make.bottom.equalTo(addAddressBtn.mas_bottom).offset(-7);
        make.centerX.equalTo(addAddressBtn.mas_centerX).offset(0);
        make.width.equalTo(@160);
    }];
    
}
-(void)popRootView{
    [self.navigationController popToRootViewControllerAnimated:NO];

}
-(void)PushAddAdressView{
    AddAdressViewController *AddAddressView=[[AddAdressViewController alloc]init];
    [self.navigationController pushViewController:AddAddressView animated:NO];

}
-(void)PushEditAdressView:(UIButton *)sender{
    AddAdressViewController *EditAdressView=[[AddAdressViewController alloc]init];
    
    [self.navigationController pushViewController:EditAdressView animated:NO];
   //[FMDBManage getDataFromTable:[UserAddressModel class] WithString:userAddressModel_Edit.]
    
    
    EditAdressView.userAddressModel_Edit=infoAddressArr[sender.tag];
    [FMDBManage getDataID:EditAdressView.userAddressModel_Edit.u_tel];
   // EditAdressView.userAddressModel_Edit.u_id=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    
}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.tabBarController.tabBar.hidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

// 返回每一行cell的样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    static NSString *ID = @"adressViewCell";
    adressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[adressViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
     [cell setContentWithObject:infoAddressArr AtIndexPath:indexPath];
    cell.editButton.tag=indexPath.row;
    [cell.editButton addTarget:self action:@selector(PushEditAdressView:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
// 返回每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s--%@",__func__,indexPath);
    return 80;
}
//  返回每一块有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [infoAddressArr count];
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
