//
//  DeckService.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/30/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateDao.h"
#import "DeckDao.h"
#import "User.h"

@protocol DeckService <NSObject>

@property (nonatomic, strong) User* user;
@property (nonatomic, strong) id<DeckDao> dDao;
@property (nonatomic, strong) UpdateDao* upDao;

-(id) initWithUser: (User*) user inManagedObjectContext: (NSManagedObjectContext*) ctx;
-(void) updateDeckList;
-(id<Deck>) createDeck: (NSDictionary *) postDeck;

@end
