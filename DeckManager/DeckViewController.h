//
//  ViewController.h
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "DeckService.h"
#import "DeckTable.h"

@interface DeckViewController : UITableViewController

-(id) initWithService: (id<DeckService>) service;

@property (nonatomic, strong) DeckTable* tableView;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) id<DeckService> service;

@end
