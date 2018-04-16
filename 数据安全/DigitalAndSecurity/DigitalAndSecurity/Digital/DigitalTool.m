//
//  DigitalTool.m
//
//  Created by ld on 17/2/16.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "DigitalTool.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation DigitalTool

+ (NSData *)convertDicToData:(NSDictionary *)dic error:(NSError **)error
{
    NSData * dicData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:error];
    return dicData;
}

+ (NSString *)convertDicToString:(NSDictionary *)dic error:(NSError **)error
{
    NSData * dicData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:error];
    NSString * dicStr = [[NSString alloc] initWithData:dicData encoding:NSUTF8StringEncoding];
    return dicStr;
}

+ (NSDictionary *)convertDataToDic:(NSData *)data error:(NSError **)error
{
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
    return dict;
}

+ (NSDictionary *)convertStringToDict:(NSString *)string error:(NSError **)error
{
    NSData * dicData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:dicData options:NSJSONReadingMutableContainers error:error];
    return dict;
}

+ (NSString *)convertDataToString:(NSData *)data
{
    NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
+ (NSData *)convertStringToData:(NSString *)string
{
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

+(void)srcData:(NSMutableData *)srcData appendData:(NSData*)other length:(int)len {
    [srcData appendData:other];
    int len_tmp = len - (int)[other length];
    if (len_tmp > 0) {
        [srcData resetBytesInRange:NSMakeRange([srcData length], len_tmp)];
    }
}

+ (NSData*)randomDataWithLength:(NSUInteger)length
{
    NSMutableData *mutableData = [NSMutableData dataWithCapacity: length];
    for (unsigned int i = 0; i < length; i++) {
        NSInteger randomBits = arc4random();
        [mutableData appendBytes: (void *) &randomBits length: 1];
    }
    return mutableData;
}

+ (BOOL)isEmptyData:(NSData*)data {
    if (data && [data length] > 0) {
        int len = (int)[data length];
        Byte *bytes = (Byte*)[data bytes];
        for (int i = 0; i < len; i++) {
            if (bytes[i] != 0) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

+ (NSString*)hexStringFromData:(NSData *)data {
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([data length] * 2)];
    const unsigned char *dataBuffer = [data bytes];
    for (int i = 0; i < [data length]; ++i) {
        [stringBuffer appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    return [stringBuffer copy];
}

@end



