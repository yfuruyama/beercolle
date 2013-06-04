//
//  BeerEntry.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/4/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "BeerEntry.h"

@implementation BeerEntry

@dynamic name;
@dynamic brewery;
@dynamic style;
@dynamic abv;

#pragma mark -
#pragma mark Class method
+ (NSMutableArray *)getAllBeerEntriesWithContext:(NSManagedObjectContext *)context
{
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSSortDescriptor *sortDescriptor;
    NSFetchRequest *request = [CoreDataUtil createFetchRequestForEntity:@"BeerEntry"
                                                                context:context
                                                              predicate:nil
                                                                   sort:nil];
    
    NSError *error = nil;
    NSMutableArray *results = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (results == nil) {
        Log(@"error");
    }
    
    return results;
//NSMutableArray *bookList = [Book getBookListOnMonth:dateComp withContext:appDelegate.managedObjectContext ascending:NO];
}

@end