//
//  DeckService.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/23/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Deck.h"

@protocol DeckService <NSObject>

@property (nonatomic, strong) User* user;

/*
    Constructor for a DeckService that takes into account the user.
*/
-(id) initWithUser: (User*) user;

/*
    Gets a list of decks from the web service. Also, loads the decks into the
    SQLite database for caching.
*/
-(NSArray*) getDeckList;

/*
    Updates the cards in the SQLite database. Automatica
*/
-(void) updateCardsFromDeck: (Deck*) deck;

/*
    Creates a new deck 
*/
-(Deck*) createWithDeck: (Deck*) deck;

@end
