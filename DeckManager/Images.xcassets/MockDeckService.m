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

-(id) initWithUser: (User *) user {
    self = [super init];
    _user = user;
    return self;
}

-(NSArray*) getDeckList
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[@"decks_test.json" stringByDeletingPathExtension] ofType:[@"decks_test.json" pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    return [self parseDeckListWithData: data];
}

-(Deck*) createWithDeck: (Deck *) deck {
    deck.deck_id = [[NSUUID UUID] UUIDString];
    return deck;
}

-(void) updateCardsFromDeck: (Deck *) deck {
    
}

#pragma mark private methods

-(NSArray*) parseDeckListWithData: (NSData*) adata {
    NSError* parseError = nil;
    NSArray* decksArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
    NSLog(@"%@", decksArray);
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    if(decksArray) {
        for (NSDictionary* deck in decksArray) {
            Deck* d = [[Deck alloc] initWithDictionary: deck];
            [retArray addObject:d];
        }
    }
    else {
        NSLog(@"Parse error %@", parseError);
    }
    
    return [[NSArray alloc] initWithArray:retArray];
}

@end
