//
//  NSData+ByteOrderCategory.m
//  CCDP
//
//  Created by zxy on 16/4/20.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "NSData+ByteOrderCategory.h"
#import <objc/runtime.h>

@interface NSNumber (ByteOrderCategory)

@property (readonly) const char *ld_objCType;

@end

@implementation NSNumber (ByteOrderCategory)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(numberWithChar:),
            @selector(numberWithShort:),
            @selector(numberWithInt:),
            @selector(numberWithLong:),
        };
        
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"ld_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getClassMethod(self, originalSelector);
            Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
}

+ (NSNumber *)ld_numberWithChar:(char)value{
    NSNumber *num = [self ld_numberWithChar:value];
    num.ld_objCType = @encode(char);
    return num;
}

+ (NSNumber *)ld_numberWithShort:(short)value{
    NSNumber *num = [self ld_numberWithShort:value];
    num.ld_objCType = @encode(short);
    return num;
}

+ (NSNumber *)ld_numberWithInt:(int)value{
    NSNumber *num = [self ld_numberWithInt:value];
    num.ld_objCType = @encode(int);
    return num;
}

+ (NSNumber *)ld_numberWithLong:(long)value{
    NSNumber *num = [self ld_numberWithLong:value];
    num.ld_objCType = @encode(long);
    return num;
}

#pragma mark - setter & getter

- (void)setLd_objCType:(const char *)ld_objCType{
    NSString *type = [[NSString alloc] initWithUTF8String:ld_objCType];
    objc_setAssociatedObject(self, @selector(ld_objCType), type, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (const char *)ld_objCType{
    NSString *type = objc_getAssociatedObject(self, _cmd);
    return [type UTF8String] ? [type UTF8String] : "";
}

@end

@implementation NSData (ByteOrderCategory)

+ (NSData *)numberConverData:(NSNumber *)number byteOrder:(CFByteOrder)order{
//    [number objCType]这样获取的type有时候是不准的，
//    具体忘记了当时未做记录，所以这里的type都是自己用运行时绑定的，
//    就不会出错了
    NSData *data = nil;
    if (strcmp([number ld_objCType], @encode(char)) == 0) {
        data = [self dataWithChar:[number charValue]];
    }else if (strcmp([number ld_objCType], @encode(short)) == 0){
        data = [self dataWithShort:[number shortValue] byteOrder:order];
    }else if (strcmp([number ld_objCType], @encode(int)) == 0){
        data = [self dataWithInt:[number intValue] byteOrder:order];
    }else if (strcmp([number ld_objCType], @encode(long)) == 0){
        data = [self dataWithLong:[number longValue] byteOrder:order];
    }
    data.byteOrder = order;
    NSAssert(data != nil, @"需扩展添加类型");
    
    return data;
}

+ (NSData *)dataOrderWithValue:(id)value{
    return [self numberConverData:value byteOrder:CFByteOrderBigEndian];
}

+ (NSData *)dataOrderWithValue:(NSNumber *)value
                     byteOrder:(CFByteOrder)order{
    return [self numberConverData:value byteOrder:order];
}

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue{
    return [self dataOrderWithArray:arrayValue
                    stringEncodeing:NSUTF8StringEncoding
                          byteOrder:CFByteOrderBigEndian];
}

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding{
    
    return [self dataOrderWithArray:arrayValue
                    stringEncodeing:encoding
                          byteOrder:CFByteOrderBigEndian];
}


+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding
                      byteOrder:(CFByteOrder)order{
    
    NSMutableData *mtData = [NSMutableData dataWithCapacity:20];
    [arrayValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [mtData appendData:[obj dataUsingEncoding:encoding]];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            [mtData appendData:[self numberConverData:obj byteOrder:order]];
        }else if ([obj isKindOfClass:[NSData class]]){
            [mtData appendData:obj];
        }
    }];

    mtData.byteOrder = order;
    return [NSData dataWithData:mtData];
}


- (char)getCharWithLocation:(NSInteger)loc;{
    char value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(char))];
    return value;
}

- (short)getShortWithLocation:(NSInteger)loc{
    short value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(short))];
    if(CFByteOrderGetCurrent() != self.byteOrder){
       value = CFSwapInt16(value);
    }
    return value;
}

- (int)getIntWithLocation:(NSInteger)loc{
    int value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(int))];
    if(CFByteOrderGetCurrent() != self.byteOrder){
        value = CFSwapInt32(value);
    }
    return value;
}

- (long)getLongWithLocation:(NSInteger)loc{
    long value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(long))];
    if(CFByteOrderGetCurrent() != self.byteOrder){
       value = CFSwapInt64(value);
    }
    return value;
}


+ (NSData *)dataWithChar:(char)value{
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

+ (NSData *)dataWithShort:(short)value byteOrder:(CFByteOrder)order{
    if(CFByteOrderGetCurrent() != order) value = CFSwapInt16(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

+ (NSData *)dataWithInt:(int)value byteOrder:(CFByteOrder)order{
    if(CFByteOrderGetCurrent() != order){
        value = CFSwapInt32(value);
    }
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

+ (NSData *)dataWithLong:(long)value byteOrder:(CFByteOrder)order{
    if(CFByteOrderGetCurrent() != order) value = CFSwapInt64(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

#pragma getter & setter

- (void)setByteOrder:(CFByteOrder)byteOrder {
    objc_setAssociatedObject(self, @selector(byteOrder), @(byteOrder), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CFByteOrder)byteOrder{
   return  [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
