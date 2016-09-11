//
//  RunTimeManage.h
//  AllStudy
//
//  Created by majunjie on 16/5/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunTimeManage : NSObject
//获取对象的私有属性以及相对应的值
+(NSDictionary *)getAllPropertyNamesAndValuesWithClassName:(id)className ;

+(void)getAttributeWithClassName:(id)className;

+(void)getAllMethodsWithClassName:(id)className;

+(NSArray *)getAllMemberVariables:(id)className;

+(void)methodSwizzlingAboutOldClassName:(id)oldClassName WithOldMethod:(SEL)oldMethod WithNewClassName:(id)newClassName WithNewMethod:(SEL)newMethod;

//+ (id)addAttributeAboutObject:(id)object WithName:(NSString *)name WithType:(objc_AssociationPolicy)type ;
@end
