//
//  Account.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/16/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (void)requestUserAccount {
    
    void (^requestTwitterAccountFinished)(BOOL, NSError*) = ^(BOOL granted, NSError *error) {
        NSLog(@"reqeustTwitterAccountFinished");
        
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if (!granted) {
            NSLog(@"User did not grant");
            return; // TODO
        }
        NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
        if ([twitterAccounts count] <= 0) {
            NSLog(@"User don't have any twitter accounts");
            return; // TODO
        }
        
        ACAccount *account = [twitterAccounts objectAtIndex:0];
        Log(@"%@", account);
    };
    
    // twitter
    [self requestTwitterAccount:requestTwitterAccountFinished];
    
    // facebook
    // TODO
}

+ (void)requestTwitterAccount:(ACAccountStoreRequestAccessCompletionHandler)completionHandler {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:completionHandler];
}

// TODO
+ (void)getUserAccount {
    //return [self getTwitterAccount];
}

/* TODO
 * 1. twitterアカウントを1つもiOSに設定していなかった場合
 * 2. twitterアカウントを複数iOSに登録していた場合
 * 3. このアプリとtwitterアカウントの連携を解除していた場合
 */
+ (void)getTwitterAccount {
}

// TODO
+ (void)getFacebookAccount {
    
}

@end