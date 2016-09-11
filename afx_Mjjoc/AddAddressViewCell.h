//
//  AddAddressViewCell.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "UserAddressModel.h"
#import <UIKit/UIKit.h>


@interface AddAddressViewCell : UITableViewCell <UITextFieldDelegate> {
    
    UserAddressModel *userAddressModel;
}
@property (nonatomic , strong) UIButton *markBtn;
@property (nonatomic , strong) UITextField *inPutTextFiled;
@property (nonatomic , strong) UserAddressModel *userAddressModel;
@property (nonatomic , strong) UserAddressModel *model;
- (void)setContentWithObject:(NSArray *)object AtIndexPath:(NSIndexPath *)indexPath;
//- (void)setContentAbout:(UserAddressModel *)model WithObject:(NSArray *)object AtIndexPath:(NSIndexPath *)indexPath;
@end
