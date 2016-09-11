//
//  AddAdressViewController.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "AddAddressViewCell.h"
#import "AddAdressViewController.h"
#import "ConsumerAddressViewController.h"
#import "FMDBManage.h"
#import "SVProgressHUD.h"
#import "SelectCityViewController.h"
#import "UserAddressModel.h"
#import "UserInfoManage.h"
#import "ConsumerAddressViewController.h"

@interface AddAdressViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *myTableView;
    NSArray *viewDataArr;
    UserAddressModel *userAddressModel;
    // NSMutableDictionary *infoDictionary;
    UIButton *selectCityBtn;
    UIView *ui_footView;
    UIButton *deleteAddressBtn;
}

@end

@implementation AddAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", _userAddressModel_Edit);

    userAddressModel = [[UserAddressModel alloc] init];
    [self setViewData];
    [self setNav];
}
- (void)setViewData {
    viewDataArr = [NSArray arrayWithObjects:@[@"联系人", @"收货人姓名"],
                                            @[@"手机号码", @"请输入你的联系方式"],
                                            @[@"所在城市", @"请选择城市"],
                                            @[@"所在地区", @"请输入你的住宅，大厦，或学校"],
                                            @[@"详细地址", @"请输入楼号门牌号等详细信息"], nil];
}

