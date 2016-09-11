//
//  FMDBManage.h
//  ChengGuan
//
//  Created by Tiank on 14-4-3.
//  Copyright (c) 2014年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FMDBManage : NSObject

+ (void) insertProgramWithObject:(id) object;

+ (NSMutableArray *)getDataFromTable:(id)table WithString:(NSString *) string;

+ (void) deleteFromTable:(id)table WithString:(NSString *) string;

+ (void) updateTable:(id)table setString:(NSString *) setString WithString:(NSString *) string;

+(NSMutableArray *)getDataFromTable:(id)table;

+(NSMutableArray *)getDataID:(NSString *)string;

+(void) updateTable:(id)table WithKey:(NSString *) key WithValue:(NSString *)Value WithString:(NSString *)string;
//升级数据库，删除用户登录数据
//+ (void) updateDBWithNewVersion;

@end
