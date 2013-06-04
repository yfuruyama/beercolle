//
//  Util.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/4/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "Util.h"

@implementation Util

/* 
 * get screen size without status bar
 */
+ (CGRect)getScreenBounds
{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect screenBoundsWithStatusBar = [[UIScreen mainScreen] bounds];
    CGRect screenBoundsWithoutStatusBar = CGRectMake(screenBoundsWithStatusBar.origin.x,
                                                     screenBoundsWithStatusBar.origin.y + statusBarHeight,
                                                     screenBoundsWithStatusBar.size.width,
                                                     screenBoundsWithStatusBar.size.height - statusBarHeight);
    return screenBoundsWithoutStatusBar;
}

@end
