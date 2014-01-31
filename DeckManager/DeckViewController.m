//
//  ViewController.m
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "DeckViewController.h"

@interface DeckViewController ()

@end

@implementation DeckViewController

-(id) initWithService: (id<DeckService>) service {
    self = [super init];
    _service = service;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// change the icon on the right navigation bar to the plus
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createDeck:)];
    
    /// initialize the DeckTable for showing the decks
    DeckTable* tableView = [[DeckTable alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] andStyle:UITableViewStylePlain andService: _service];
    [tableView reloadData];
    
    // initialize the refresh control
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshDecks:)forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    self.tableView = tableView;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark private methods

-(void) refreshDecks:(id)selector {
    // update the deck list using the service
    [_service updateDeckList];
    
    // get the new decks from core data
    self.tableView.decks = [_service.dDao getDecks];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void) createDeck: (id) selector {
    CreateDeckViewController* cdvc = [[CreateDeckViewController alloc] initWithUser:_user andService: _service];
    [self.navigationController pushViewController: cdvc animated:YES];
}


@end
