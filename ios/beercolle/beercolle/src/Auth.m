//
//  Auth.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/16/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "Auth.h"

@implementation Auth

+ (NSString *)hashing:(NSString *)value {
    return [self sha256:value];
}

+ (NSString *)sha256:(NSString *)value {
    NSString *secret = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SHA256Secret"];
    return [self sha256:value withSecret:secret];
}

+ (NSString *)sha256:(NSString *)value withSecret:(NSString *)secret {
    const char* cValue = [[value stringByAppendingString:secret] cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:cValue length:strlen(cValue)];
    uint8_t digetst[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(keyData.bytes, keyData.length, digetst);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digetst[i]];
    }
    
    return output;
}

@end
