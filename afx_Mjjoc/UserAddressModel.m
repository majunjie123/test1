//
//  UserAddressModel.m
//  afx_Mjjoc
//
//  Created by majunjie on 16/6/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "UserAddressModel.h"
#import <objc/runtime.h>
@implementation UserAddressModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //利用runTime进行归档
    //利用个数取出对应的属性（kvc）属性的名称
    //通过runtime来取出属性
    unsigned int count=0;
    Ivar *ivars=class_copyIvarList([self class], &count);
    for(int i=0;i<count;i++){
        Ivar ivar=ivars[i];
        const char *name=ivar_getName(ivar);
        NSString *key=[NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        
        unsigned int count=0;
        Ivar *ivars=class_copyIvarList([self class], &count);
        for(int i=0;i<count;i++){
            Ivar ivar=ivars[i];
            const char *name=ivar_getName(ivar);
            NSString *key=[NSString stringWithUTF8String:name];
            //            id value=[self valueForKey:key];
            id value=[aDecoder decodeObjectForKey:key];
        }
        free(ivars);
    }
    return self;
}
@end
