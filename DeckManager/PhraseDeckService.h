//
//  DeckService.h
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhraseDeck.h"
#import "PhraseDeckDao.h"
#import "DeckService.h"


@interface PhraseDeckService : NSObject <DeckService>

// Constants for this service
FOUNDATION_EXPORT NSString *const PhraseDeckURL;

//@property (nonatomic, strong) User* user;
//@property (nonatomic, strong) PhraseDeckDao* pdDao;
//@property (nonatomic, strong) UpdateDao* upDao;

//-(id) initWithUser: (User*) user inManagedObjectContext: (NSManagedObjectContext*) ctx;
//-(void) updateDeckList;
//-(PhraseDeck*) createDeck: (NSDictionary *) postDeck;

@end
