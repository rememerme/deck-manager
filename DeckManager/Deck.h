//
//  Deck.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/30/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Deck <NSObject>

@property (nonatomic, retain) NSString* deck_id;
@property (nonatomic, retain) NSString* description_text;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSDate* last_modified;
@property (nonatomic, retain) NSDate* date_created;
@property (nonatomic, retain) NSDate* cards_last_updated;
@property (nonatomic, retain) NSManagedObject* cards;

@end
