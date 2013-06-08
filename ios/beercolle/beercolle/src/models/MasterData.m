//
//  BeerMaster.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "MasterData.h"

@implementation MasterData

+(void)initMasterData {
    
    NSString *masterFileDirectory = @"masterdata";
    NSString *masterFileFormat = @"json";
    NSDictionary *masterFileNames = @{
        @"beer": @"beer",
        @"brewery": @"brewery",
        @"beerStyle": @"beer_style",
        @"country": @"country",
    };
    
    NSString *beerMasterPath = [[NSBundle mainBundle] pathForResource:masterFileNames[@"beer"] ofType:masterFileFormat inDirectory:masterFileDirectory];
    NSString *breweryMasterPath = [[NSBundle mainBundle] pathForResource:masterFileNames[@"brewery"] ofType:masterFileFormat inDirectory:masterFileDirectory];
    NSString *beerStyleMasterPath = [[NSBundle mainBundle] pathForResource:masterFileNames[@"beerStyle"] ofType:masterFileFormat inDirectory:masterFileDirectory];
    NSString *countryMasterPath = [[NSBundle mainBundle] pathForResource:masterFileNames[@"country"] ofType:masterFileFormat inDirectory:masterFileDirectory];
    
    NSArray *beerMaster = [self parseBeerMasterFromPath:beerMasterPath];
    NSArray *breweryMaster = [self parseBreweryMasterFromPath:breweryMasterPath];
    NSArray *beerStyleMaster = [self parseBeerStyleMasterFromPath:beerStyleMasterPath];
    NSArray *countryMaster = [self parseCountryMasterFromPath:countryMasterPath];
    
    NSManagedObjectContext *context = [CoreDataUtil getManagedObjectContext];
    [self initWithBeerMaster:beerMaster breweryMaster:breweryMaster beerStyleMaster:beerStyleMaster countryMaster:countryMaster context:context];
    
}

+(void)initWithBeerMaster:(NSArray *)beerMaster breweryMaster:(NSArray *)breweryMaster beerStyleMaster:(NSArray*)beerStyleMaster countryMaster:(NSArray *)countryMaster context:(NSManagedObjectContext *)context {
    
    NSError *error = nil;
    
    NSMutableDictionary *countryMap = [[NSMutableDictionary alloc] initWithCapacity:100];
    for (NSDictionary *country in countryMaster) {
        CountryMaster *countryObj = [[CountryMaster alloc] initWithEntity:[NSEntityDescription entityForName:@"CountryMaster" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        countryObj.master_id = country[@"id"];
        countryObj.j_name = country[@"j_name"];
        countryObj.e_name = country[@"e_name"];
        
        [countryMap setObject:countryObj forKey:countryObj.master_id];
    }
    // save country master
    if (![context save:&error]) {
        Log(@"initialization error");
    }
    
    NSMutableDictionary *beerStyleMap = [[NSMutableDictionary alloc] initWithCapacity:100];
    for (NSDictionary *beerStyle in beerStyleMaster) {
        BeerStyleMaster *beerStyleObj = [[BeerStyleMaster alloc] initWithEntity:[NSEntityDescription entityForName:@"BeerStyleMaster" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        beerStyleObj.master_id = beerStyle[@"id"];
        beerStyleObj.j_name = beerStyle[@"j_name"];
        beerStyleObj.e_name = beerStyle[@"e_name"];
        
        [beerStyleMap setObject:beerStyleObj forKey:beerStyleObj.master_id];
    }
    // save beer style master
    error = nil;
    if (![context save:&error]) {
        Log(@"initialization error");
    }
    
    NSMutableDictionary *breweryMap = [[NSMutableDictionary alloc] initWithCapacity:100];
    for (NSDictionary *brewery in breweryMaster) {
        BreweryMaster *breweryObj = [[BreweryMaster alloc] initWithEntity:[NSEntityDescription entityForName:@"BreweryMaster" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        
        breweryObj.master_id = brewery[@"id"];
        breweryObj.j_name = brewery[@"j_name"];
        breweryObj.e_name = brewery[@"e_name"];
        breweryObj.furigana = brewery[@"furigana"];
        breweryObj.j_state = brewery[@"j_state"];
        breweryObj.e_state = brewery[@"e_state"];
        breweryObj.country = countryMap[brewery[@"country_id"]];
        
        [breweryMap setObject:breweryObj forKey:breweryObj.master_id];
    }
    // save brewery master
    error = nil;
    if (![context save:&error]) {
        Log(@"initialization error");
    }
    
    for (NSDictionary *beer in beerMaster) {
        BeerMaster *beerObj = [[BeerMaster alloc] initWithEntity:[NSEntityDescription entityForName:@"BeerMaster" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        beerObj.master_id = beer[@"id"];
        beerObj.j_name = beer[@"j_name"];
        beerObj.e_name = beer[@"e_name"];
        beerObj.furigana = beer[@"furigana"];
        beerObj.abv = beer[@"abv"];
        beerObj.ibu = beer[@"ibu"];
        beerObj.srm = beer[@"srm"];
        beerObj.style_1 = [beerStyleMap objectForKey:beer[@"style_id1"]];
        beerObj.style_2 = [beerStyleMap objectForKey:beer[@"style_id2"]];
        beerObj.style_3 = [beerStyleMap objectForKey:beer[@"style_id3"]];
        beerObj.brewery = [breweryMap objectForKey:beer[@"brewery_id"]];
    }
    // save beer master
    error = nil;
    if (![context save:&error]) {
        Log(@"initialization error");
    }
}

+(NSArray *)parseBeerMasterFromPath:(NSString *)masterPath {
    return [self _parseBeerMasterFromJSON:[NSData dataWithContentsOfFile:masterPath]];
}

+(NSArray *)parseBreweryMasterFromPath:(NSString *)masterPath {
    return [self _parseBreweryMasterFromJSON:[NSData dataWithContentsOfFile:masterPath]];
}

+(NSArray *)parseBeerStyleMasterFromPath:(NSString *)masterPath {
    return [self _parseBeerStyleMasterFromJSON:[NSData dataWithContentsOfFile:masterPath]];
}

+(NSArray *)parseCountryMasterFromPath:(NSString *)masterPath {
    return [self _parseCountryMasterFromJSON:[NSData dataWithContentsOfFile:masterPath]];
}

// parse JSON format data
+(NSArray*)_parseBeerMasterFromJSON:(NSData *)rawJSON {
    NSDictionary *json = [self _parseJSON:rawJSON];
    
    NSMutableArray *beers = [[NSMutableArray alloc] initWithArray:json[@"beers"]];
    return json[@"beers"];
}

+(NSArray*)_parseBreweryMasterFromJSON:(NSData *)rawJSON {
    NSDictionary *json = [self _parseJSON:rawJSON];
    return json[@"breweries"];
}

+(NSArray*)_parseBeerStyleMasterFromJSON:(NSData *)rawJSON {
    NSDictionary *json = [self _parseJSON:rawJSON];
    return json[@"beerStyles"];
}

+(NSArray*)_parseCountryMasterFromJSON:(NSData *)rawJSON {
    NSDictionary *json = [self _parseJSON:rawJSON];
    return json[@"countries"];
}

+(NSDictionary *)_parseJSON:(NSData *)rawJSON {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:rawJSON options:NSJSONReadingMutableContainers error:NULL];
    if (![NSJSONSerialization isValidJSONObject:json]) {
        Log(@"invalid json");
        abort();
    }
    
    return json;
}

@end
