//
//  Updates.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/30/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Update : NSManagedObject

@property (nonatomic, retain) NSDate * phrase_decks;
@property (nonatomic, retain) NSDate * nomination_decks;

@end
