//
//  AddAdressViewController.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAddressModel.h"
@interface AddAdressViewController : UIViewController
@property (nonatomic , strong)UserAddressModel *userAddressModel_Edit;
@property(nonatomic,strong)NSString *addressId;
@end
