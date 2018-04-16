//
//  DigitalAndSecurityTests.m
//  DigitalAndSecurityTests
//
//  Created by ld on 2017/12/1.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSAManager.h"
#import "NSString+ld_Security.h"
#import "SSKeychain.h"
#import "NSData+ByteOrderCategory.h"

@interface DigitalAndSecurityTests : XCTestCase

@end

@implementation DigitalAndSecurityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRSA {
    NSString * publicKeyPath = [[NSBundle mainBundle] pathForResource:@"rsacert.der" ofType:nil];
    NSString * privateKey = [[NSBundle mainBundle] pathForResource:@"p.p12" ofType:nil];
    [[RSAManager sharedRSACryptor] loadPublicKey:publicKeyPath];
    [[RSAManager sharedRSACryptor] loadPrivateKey:privateKey password:@"ld"];
    NSData * enCodeData = [[RSAManager sharedRSACryptor] encryptData:[@"dashuai" dataUsingEncoding:NSUTF8StringEncoding]];
    NSData * deCodeData = [[RSAManager sharedRSACryptor] decryptData:enCodeData];
    NSString * dataStr = [[NSString alloc] initWithData:deCodeData encoding:NSUTF8StringEncoding];
    NSAssert([dataStr isEqualToString:@"dashuai"], @"不正确");
}
    
- (void)testHash {
    NSString * sourceStr = @"dada";
    NSString * desStr = [sourceStr hmacSHA256StringWithKey:@"ling"];
    NSAssert(desStr.length == 64, @"错误");
}

    
- (void)testSSKeychanin {
    [SSKeychain setPassword:@"zhe shi mi ma" forService:@"ygkSerivice" account:@"ygkLoginPassword"];
    
    NSString * password = [SSKeychain passwordForService:@"ygkSerivice" account:@"ygkLoginPassword"];
    NSAssert([password isEqualToString:@"zhe shi mi ma"], @"错误");
}

- (void)testAES {
    NSString * sourceStr = @"就是这个达";
    NSString * enCodeStr = [sourceStr AESEncrypt:@"我就是这么加密的"];
    NSString * deCodeStr = [enCodeStr AESDecrypt:@"我就是这么加密的"];
    
    NSAssert([deCodeStr isEqualToString:sourceStr], @"错误");
}
    
- (void)testDES {
    NSString * sourceStr = @"就是这个达";
    NSString * enCodeStr = [sourceStr DESEncrypt:@"我就是这么加密的"];
    NSString * deCodeStr = [enCodeStr DESDecrypt:@"我就是这么加密的"];
    
    NSAssert([deCodeStr isEqualToString:sourceStr], @"错误");
}


- (void)testBigToSmall
{
    //创建一个4个字节的字节数组
    Byte p[] = {0x24,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    NSData * data = [NSData dataWithBytes:&p length:sizeof(p)];
    
    
    //这里也是获取第4个字节  只是有大小端的转换
    //获取第4位的值是 0x24  但是大小端转换后变成了
    //int   0x24 0x00 0x00 0x00
    //long  0x24 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    //下面的函数顺序是从左到右的顺序
    data.byteOrder = CFByteOrderLittleEndian;
    char charData = [data getCharWithLocation:0];
    short shortData = [data getShortWithLocation:0];
    int intData = [data getIntWithLocation:0];
    long longData = [data getLongWithLocation:0];
    NSLog(@"数据值: charData-%c,shortData-%d,intData-%d,longData-%ld",charData,shortData,intData,longData);
    //结果 '$'  36  36  36 因为本地也是小端，所有没有大下端转换
    
    
    //用4中类型的生成NSNumber,然后转成NSData且NSData端口为大端
    char cc = '$';
    short ss = 36;
    int ii = 36;
    long ll = 36;
    NSData * dataChar = [NSData dataOrderWithValue:@(cc)];
    NSData * dataShort = [NSData dataOrderWithValue:@(ss)];
    NSData * dataInt = [NSData dataOrderWithValue:@(ii)];
    NSData * dataLong = [NSData dataOrderWithValue:@(ll)];
    //这里的dataLong 是 <00000000 00000024>  下面是从左往右取
    //所以 只有getLongWithLocation 才会有值
    //因为指定了dataLong是大端，而本地是小端所以数据会转换一下
    //最后得到的value是 36
    long value = [dataLong getLongWithLocation:0];
    NSLog(@"数据长度: dataChar-%ld,dataShort-%ld,dataInt-%ld,dataLong-%ld  value值:%ld",dataChar.length,dataShort.length,dataInt.length,dataLong.length,value);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
