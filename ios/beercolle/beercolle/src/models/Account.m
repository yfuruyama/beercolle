//
//  Account.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/16/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "Account.h"
#import "SVProgressHUD.h"
#import "TopViewController.h"

@implementation Account

/* TODO
 * 1. twitter or facebookアカウントを1つもiOSに設定していなかった場合
 * 2. twitterアカウントを複数iOSに登録していた場合(facebookは複数登録できない)
 * 3. このアプリとtwitter or facebookアカウントの連携を解除していた場合
 */

+ (void)requestAccountWithType:(NSString *)typeIdentifier viewController:(TopViewController *)viewController {
    [SVProgressHUD show];
    if ([self _isFacebookType:typeIdentifier]) {
        void (^requestFacebookAccountFinished)(BOOL, NSError*) = ^(BOOL granted, NSError *error) {
            NSLog(@"reqeustFacebookAccountFinished");
            if (![self _validateAccountRequestWithType:typeIdentifier granted:granted error:error]) return;
            
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:typeIdentifier];
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            ACAccount *account = [accounts objectAtIndex:0];
            NSString *uId = [account valueForKeyPath:@"properties.uid"];
            Log(@"%@", account);
            Log(@"%@", uId);
            
            [viewController dismissThisView];
        };
        
        NSDictionary *options = @{
            ACFacebookAppIdKey: @"190137684485316",
            ACFacebookPermissionsKey: @[@"email"]
            //ACFacebookPermissionsKey: @[@"user_about_me"] // user_about_meを指定すると実機上でアカウント情報が何も得られなかった
        };
        [self _requestAccountWithType:typeIdentifier options:options completion:requestFacebookAccountFinished];
        
    } else if ([self _isTwitterType:typeIdentifier]) {
        void (^requestTwitterAccountFinished)(BOOL, NSError*) = ^(BOOL granted, NSError *error) {
            NSLog(@"reqeustTwitterAccountFinished");
            
            if (![self _validateAccountRequestWithType:typeIdentifier granted:granted error:error]) return;
            
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:typeIdentifier];
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // TODO
            // twitterアカウントが2個以上登録されている場合
            /*
            if ([accounts count] >= 2) {
                UIActionSheet *sheet = [[UIActionSheet alloc] init];
                sheet.delegate = viewController;
                for (int i = 0; i < [accounts count]; i++) {
                    ACAccount *account = [accounts objectAtIndex:i];
                    NSString *username = account.username;
                    [sheet addButtonWithTitle:[NSString stringWithFormat:@"@@%@", username]];
                }
                [sheet addButtonWithTitle:@"キャンセル"];
                sheet.cancelButtonIndex = [accounts count];
                [sheet showInView:viewController.view];
            }
             */
            
            ACAccount *account = [accounts objectAtIndex:0];
            NSString *userId = [account valueForKeyPath:@"properties.user_id"];
            Log(@"%@", account);
            Log(@"%@", userId);
            
            [viewController dismissThisView];
        };
        [self _requestAccountWithType:typeIdentifier options:nil completion:requestTwitterAccountFinished];
    } else {
        Log(@"Unsupported ACAccountTypeIdentifier Error");
        return;
    }
}

+ (BOOL)_validateAccountRequestWithType:(NSString *)typeIdentifier granted:(BOOL)granted error:(NSError *)error {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:typeIdentifier];
    
    if (!granted) {
        NSLog(@"User did not grant");
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return FALSE;
    }
    
    NSArray *accounts = [accountStore accountsWithAccountType:accountType];
    if ([accounts count] <= 0) {
        NSLog(@"User don't have any service accounts");
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return FALSE;
    }
    
    return TRUE;
}

+ (void)_requestAccountWithType:(NSString *)typeIdentifier options:(NSDictionary *)options completion:(ACAccountStoreRequestAccessCompletionHandler)completionHandler
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:typeIdentifier];
    [accountStore requestAccessToAccountsWithType:accountType options:options completion:completionHandler];
}

+ (BOOL)_isTwitterType:(NSString *)typeIdentifier {
    return [typeIdentifier isEqualToString:ACAccountTypeIdentifierTwitter];
}

+ (BOOL)_isFacebookType:(NSString *)typeIdentifier {
    return [typeIdentifier isEqualToString:ACAccountTypeIdentifierFacebook];
}

// TODO
+ (void)getUserAccount {
}

@end