//
//  PhraseDeckDao.m
//  DeckManager
//
//  Created by Andy Oberlin on 1/28/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "PhraseDeckDao.h"

@implementation PhraseDeckDao

@synthesize managedObjectContext = _managedObjectContext;

-(id) initWithNSManagedObjectContext:(NSManagedObjectContext *) ctx {
    self = [super init];
    _managedObjectContext = ctx;
    return self;
}

-(NSArray *) getDecks {
    // prepare the request using the ManagedObjectContext
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PhraseDeck" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // make the request for all phrase decks
    NSError *error;
    NSArray* results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"%@", error);
    
    return results;
}

-(PhraseDeck *) getDeckWithID: (NSString *) deck_id {
    // prepare the request using the ManagedObjectContext
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"PhraseDeck" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // set the deck id that is being searched
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"deck_id == %@", deck_id];
    [fetchRequest setPredicate: predicate];
    
    // make the request for all phrase decks
    NSError* error;
    NSArray* results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil || ![results count]) {
        return nil;
    }
    
    return results[0];
}

-(PhraseDeck *) createDeckWithDictionary: (NSDictionary*) deck_dict {
    // lookup to see if the deck already exists
    PhraseDeck* deck = [self getDeckWithID:(NSString*) [deck_dict objectForKey:@"deck_id"]];
    
    if (deck == nil) {
        NSEntityDescription* deckEntity = [NSEntityDescription entityForName:@"PhraseDeck" inManagedObjectContext:_managedObjectContext];

        deck = [[PhraseDeck alloc] initWithEntity: deckEntity insertIntoManagedObjectContext:_managedObjectContext];
    }
    
    deck.deck_id = [deck_dict objectForKey:@"deck_id"];
    deck.date_created = [PhraseDeckDao convertToDateFrom: [deck_dict objectForKey:@"date_created"]];
    deck.last_modified = [PhraseDeckDao convertToDateFrom: [deck_dict objectForKey:@"last_modified"]];
    deck.name = [deck_dict objectForKey:@"name"];
    deck.description_text = [deck_dict objectForKey:@"description"];
    deck.cards_last_updated = [NSDate date];
    
    return deck;
}

+(NSDate*) convertToDateFrom: (NSString*) datestring {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    return [dateFormat dateFromString:datestring];
}

@end
