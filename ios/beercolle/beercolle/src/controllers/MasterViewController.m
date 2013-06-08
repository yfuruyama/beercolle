//
//  MasterViewController.m
//  beercolle
//
//  Created by Furuyama Yuuki on 5/27/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = NSLocalizedString(@"Master", @"Master");
        self.title = @"My Cellar";
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];

    // create BeerEntry
    NSManagedObjectContext *context = [CoreDataUtil getManagedObjectContext];
    BeerEntry *newBeer = (BeerEntry*)[NSEntityDescription insertNewObjectForEntityForName:@"BeerEntry" inManagedObjectContext:context];
    [newBeer setName:@"Golden Ale"];
    [newBeer setBrewery:@"Sankt Gallen"];
    [newBeer setStyle:@"Pale Ale"];
    [newBeer setAbv:[NSNumber numberWithFloat:4.8]];
    
    BeerEntry *newBeer2 = (BeerEntry*)[NSEntityDescription insertNewObjectForEntityForName:@"BeerEntry" inManagedObjectContext:context];
    [newBeer2 setName:@"Amber Ale"];
    [newBeer2 setBrewery:@"Sankt Gallen"];
    [newBeer2 setStyle:@"Amber Ale"];
    [newBeer2 setAbv:[NSNumber numberWithFloat:5.2]];
    
    BeerEntry *newBeer3 = (BeerEntry*)[NSEntityDescription insertNewObjectForEntityForName:@"BeerEntry" inManagedObjectContext:context];
    [newBeer3 setName:@"Rising Sun Pale Ale"];
    [newBeer3 setBrewery:@"Baird Brewing"];
    [newBeer3 setStyle:@"Pale Ale"];
    [newBeer3 setAbv:[NSNumber numberWithFloat:5.1]];
    
    // save
    NSError *error = nil;
    [context save:&error];
    if (error != nil) {
        Log(@"context save error");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSManagedObjectContext *context = [CoreDataUtil getManagedObjectContext];
    NSMutableArray *beerEntries = [BeerEntry getAllBeerEntriesWithContext:context];
    return [beerEntries count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BeerListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BeerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        NSManagedObjectContext *context = [CoreDataUtil getManagedObjectContext];
        NSMutableArray *beerEntries = [BeerEntry getAllBeerEntriesWithContext:context];
        BeerEntry *beer = [beerEntries objectAtIndex:indexPath.row];
        
        UIImage *thumbnail = [UIImage imageNamed:@"sample-beer.png"];
        cell.thumbnail.image = thumbnail;
        cell.nameLabel.text = beer.name;
        cell.breweryLabel.text = beer.brewery;
    }

    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
}

@end
