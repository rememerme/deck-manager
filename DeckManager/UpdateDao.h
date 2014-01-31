//
//  UpdateDao.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/30/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Update.h"

@interface UpdateDao : NSObject

// Properties of a Update Dao
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

// Methods of a Update Dao
-(id) initWithNSManagedObjectContext: (NSManagedObjectContext*) ctx;

-(Update*) getLatestUpdate;

@end
