//
//  BreweryMaster.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BreweryMaster : NSManagedObject

@property (nonatomic, retain) NSNumber * master_id;
@property (nonatomic, retain) NSString * j_name;
@property (nonatomic, retain) NSString * e_name;
@property (nonatomic, retain) NSString * furigana;
@property (nonatomic, retain) NSString * j_state;
@property (nonatomic, retain) NSString * e_state;
@property (nonatomic, retain) NSManagedObject *country;

@end
