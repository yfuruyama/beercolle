//
//  BeerListCell.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerListCell : UITableViewCell
@property (atomic, retain) UILabel *nameLabel;
@property (atomic, retain) UILabel *breweryLabel;
@property (atomic, retain) UIImageView *thumbnail;
@end
