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

+ (void)requestAccountWithType:(NSString *)typeIdentifier viewController:(UIViewController *)viewController;
+ (void)getUserAccount;
@end
