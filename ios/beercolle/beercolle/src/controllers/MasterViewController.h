//
//  MasterViewController.h
//  beercolle
//
//  Created by Furuyama Yuuki on 5/27/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>
#import "CoreDataUtil.h"
#import "BeerEntry.h"
#import "BeerListCell.h"
#import "Account.h"
#import "Auth.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
