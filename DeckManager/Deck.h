//
//  Deck.h
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deck : NSObject

@property (nonatomic, strong) NSString* deck_id;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* name;

-(id) initWithDictionary: (NSDictionary*) dict;

@end
