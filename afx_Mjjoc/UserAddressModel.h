//
//  UserAddressModel.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAddressModel : NSObject<NSCoding>

@property (nonatomic , strong) NSString *u_name;
@property (nonatomic , strong) NSString *u_sex;
@property (nonatomic , strong) NSString *u_tel;
@property (nonatomic , strong) NSString *u_city;
@property (nonatomic , strong) NSString *u_homeAddress;
@property (nonatomic , strong) NSString *u_select;
@property(nonatomic,strong) NSString *u_id;
@end
