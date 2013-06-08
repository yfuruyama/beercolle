//
//  CountryMaster.h
//  beercolle
//
//  Created by Furuyama Yuuki on 6/8/13.
//  Copyright (c) 2013 Furuyama Yuuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CountryMaster : NSManagedObject

@property (nonatomic, retain) NSString * master_id;
@property (nonatomic, retain) NSString * j_name;
@property (nonatomic, retain) NSString * e_name;

@end
