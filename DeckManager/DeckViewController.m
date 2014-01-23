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
	// Do any additional setup after loading the view, typically from a nib.
    
    DeckTable* tableView = [[DeckTable alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] andStyle:UITableViewStylePlain andService: _service];
    [tableView reloadData];
    
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
    
}


@end
