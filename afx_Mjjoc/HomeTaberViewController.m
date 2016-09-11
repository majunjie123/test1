//
//  HomeTaberViewController.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/8.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "HomeTaberViewController.h"
#import "MMBaseNavigationController.h"

@interface HomeTaberViewController ()

@end

@implementation HomeTaberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSArray *childItemsArray = @[
                                 @{
                                     TabbarVC: @"MJJFristViewController",
                                     TabbarTitle: @"首页",
                                     TabbarImage: @"v2_home",
                                     TabbarSelectedImage: @"v2_home_r",
                                     //TabbarItemBadgeValue: @(self.sessionUnreadCount)
                                     },
                                 
                                 @{ TabbarVC: @"MJJMallViewController",
                                    TabbarTitle: @"闪电超市",
                                    TabbarImage: @"v2_order",
                                    TabbarSelectedImage: @"v2_order_r",
                                    //TabbarItemBadgeValue: @(self.systemUnreadCount)
                                    },
                                 
                                 @{
                                     TabbarVC: @"MJJShopCarViewController",
                                     TabbarTitle: @"购物车",
                                     TabbarImage: @"shopCart",
                                     TabbarSelectedImage: @"shopCart_r",
                                     },
                                @{
                                     TabbarVC: @"MJJMyViewController",
                                     TabbarTitle: @"我的",
                                     TabbarImage: @"v2_my",
                                     TabbarSelectedImage: @"v2_my_r",
                                     //TabbarItemBadgeValue: @(self.customSystemUnreadCount)
                                     
                                     }
                                 ];
    
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[TabbarVC]) new];
        //vc.title = dict[TabbarTitle];
        MMBaseNavigationController *nav = [[MMBaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[TabbarTitle];
        item.image = [UIImage imageNamed:dict[TabbarImage]];
        
        item.selectedImage = [[UIImage imageNamed:dict[TabbarSelectedImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : HOMETTABAR_color} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
    }];
    
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
