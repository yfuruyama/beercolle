//
//  Account.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/16/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface Account : NSObject

+ (void)requestUserAccount;
+ (void)getUserAccount;
@end
