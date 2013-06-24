//
//  TopViewController.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/24/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "TopViewController.h"
#import "Account.h"
#import "SVProgressHUD.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *beerView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
    beerView.backgroundColor = BEER_COLOR;
    [self.view addSubview:beerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 60)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = RGB(0x60, 0x60, 0x60);
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    titleLabel.text = @"MY BEER CELLAR";
    [self.view addSubview:titleLabel];
    
    UIButton *twitterLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twitterLoginButton.frame = CGRectMake(10, SCREEN_HEIGHT-220, 150, 150);
    [twitterLoginButton setImage:[UIImage imageNamed:@"twitter_logo_300x300.png"]  forState:UIControlStateNormal];
    [twitterLoginButton addTarget:self action:@selector(twitterLoginButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterLoginButton];
    
    UILabel *twitterLoginDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH/2, 30)];
    twitterLoginDescription.textAlignment = NSTextAlignmentCenter;
    twitterLoginDescription.backgroundColor = [UIColor clearColor];
    twitterLoginDescription.textColor = [UIColor whiteColor];
    twitterLoginDescription.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    twitterLoginDescription.text = @"twitterでログイン";
    [self.view addSubview:twitterLoginDescription];
    
    UIButton *facebookLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookLoginButton.frame = CGRectMake(180, SCREEN_HEIGHT-200, 100, 100);
    [facebookLoginButton setImage:[UIImage imageNamed:@"facebook_logo_100x100.png"]  forState:UIControlStateNormal];
    [facebookLoginButton addTarget:self action:@selector(facebookLoginButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookLoginButton];
    
    UILabel *facebookLoginDescription = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-80, SCREEN_WIDTH/2, 30)];
    facebookLoginDescription.textAlignment = NSTextAlignmentCenter;
    facebookLoginDescription.backgroundColor = [UIColor clearColor];
    facebookLoginDescription.textColor = [UIColor whiteColor];
    facebookLoginDescription.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    facebookLoginDescription.text = @"facebookでログイン";
    [self.view addSubview:facebookLoginDescription];
}

- (void)twitterLoginButtonTouched {
    [Account requestAccountWithType:ACAccountTypeIdentifierTwitter viewController:self];
}

- (void)facebookLoginButtonTouched {
    [Account requestAccountWithType:ACAccountTypeIdentifierFacebook viewController:self];
}

- (void)dismissThisView {
    // UIThreadでdismissViewControllerAnimatedを呼ばないと実行されるまですげー時間がかかる
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            [SVProgressHUD dismiss];
        }];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end