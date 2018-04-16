//
//  NSData+ByteOrderCategory.h
//  CCDP
//
//  Created by zxy on 16/4/20.
//  Copyright © 2016年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ByteOrderCategory)


/**
 数据的端，比如说:现在从蓝牙接收的数据是大端的，那么数据的byteOrder
 必须设置成CFByteOrderBigEndian，在获取数据的时候，或默认与本地的
 端比较，如果一致则不用大小端转换，如果不一致则会大小端转换
 */
@property (nonatomic, assign) CFByteOrder byteOrder;


/**
 *  将NSNumber按照大端的序列转成NSData
 */
+ (NSData *)dataOrderWithValue:(NSNumber *)value;
/**
 *  将NSNumber按照指定的序列转成NSData
 */
+ (NSData *)dataOrderWithValue:(NSNumber *)value
                     byteOrder:(CFByteOrder)order;
/**
 *  将NSArray按照大端的序列转成NSData
 *  NSString按NSUTF8StringEncoding编码转化成NSData
 *  NSArray支持NSNumber、NSData、NSString
 */
+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue;
/**
 *  将NSArray按照指定的序列转成NSData
 *  NSString按NSUTF8StringEncoding编码转化成NSData
 *  NSArray支持NSNumber、NSData、NSString
 */
+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding;
/**
 *  将NSArray按照指定的序列转成NSData
 *  NSString按指定编码转化成NSData
 *  NSArray支持NSNumber、NSData、NSString
 */
+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding
                      byteOrder:(CFByteOrder)order;


/**
 数据从左往右看 loc为数据起始位置  取长度为char长度的数据
 */
- (char)getCharWithLocation:(NSInteger)loc;
/**
 数据从左往右看 loc为数据起始位置  取长度为short长度的数据
 */
- (short)getShortWithLocation:(NSInteger)loc;
/**
 数据从左往右看 loc为数据起始位置  取长度为int长度的数据
 */
- (int)getIntWithLocation:(NSInteger)loc;
/**
 数据从左往右看 loc为数据起始位置  取长度为long长度的数据
 */
- (long)getLongWithLocation:(NSInteger)loc;

@end
