//
//  CJWDesEncrypt.m
//  Album
//
//  Created by cen on 1/7/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

#import "CJWDesEncrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import "Base64.h"

#define gkey            @"MDBTyangtai@20008$#369#$"
#define gIv             @"01234567"
@implementation CJWDesEncrypt

+(NSString *)encrypt:(NSString *)plainText key:(NSString *)key{
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    
    
    ccStatus = CCCrypt(kCCEncrypt,
                       
                       kCCAlgorithm3DES,
                       
                       kCCOptionPKCS7Padding,
                       
                       vkey,
                       
                       kCCKeySize3DES,
                       
                       vinitVec,
                       
                       vplainText,
                       
                       plainTextBufferSize,
                       
                       (void *)bufferPtr,
                       
                       bufferPtrSize,
                       
                       &movedBytes);
    
    
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    
    
//    [Base64]
//    NSString *result = [Base64 stringByEncodingData:myData];
    
    NSString *result  = [myData base64EncodedString];
    return result;

}

+(NSString *)decrypt:(NSString *)encryptText key:(NSString *)key{
//    NSData *encryptData = [Base64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *encryptData = [encryptText base64DecodedData];
    
     size_t plainTextBufferSize = [encryptData length];
    
    const void *vplainText = [encryptData bytes];
    
    
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    
    
    ccStatus = CCCrypt(kCCDecrypt,
                       
                       kCCAlgorithm3DES,
                       
                       kCCOptionPKCS7Padding,
                       
                       vkey,
                       
                       kCCKeySize3DES,
                       
                       vinitVec,
                       
                       vplainText,
                       
                       plainTextBufferSize,
                       
                       (void *)bufferPtr,
                       
                       bufferPtrSize,
                       
                       &movedBytes);
    
    
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                       
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    return result;

}

+ (NSString*)encrypt:(NSString*)plainText {
    return [self encrypt:plainText key:gkey];
}

+ (NSString*)decrypt:(NSString*)encryptText {
    return [self decrypt:encryptText key:gkey];
}

@end


@implementation NSString (CJWDesEncrypt)

-(NSString *)encrypt{
    return [CJWDesEncrypt encrypt:self];
}

-(NSString *)decrypt{
    return [CJWDesEncrypt decrypt:self];
}

@end
