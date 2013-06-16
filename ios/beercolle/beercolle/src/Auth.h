//
//  Auth.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/16/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

@interface Auth : NSObject

+ (NSString *)hashing:(NSString *)value;
@end
