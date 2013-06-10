//
//  BeerListCell.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "BeerListCell.h"

@implementation BeerListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    /*
     [6/4/13 11:34:21 PM] sho nakatani: ビール名,　醸造除名，アルコール度数，写真，メモ(一部), rating
     [6/4/13 11:34:57 PM] Yuuki Furuyama: SakeLover: 写真・名前・醸造名・レーティング・日付・メモ
     */
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60,60)];
        [self addSubview:self.thumbnail];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 200, 40)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.nameLabel];
        
        self.breweryLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 200, 40)];
        self.breweryLabel.backgroundColor = [UIColor clearColor];
        self.breweryLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.breweryLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
