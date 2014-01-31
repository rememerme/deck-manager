//
//  DeckDao.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/30/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@protocol DeckDao <NSObject>

// Properties of a Deck Dao
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;


// Methods of a Deck Dao
-(id) initWithNSManagedObjectContext: (NSManagedObjectContext*) ctx;

-(NSArray*) getDecks;

-(id<Deck>) getDeckWithID: (NSString*) deck_id;

-(id<Deck>) createDeckWithDictionary: (NSDictionary*) deck_dict;

@end
