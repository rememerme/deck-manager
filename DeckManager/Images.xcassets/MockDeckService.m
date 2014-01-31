//
//  MockDeckService.m
//  DeckManager
//
//  Created by Andy Oberlin on 1/23/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "MockDeckService.h"

@implementation MockDeckService

@synthesize user = _user;
@synthesize dDao = _dDao;
@synthesize upDao = _upDao;

-(id) initWithUser: (User *) user inManagedObjectContext: (NSManagedObjectContext*) ctx {
    self = [super init];
    _user = user;
    _dDao = [[PhraseDeckDao alloc] initWithNSManagedObjectContext: ctx];
    _upDao = [[UpdateDao alloc] initWithNSManagedObjectContext: ctx];
    return self;
}

-(void) updateDeckList {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[@"decks_test.json" stringByDeletingPathExtension] ofType:[@"decks_test.json" pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    [self parseDeckListWithData: data];
    NSError* error;
    [_dDao.managedObjectContext save:&error];
}

-(id<Deck>) createDeck: (NSDictionary *) deck_dict {
    PhraseDeck* deck = [_dDao createDeckWithDictionary: deck_dict];
    deck.deck_id = [[NSUUID UUID] UUIDString];
    
    NSError* error;
    [_dDao.managedObjectContext save: &error];
    
    return deck;
}

#pragma mark private methods

-(NSArray*) parseDeckListWithData: (NSData*) adata {
    NSError* parseError = nil;
    NSArray* decksArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
    NSLog(@"%@", decksArray);
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    if(decksArray) {
        for (NSDictionary* deck in decksArray) {
            PhraseDeck* d = [_dDao createDeckWithDictionary:deck];
            [retArray addObject:d];
        }
    }
    else {
        NSLog(@"Parse error %@", parseError);
    }
    
    return [[NSArray alloc] initWithArray:retArray];
}

@end
