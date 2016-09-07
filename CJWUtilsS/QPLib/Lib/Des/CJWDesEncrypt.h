//
//  CJWDesEncrypt.h
//  Album
//
//  Created by cen on 1/7/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJWDesEncrypt : NSObject

+ (NSString*)encrypt:(NSString*)plainText;
+ (NSString*)decrypt:(NSString*)encryptText;

+ (NSString*)encrypt:(NSString*)plainText key:(NSString *)key;
+ (NSString*)decrypt:(NSString*)encryptText  key:(NSString *)key;
@end


@interface NSString (CJWDesEncrypt)

-(NSString *)encrypt;
-(NSString *)decrypt;

@end