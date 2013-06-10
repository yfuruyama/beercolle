//
//  BeerMaster.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BeerMaster : NSManagedObject

@property (nonatomic, retain) NSNumber * master_id;
@property (nonatomic, retain) NSString * j_name;
@property (nonatomic, retain) NSString * e_name;
@property (nonatomic, retain) NSString * furigana;
@property (nonatomic, retain) NSDecimalNumber * abv;
@property (nonatomic, retain) NSNumber * ibu;
@property (nonatomic, retain) NSNumber * srm;
@property (nonatomic, retain) NSManagedObject *style_1;
@property (nonatomic, retain) NSManagedObject *style_2;
@property (nonatomic, retain) NSManagedObject *style_3;
@property (nonatomic, retain) NSManagedObject *brewery;

@end
