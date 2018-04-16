//
//  DigitalTool.h
//
//  Created by ld on 17/2/16.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigitalTool : NSObject

+ (NSData *)convertDicToData:(NSDictionary *)dic error:(NSError **)error;
+ (NSDictionary *)convertDataToDic:(NSData *)data error:(NSError **)error;
+ (NSString *)convertDicToString:(NSDictionary *)dic error:(NSError **)error;
+ (NSDictionary *)convertStringToDict:(NSString *)string error:(NSError **)error;
+ (NSString *)convertDataToString:(NSData *)data;
+ (NSData *)convertStringToData:(NSString *)string;


/**
 *  拼接data，如数据长度不够len，则填充
 */
+(void)srcData:(NSMutableData *)srcData appendData:(NSData*)other length:(int)len;
/**
 *  生成指定长度的随机data
 */
+ (NSData*)randomDataWithLength:(NSUInteger)length;
/**
 * data是不是<00000000 00000000 00000000 00000000>
 */
+ (BOOL)isEmptyData:(NSData*)data;
/**
 *  将一个data转成16进制的字符串
 */
+ (NSString*)hexStringFromData:(NSData *)data;

@end




