//
//  AppDelegate.h
//  beercolle
//
//  Created by Furuyama Yuuki on 5/27/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSString *dbPath;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
