//
//  FMDBManage.m
//  ChengGuan
//
//  Created by Tiank on 14-4-3.
//  Copyright (c) 2014年 xinhuamm. All rights reserved.
//

#import "FMDBManage.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import <objc/runtime.h>
#import "UserAddressModel.h"
//#import "UserObject.h"
//#import "MetaData.h"
static FMDatabase *db = nil;

@implementation FMDBManage

//反射读取对象属性
+ (NSArray*)propertyKeys:(id) object
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

//数据库路径
+(NSString *)databaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    return dbFilePath;
}

//数据库创建
+(void)creatDatabase
{
    db = [FMDatabase databaseWithPath:[self databaseFilePath]];
}

//表的创建
+(void)creatTableWithObject:(id) object
{
    //先判断数据库是否存在，如果不存在，创建数据库
    if (!db) {
        [self creatDatabase];
    }
    //判断数据库是否已经打开，如果没有打开，提示失败
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    //为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    //判断数据库中是否已经存在这个表，如果不存在则创建该表
    if([db tableExists:@"downloadTable"] == NO)
    {
        //获取对象所有key
        NSArray *keys = [self propertyKeys:object];
        
        NSString *sqlString = @"";
        
        NSString *headerString = [NSString stringWithFormat:@"create table %@ (u_id INTEGER PRIMARY KEY AUTOINCREMENT,",[object class]];
        NSString *footerString = @")";
        
        NSMutableString *midString=[NSMutableString stringWithCapacity:64];
       
        for (int i = 0; i < [keys count]; i++)
        {
            NSString *keyString = [keys objectAtIndex:i];
            if(![keyString isEqualToString:@"u_id"]){
            if (i == [keys count] - 2)
            {
                [midString appendFormat:@"%@ text",keyString];
                break;
            }
            [midString appendFormat:@"%@ text,",keyString];;
        }
        }
        sqlString = [NSString stringWithFormat:@"%@%@%@",headerString,midString,footerString];
        [db executeUpdate:sqlString];
    }
}

//programobject表插入数据
//插入数据
+ (void) insertProgramWithObject:(id) object
{
    NSString *tableName = [NSString stringWithFormat:@"%@",[object class]];
   
    if (!db)
    {
        [self creatTableWithObject:object];
    }
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:tableName])
    {
        [self creatTableWithObject:object];
    }

    //获取对象所有key
    NSArray *keys = [self propertyKeys:object];
    
    NSString *sqlString = @"";
    
    NSString *headerString = [NSString stringWithFormat:@"insert into %@ ",[object class]];
    
    NSMutableString *midKeyString=[NSMutableString stringWithCapacity:64];
    NSMutableString *midValueString=[NSMutableString stringWithCapacity:64];
    
    for (int i = 0; i < [keys count]; i++)
    {
        NSString *keyString = [keys objectAtIndex:i];
        NSString *valueString = [object valueForKey:keyString];
if(![keyString isEqualToString:@"u_id"]){
        if (i == [keys count] - 2)
        {
            [midKeyString appendFormat:@"%@",keyString];
            [midValueString appendFormat:@"\"%@\"",valueString];
            
            break;
        }
        
        [midKeyString appendFormat:@"%@,",keyString];
        [midValueString appendFormat:@"\"%@\",",valueString];
#ifdef DEBUG
        NSLog(@"----%@",valueString);
#endif
}
    }
    
    sqlString = [NSString stringWithFormat:@"%@(%@) values (%@)",headerString,midKeyString,midValueString];
    
    //-1表示没有数据
    sqlString = [sqlString stringByReplacingOccurrencesOfString:@"(null)" withString:@"-1"];
    
    [db executeUpdate:sqlString];
}

//program 表数据读取
//获取所有数据
+(NSMutableArray *)getDataFromTable:(id)table
{
    NSString *tableName = [NSString stringWithFormat:@"%@",table];
    
    if (!db)
    {
        [self creatDatabase];
    }
    
    if (![db open])
    {
        return nil;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:tableName])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *tableArray = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ ",tableName];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [db executeQuery:sqlString];
    
    NSArray *keys = nil;
    
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next])
    {
        id tmpObject = [[NSClassFromString(tableName) alloc] init];
        //获取对象所有key
        keys = [self propertyKeys:tmpObject];
        
        for (int i = 0; i < [keys count]; i++)
        {
            NSString *keyString = [keys objectAtIndex:i];
            [tmpObject setValue:[rs stringForColumn:keyString] forKey:keyString];
        }
        
        [tableArray addObject:tmpObject];
    }
    return tableArray;
}