- (void)setNav {
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor lightTextColor];

    UIView *ui_bgView = [[UIView alloc] init];
    ui_bgView.backgroundColor = HOMETTABAR_color;
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

    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    [ui_bgView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ui_bgView.mas_right).offset(-10);
        make.top.equalTo(ui_bgView.mas_top).offset(17);
        make.height.width.equalTo(@45);
    }];

    UILabel *centerBgLab = [[UILabel alloc] init];
    centerBgLab.backgroundColor = [UIColor clearColor];
    centerBgLab.textAlignment = NSTextAlignmentCenter;
    centerBgLab.text = @"修改地址";
    [ui_bgView addSubview:centerBgLab];
    [centerBgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_bgView.mas_top).offset(27);
        make.centerX.equalTo(ui_bgView.mas_centerX).offset(0);
        make.width.equalTo(@120);
        make.height.equalTo(@25);
    }];
    myTableView = [[UITableView alloc] init];
    //    myTableView.backgroundColor=TABELVIEWBG_color;
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(84);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];

    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.delegate = self;
    myTableView.dataSource = self;
        
    deleteAddressBtn=[[UIButton alloc]init];
    [deleteAddressBtn setBackgroundColor:[UIColor colorWithRed:105 green:105 blue:105 alpha:1.0]];
    [self.view addSubview:deleteAddressBtn];
    [deleteAddressBtn addTarget:self action:@selector(PushAddAdressView) forControlEvents:UIControlEventTouchUpInside];
    [deleteAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@54);
    }];
    
    UILabel *addAdressTextLab=[[UILabel alloc]init];
    addAdressTextLab.backgroundColor=HOMETTABAR_color;
    addAdressTextLab.textAlignment=NSTextAlignmentCenter;
    addAdressTextLab.text=@"删除收货地址";
    [deleteAddressBtn addSubview:addAdressTextLab];
    [addAdressTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deleteAddressBtn.mas_top).offset(7);
        make.bottom.equalTo(deleteAddressBtn.mas_bottom).offset(-7);
        make.centerX.equalTo(deleteAddressBtn.mas_centerX).offset(0);
        make.width.equalTo(@160);
    }];
}
// 返回每一行cell的样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);

    static NSString *ID_AddAddressViewCell = @"AddAddressViewCell";
    AddAddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_AddAddressViewCell];

    if (cell == nil) {

        cell = [[AddAddressViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID_AddAddressViewCell];
    }
    [cell.markBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == 3) {
        cell.inPutTextFiled.text = userAddressModel.u_city;
    }

    cell.userAddressModel = userAddressModel;
    cell.model = _userAddressModel_Edit;
    //    [cell setContentAbout:_userAddressModel_Edit WithObject:viewDataArr AtIndexPath:indexPath];
    [cell setContentWithObject:viewDataArr AtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
// 返回每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s--%@", __func__, indexPath);
    return 60;
}
//  返回每一块有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}
- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)selectCity {
    //    [self popRootView];
    SelectCityViewController *vc = [[SelectCityViewController alloc] init];
    [vc returnText:^(NSString *cityname) {
        userAddressModel.u_city = cityname;
        _userAddressModel_Edit.u_city=cityname;
        //        [infoDictionary setObject:cityname forKey:@"cityName"];
        [myTableView reloadData];

    }];

    [self.navigationController pushViewController:vc animated:NO];
}
-(void)PushAddAdressView{
    [FMDBManage deleteFromTable:[UserAddressModel class] WithString:[NSString stringWithFormat:@"u_id='%@'",_userAddressModel_Edit.u_id ]];
    ConsumerAddressViewController *ConsumerAddressView=[[ConsumerAddressViewController alloc]
                                                        init];
    [self.navigationController pushViewController:ConsumerAddressView animated:NO];

}
- (void)popRootView {
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {

    self.navigationController.tabBarController.tabBar.hidden = YES;
}
-(void)updateDB{
   [FMDBManage updateTable:[userAddressModel class] WithKey:@"u_name" WithValue:_userAddressModel_Edit.u_name WithString:[NSString stringWithFormat:@"u_id='%@'",_userAddressModel_Edit.u_id ]];
       [FMDBManage updateTable:[userAddressModel class] WithKey:@"u_tel" WithValue:_userAddressModel_Edit.u_tel WithString:[NSString stringWithFormat:@"u_id='%@'",_userAddressModel_Edit.u_id ]];
       [FMDBManage updateTable:[userAddressModel class] WithKey:@"u_city" WithValue:_userAddressModel_Edit.u_city WithString:[NSString stringWithFormat:@"u_id='%@'",_userAddressModel_Edit.u_id ]];
       [FMDBManage updateTable:[userAddressModel class] WithKey:@"u_homeAddress" WithValue:_userAddressModel_Edit.u_homeAddress WithString:[NSString stringWithFormat:@"u_id='%@'",_userAddressModel_Edit.u_id ]];
   [FMDBManage updateTable:[userAddressModel class] WithKey:@"u_sex" WithValue:_userAddressModel_Edit.u_sex WithString:[NSString stringWithFormat:@"u_id='%@'",_userAddressModel_Edit.u_id ]];
}
- (void)saveAddress {

    //判断是否符合填写规则

    if (!(_userAddressModel_Edit == nil)) {
        //修改地址
        userAddressModel = _userAddressModel_Edit;
        if ([self testAdress]) {
            [self updateDB];
            ConsumerAddressViewController *ConsumerAddressView = [[ConsumerAddressViewController alloc] init];
            [self.navigationController pushViewController:ConsumerAddressView animated:NO];
        }
    } else {
        //增加地址
        if ([self testAdress]) {
            [FMDBManage insertProgramWithObject:userAddressModel];
            ConsumerAddressViewController *ConsumerAddressView = [[ConsumerAddressViewController alloc] init];
            [self.navigationController pushViewController:ConsumerAddressView animated:NO];
        }
     
    }
}

- (BOOL)testAdress {
    NSLog(@"%@", userAddressModel.u_name);
    if (userAddressModel.u_name == nil || [userAddressModel.u_name isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名！"];
        return NO;
    }
    if (userAddressModel.u_sex == nil || [userAddressModel.u_sex isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别！"];
        return NO;
    }
    BOOL result = [UserInfoManage validateMobile:userAddressModel.u_tel];
    if (!result) {
        if (userAddressModel.u_tel == nil || [userAddressModel.u_tel isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"请输入您的手机号！"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"您的手机号有误！"];
        }
        return NO;
    }
    if (userAddressModel.u_city == nil || [userAddressModel.u_city isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市！"];
        return NO;
    }
    if (userAddressModel.u_homeAddress == nil || [userAddressModel.u_homeAddress isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址！"];
        return NO;
    }

    return YES;
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
