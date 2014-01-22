//
//  DeckService.h
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "User.h"

@interface PhraseDeckService : NSObject

-(NSArray*) getDeckListWithUser: (User*) user;

-(NSArray*) getFakeDeckList;

@end
