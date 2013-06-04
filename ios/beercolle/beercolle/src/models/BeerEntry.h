//
//  BeerEntry.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/4/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataUtil.h"

@interface BeerEntry : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * brewery;
@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) NSNumber * abv;

+ (NSMutableArray *)getAllBeerEntriesWithContext:(NSManagedObjectContext *)context;
@end
