//
//  CreateDeckViewController.h
//  DeckManager
//
//  Created by Andy Oberlin on 1/31/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "DeckService.h"
#import "DeckInfoView.h"
#import "CreateCancelButtonsView.h"

@interface CreateDeckViewController : UIViewController

-(id) initWithUser: (User*) user andService: (id<DeckService>) service;

@property (nonatomic, strong) DeckInfoView* deckInfoView;
@property (nonatomic, strong) CreateCancelButtonsView* ccbView;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) id<DeckService> service;

@end
