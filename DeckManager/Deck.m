//
//  Deck.m
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(id) initWithDictionary: (NSDictionary*) dict
{
    self = [super init];
    _deck_id = (NSString*) [dict objectForKey:@"deck_id"];
    _description = (NSString *) [dict objectForKey:@"description"];
    _name = (NSString *) [dict objectForKey:@"name"];
    return self;
}

@end
