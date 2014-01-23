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
#import "DeckService.h"

@interface PhraseDeckService : NSObject <DeckService>

// Constants for this service
FOUNDATION_EXPORT NSString *const PhraseDeckURL;

@end