//program 表数据读取
//获取所有数据
+(NSMutableArray *)getDataFromTable:(id)table WithString:(NSString *) string
{
    NSString *tableName = [NSString stringWithFormat:@"%@",table];
    
    if (!db)
    {
        [self creatDatabase];
    }
    
    if (![db open])
    {
        return nil;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:tableName])
    {
        return nil;
    }
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *tableArray = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where %@",tableName,string];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [db executeQuery:sqlString];
    
    NSArray *keys = nil;
    
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next])
    {
        id tmpObject = [[NSClassFromString(tableName) alloc] init];
        //获取对象所有key
        keys = [self propertyKeys:tmpObject];
        
        for (int i = 0; i < [keys count]; i++)
        {
            NSString *keyString = [keys objectAtIndex:i];
            [tmpObject setValue:[rs stringForColumn:keyString] forKey:keyString];
        }
        
        [tableArray addObject:tmpObject];
    }
    return tableArray;
}

+(NSMutableArray *)getDataID:(NSString *)string
{
    if (!db)
    {
        [self creatDatabase];
    }
    
    if (![db open])
    {
        return nil;
    }
    
    [db setShouldCacheStatements:YES];
    
  
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *tableArray = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:@"select ID from UserAddressModel where u_tel='%@'",string];
    //定义一个结果集，存放查询的数据
    FMResultSet *rs = [db executeQuery:sqlString];
    
    NSArray *keys = nil;
    
    //判断结果集中是否有数据，如果有则取出数据
    while ([rs next])
    {
        id tmpObject = [[UserAddressModel alloc] init];
        //获取对象所有key
        keys = [self propertyKeys:tmpObject];
        
        for (int i = 0; i < [keys count]; i++)
        {
            NSString *keyString = [keys objectAtIndex:i];
            [tmpObject setValue:[rs stringForColumn:keyString] forKey:keyString];
        }
        
        [tableArray addObject:tmpObject];
    }
    return tableArray;
}


+ (void) deleteFromTable:(id)table WithString:(NSString *) string
{
    if ([string isEqualToString:@""] || string == nil || [string isEqualToString:@"(null)"])
    {
        string = @"1=1";
    }
    
    NSString *tableName = [NSString stringWithFormat:@"%@",table];
    if (!db)
    {
        [self creatDatabase];
    }
    
    if (![db open])
    {
        return;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:tableName])
    {
        return;
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"delete from %@ where %@",tableName,string];
    [db executeUpdate:sqlString];
    
}


+ (void) updateTable:(id)table setString:(NSString *) setString WithString:(NSString *) string
{
    if ([string isEqualToString:@""] || string == nil || [string isEqualToString:@"(null)"])
    {
        string = @"1=1";
    }
    
    if ([setString isEqualToString:@""] || setString == nil || [setString isEqualToString:@"(null)"])
    {
        return;
    }
    
    NSString *tableName = [NSString stringWithFormat:@"%@",[table class]];
    if (!db)
    {
        [self creatDatabase];
    }
    
    if (![db open])
    {
        return;
    }
    
    [db setShouldCacheStatements:YES];
    
    if(![db tableExists:tableName])
    {
        [self creatTableWithObject:[table class]];
    }
    
    NSString *sqlString1 = [NSString stringWithFormat:@"select * from %@ where %@",tableName,string];
    FMResultSet *rs = [db executeQuery:sqlString1];
    
    if (rs.next)
    {
        NSString *sqlString = [NSString stringWithFormat:@"update %@ set %@ where %@",tableName,setString,string];
        [db executeUpdate:sqlString];
    }
    else
    {
        [self insertProgramWithObject:table];
    }
}
//update %@ set u_name='123' where 'u_id=1';
+(void) updateTable:(id)table WithKey:(NSString *) key WithValue:(NSString *)Value WithString:(NSString *)string{
    NSString *tableName = [NSString stringWithFormat:@"%@",[table class]];

    NSString *sqlString=[NSString stringWithFormat:@"update %@ set %@='%@' where %@",tableName,key,Value,string];
    [db executeUpdate:sqlString];

}



//+ (void) updateDBWithNewVersion
//{
//    NSString *currentVer = [NSString stringWithFormat:@"kDBUpdate%@",[MetaData getCurrVer]];
//    NSString *currentJudge = [[NSUserDefaults standardUserDefaults] objectForKey:currentVer];
//    if (currentJudge == nil || [currentJudge isEqualToString:@"1"] == NO) {
//        
//        @try {
//            UserObject *userObject = [[UserObject alloc]init];
//            NSMutableArray *tmpArr = [FMDBManage getDataFromTable:[UserObject class] WithString:@"1=1"];
//            if ([tmpArr count] > 0)
//            {
//                userObject = [tmpArr objectAtIndex:0];
//                userObject.u_email = @"-1";
//            }
//            
//            
//            //删除用户登录数据
//            NSString *tableName = [NSString stringWithFormat:@"%@",[UserObject class]];
//            
//            NSString *sqlString = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
//            [db executeUpdate:sqlString];
//            
//            //如果用户有数据重新建表
//            if ([tmpArr count] > 0)
//            {
//                [self updateTable:userObject setString:@"1=1" WithString:@"1=1"];
//            }
//        }
//        @catch (NSException *exception) {
//            NSLog(@"updateDBWithNewVersion---调用失败");
//        }
//        @finally {
//            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:currentVer];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//    }
//}

//update UserAddressModel set u_name='majunjie' where ID='1'

@end
