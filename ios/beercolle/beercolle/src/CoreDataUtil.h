//
//  CoreDataUtil.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/4/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface CoreDataUtil : NSObject
+ (NSManagedObjectContext *)getManagedObjectContext;
+ (NSFetchRequest *)createFetchRequestForEntity:(NSString *)entityName
                                        context:(NSManagedObjectContext *)context
                                      predicate:(NSPredicate *)predicate
                                           sort:(NSSortDescriptor *)sortDescriptor;
@end
