//
//  RunTimeManage.m
//  AllStudy
//
//  Created by majunjie on 16/5/10.
//  Copyright © 2016年 majunjie. All rights reserved.
//

#import "RunTimeManage.h"
#import <objc/runtime.h>

static char attributeName;

@implementation RunTimeManage
/**
 *  获取对象的所有属性以及相对应的值
 *
 *  @param className 一个实例化的对象
 *
 *  @return 字典（属性－值）
 */
+ (NSDictionary *)getAllPropertyNamesAndValuesWithClassName:(id)className {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([className class], &count);

    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);

        // 得到属性名
        NSString *propertyName = [NSString stringWithUTF8String:name];
        if([className valueForKey:propertyName]){
        // 获取属性值
        id propertyValue = [className valueForKey:propertyName];
            
        if (propertyValue && propertyValue != nil) {
            [dict setObject:propertyValue forKey:propertyName];
        }
    }
    }
    // 记得释放
    free(properties);
    return dict;
}
/**
 *  获取一个类（系统类也可以,包括未在.h中没有声名的属性）的所有私有属性
 *
 *  @param className 类名（注意：不能传对象）
 */
+ (void)getAttributeWithClassName:(id)className {

    u_int count;
    objc_property_t *properties = class_copyPropertyList(className, &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"%@", strName);
    }
}

/**
 *  获取一个类（系统类也可以,包括未在.h中没有声名的属性和成员变量）的所有私有属性和成员变量
 *
 *  @param className 类名（注意：不能传对象）
 *
 *  @return 一个数组
 */
+ (NSArray *)getAllMemberVariables:(id)className {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(className, &count);

    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < count; ++i) {
        Ivar variable = ivars[i];

        const char *name = ivar_getName(variable);
        NSString *varName = [NSString stringWithUTF8String:name];

        [results addObject:varName];
    }

    return results;
}
/**
 *  获取某个类（包括系统类）的所有方法，包括系统类以及其中没有在.h声明的方法
 *
 *  @param className 类名（注意：不能传对象）
 */
+ (void)getAllMethodsWithClassName:(id)className {
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(className, &outCount);

    for (int i = 0; i < outCount; ++i) {
        Method method = methods[i];

        // 获取方法名称，但是类型是一个SEL选择器类型
        SEL methodSEL = method_getName(method);
        // 需要获取C字符串
        const char *name = sel_getName(methodSEL);
        // 将方法名转换成OC字符串
        NSString *methodName = [NSString stringWithUTF8String:name];

        // 获取方法的参数列表
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"方法名：%@, 参数个数：%d", methodName, arguments);
    }

    // 记得释放
    free(methods);
}

/**
 *  方法交换也适用系统API
 *
 *  @param oldClassName 调用旧方法的类名
 *  @param oldMethod    旧方法
 *  @param newClassName 调用新方法的类名
 *  @param newMethod    新方法
 */
+ (void)methodSwizzlingAboutOldClassName:(id)oldClassName WithOldMethod:(SEL)oldMethod WithNewClassName:(id)newClassName WithNewMethod:(SEL)newMethod {

    Method old_Method = class_getInstanceMethod(oldClassName, oldMethod);
    Method new_Method = class_getInstanceMethod(newClassName, newMethod);
    method_exchangeImplementations(old_Method, new_Method);
}
//属性扩展
//+ (id)addAttributeAboutObject:(id)object WithName:(NSString *)name WithType:(objc_AssociationPolicy)type {
//    [self setAttributeNameWithObject:object WithAttributeName:name WithType:type];
//
//   return  [self AttributeNameWithObject:object];
//}
//+ (id)AttributeNameWithObject:(id)Object {
//    return objc_getAssociatedObject(Object, &attributeName);
//}
//
//+ (void)setAttributeNameWithObject:(id)Object WithAttributeName:(NSString *)attributeName WithType:(objc_AssociationPolicy)type {
//
//    objc_setAssociatedObject(Object, &attributeName, attributeName, type);
//}

@end
