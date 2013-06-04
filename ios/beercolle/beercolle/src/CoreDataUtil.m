//
//  CoreDataUtil.m
//  beercolle
//
//  Created by Furuyama Yuuki on 6/4/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "CoreDataUtil.h"

@implementation CoreDataUtil

+ (NSManagedObjectContext *)getManagedObjectContext {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [appDelegate managedObjectContext];
};

+ (NSFetchRequest *)createFetchRequestForEntity:(NSString *)entityName
                                        context:(NSManagedObjectContext *)context
                                      predicate:(NSPredicate *)predicate
                                           sort:(NSSortDescriptor *)sortDescriptor {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    if (predicate) [fetchRequest setPredicate:predicate];
    if (sortDescriptor) [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return fetchRequest;
}

@end
