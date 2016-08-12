//
//  Order.m
//  AlixPayDemo
//
//  Created by 方彬 on 11/2/13.
//
//

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>



#define PRIVATE_KEY @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKGrVXJpc3MbZBbBpbBFYZj8a6+Z3FYGH7CtjVKB8FvsTswMr8o4F0jsurWRcDMoVNgIh3+HilBDQSIfDxliAWbCENK0XMwJOriJE31L4FHbtTGLo5jf2hf9qMMhzCCqZTj/lRlnU9GPIBT39l4QSX34RUELrgp3U8ugCzB430yRAgMBAAECgYB0CQM1MRaZ4Wj/JFIFqGaaZWHtEWOhopeQOaCbPYQEliEgN2Lco1GjF7YSp6Z+MU5kGAsYr3HIldzj3qL5tuwFbs7PePhoSdQxLiM5b0fzX0+B2ABqZfllUfN+QEJdiqqWRhG11xoS0hOqHcJQKFKWLy5ADioMBh7k739NPTgPIQJBANGY1k2ubws17ssjSPTfy063eqzYPCjo6RcJUIcgGZtKthyDD9Vtu4H4RnV6jFUJ7qAylE9yyNkyWAwdebJRVMUCQQDFdiJNn/pBOtYo4+r2ad2DeROZyIIXSOWbJ2txfco6oZj9kG6veSmGBJJMS/WMxuYkDVLV18dptxypE5QHR41dAkEAyORD65rYZhdgdKWyRLrH4//qfgaXyuJKn0DXRVyYDocSe8uG/ps5kL5F0k4OeWeWp0czbd7n8X3WdG4/+ZEIvQJAaKikpeAVFF3LBQFImDKkZfrWmLvdt9m7WPEb0ZuKhGkCXeMfx4HAsHfb0vSvwV3qvVEShqVH3JBhcHwgCXuzQQJAGpAT0EZWdk2KYQHV2YriFVpMe5BtO9LAyble9eCAq8aEgFVNUmH216dlfLmMfMQ5/Sv5TDSGL2CJOWjjuLy6bg=="

#define PARTNER @"2088312938260884"

#define SELLER @"mark@yangtai.com"

@implementation Order

- (NSString *)description {
	NSMutableString * discription = [NSMutableString string];
    if (self.partner) {
        [discription appendFormat:@"partner=\"%@\"", self.partner];
    }
	
    if (self.seller) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.seller];
    }
	if (self.tradeNO) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.tradeNO];
    }
	if (self.productName) {
        [discription appendFormat:@"&subject=\"%@\"", self.productName];
    }
	
	if (self.productDescription) {
        [discription appendFormat:@"&body=\"%@\"", self.productDescription];
    }
	if (self.amount) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.amount];
    }
    if (self.notifyURL) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL];
    }
	
    if (self.service) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.paymentType) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.paymentType];//1
    }
    
    if (self.inputCharset) {
        [discription appendFormat:@"&_input_charset=\"%@\"",self.inputCharset];//utf-8
    }
    if (self.itBPay) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.itBPay];//30m
    }
    if (self.showUrl) {
        [discription appendFormat:@"&show_url=\"%@\"",self.showUrl];//m.alipay.com
    }
    if (self.rsaDate) {
        [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
    }
    if (self.appID) {
        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
    }
	for (NSString * key in [self.extraParams allKeys]) {
		[discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
	}
	return discription;
}


-(void)newOrder{
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKGrVXJpc3MbZBbBpbBFYZj8a6+Z3FYGH7CtjVKB8FvsTswMr8o4F0jsurWRcDMoVNgIh3+HilBDQSIfDxliAWbCENK0XMwJOriJE31L4FHbtTGLo5jf2hf9qMMhzCCqZTj/lRlnU9GPIBT39l4QSX34RUELrgp3U8ugCzB430yRAgMBAAECgYB0CQM1MRaZ4Wj/JFIFqGaaZWHtEWOhopeQOaCbPYQEliEgN2Lco1GjF7YSp6Z+MU5kGAsYr3HIldzj3qL5tuwFbs7PePhoSdQxLiM5b0fzX0+B2ABqZfllUfN+QEJdiqqWRhG11xoS0hOqHcJQKFKWLy5ADioMBh7k739NPTgPIQJBANGY1k2ubws17ssjSPTfy063eqzYPCjo6RcJUIcgGZtKthyDD9Vtu4H4RnV6jFUJ7qAylE9yyNkyWAwdebJRVMUCQQDFdiJNn/pBOtYo4+r2ad2DeROZyIIXSOWbJ2txfco6oZj9kG6veSmGBJJMS/WMxuYkDVLV18dptxypE5QHR41dAkEAyORD65rYZhdgdKWyRLrH4//qfgaXyuJKn0DXRVyYDocSe8uG/ps5kL5F0k4OeWeWp0czbd7n8X3WdG4/+ZEIvQJAaKikpeAVFF3LBQFImDKkZfrWmLvdt9m7WPEb0ZuKhGkCXeMfx4HAsHfb0vSvwV3qvVEShqVH3JBhcHwgCXuzQQJAGpAT0EZWdk2KYQHV2YriFVpMe5BtO9LAyble9eCAq8aEgFVNUmH216dlfLmMfMQ5/Sv5TDSGL2CJOWjjuLy6bg==";
    NSString *partner = @"2088312938260884";
    NSString *seller = @"mark@yangtai.com";
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [Order generateTradeNO];//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = @"岑嘉文买东西的标题";// product.subject; //商品标题
    order.productDescription = @"商铺描述描述";//product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  @"http://www.cenjiawen.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";// 支付类型， 固定值
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m"; //交易超时
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"VIPCardPool";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}


-(void)sendOrder{
    self.partner = PARTNER;
    self.seller = SELLER;
    //    order.tradeNO = [Order generateTradeNO];//[self generateTradeNO]; //订单ID（由商家自行制定）
    self.productName = @"卡仆充值";// product.subject; //商品标题
    self.productDescription = @"卡仆充值";//product.body; //商品描述
    self.productDescription = [NSString stringWithFormat:@"卡仆充值%@元",self.amount];
//    self.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
//    self.notifyURL =  @"http://121.42.46.55:8080/vipmodule/order/alipay/api.do"; //回调URL
    self.notifyURL = @"http://www.cardpool.cc:8080/vipmodule/payorder/alipay/api.do";
    self.service = @"mobile.securitypay.pay";
    self.paymentType = @"1";// 支付类型， 固定值
    self.inputCharset = @"utf-8";
    self.itBPay = @"30m"; //交易超时
    self.showUrl = @"m.alipay.com";
    
    
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"VIPCardPool";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [self description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PRIVATE_KEY);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSArray* views = [[UIApplication sharedApplication] windows];
            UIWindow* windowtemp = views[0];
            NSLog(@"web views %ld",views.count);
            if (!windowtemp.hidden) {
                windowtemp.hidden = YES;
            }
            else
            {
                NSLog(@"no hidden");
            }
        }];
    }
}

+(void)sendOrder:(Order *)order{
    
    
    
}


+ (void)checkAccount{
//    BOOL hasAuthorized = [[AlipaySDK defaultService] isLogined];
//    NSLog(@"result = %d",hasAuthorized);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"查询账户"
//                                                    message:hasAuthorized?@"有":@"没有"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles: nil];
//    [alert show];
}

+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}




@end
