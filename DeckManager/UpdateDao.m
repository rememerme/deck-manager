//
//  UpdateDao.m
//  DeckManager
//
//  Created by Andy Oberlin on 1/30/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "UpdateDao.h"

@implementation UpdateDao

-(id) initWithNSManagedObjectContext:(NSManagedObjectContext *) ctx {
    self = [super init];
    _managedObjectContext = ctx;
    return self;
}

-(Update*) getLatestUpdate {
    // prepare the request using the ManagedObjectContext
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Update" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // make the request for all phrase decks
    NSError* error;
    NSArray* results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil || ![results count]) {
        return nil;
    }
    
    return results[0];
}

@end
