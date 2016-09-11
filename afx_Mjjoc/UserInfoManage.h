//
//  UserInfoManage.h
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/11.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManage : NSObject

//密码
+ (BOOL) validatePassword:(NSString *)passWord;


//邮箱
+ (BOOL) validateEmail:(NSString *)email;


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;


+(void)saveAddressInfo:(NSDictionary *)addressInfo WithName:(NSString *)name;

@end
