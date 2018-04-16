//
//  PayManager.m
//  支付例子
//
//  Created by Mac on 2017/4/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PayManager.h"
#import "UPPaymentControl.h"
#import "WXApi.h"

@interface PayManager()<NSURLConnectionDelegate,WXApiDelegate>

@property(nonatomic,strong)NSMutableData * UPPayData;
@property(nonatomic,strong)UIViewController * UPViewcontroller;

@end

@implementation PayManager

+ (instancetype)share
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PayManager new];
    });
    return instance;
}

- (void)UPPayHandlePayResult:(NSURL *)url
{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            NSLog(@"交易成功");
            //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
            if(data != nil){
                //数据从NSDictionary转换为NSString
                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:nil];
                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                
                //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
                if([self UPPayVerify:sign]) {
                    //验签成功
                }else {
                    //验签失败
                }
            }
            
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
            NSLog(@"交易失败");
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
            NSLog(@"交易取消");
        }
    }];
}

- (BOOL)UPPayVerify:(NSString *)sign
{
    return NO;
}

- (void)UPPayIn:(UIViewController *)viewController
{
    self.UPViewcontroller = viewController;
    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn"]];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
}

#pragma mark - connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSInteger code = [rsp statusCode];
    if (code != 200)
    {
        [connection cancel];
    }
    else
    {
        _UPPayData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_UPPayData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString* tn = [[NSMutableString alloc] initWithData:_UPPayData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {
        
        NSLog(@"tn=%@",tn);
        [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"LingDaUPPay" mode:@"01" viewController:self.UPViewcontroller];
        
    }
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

+ (void)WXRegister
{
    //向微信注册wxd930ea5d5a258f4f
    [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];
}

- (void)WXPay{
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = @"";
    
    // 商家id，在注册的时候给的
    req.partnerId = @"";
    
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = @"";
    
    // 根据财付通文档填写的数据和签名
    //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
    req.package   = @"";
    
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = @"";
    
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = @"";
    req.timeStamp = stamp.intValue;
    
    // 这个签名也是后台做的
    req.sign = @"";
    
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}

+ (BOOL)WXPayHOpenUrl:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[PayManager share]];
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
    NSLog(@"%@",payResoult);
}

@end
