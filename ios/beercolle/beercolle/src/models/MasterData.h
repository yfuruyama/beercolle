//
//  BeerMaster.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataUtil.h"
#import "BeerMaster.h"
#import "BreweryMaster.h"
#import "BeerStyleMaster.h"
#import "CountryMaster.h"

@interface MasterData : NSObject
+(void)initMasterData;
+(NSArray *)parseBeerMasterFromPath:(NSString *)masterPath;
+(NSArray *)parseBreweryMasterFromPath:(NSString *)masterPath;
+(NSArray *)parseBeerStyleMasterFromPath:(NSString *)masterPath;
+(NSArray *)parseCountryMasterFromPath:(NSString *)masterPath;
+(void)initWithBeerMaster:(NSArray *)beerMaster breweryMaster:(NSArray *)breweryMaster beerStyleMaster:(NSArray*)beerStyleMaster countryMaster:(NSArray *)countryMaster context:(NSManagedObjectContext *)context;
@end