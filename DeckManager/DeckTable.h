//
//  DeckTable.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/23/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeckService.h"

@interface DeckTable : UITableView <UITableViewDelegate, UITableViewDataSource>

-(id) initWithFrame: (CGRect) frame andStyle: (UITableViewStyle) style andService: (id<DeckService>) service;

@property (nonatomic, strong) id<DeckService> service;
@property (nonatomic, strong) NSArray* decks;

@end
