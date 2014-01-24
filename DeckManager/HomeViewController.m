//
//  HomeViewController.m
//  DeckManager
//
//  Created by Andrew Oberlin on 1/23/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITabBarDelegate>

@end

@implementation HomeViewController

-(id) initWithUser:(User*) user {
    self = [super init];
    _user = user;
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // create tab bar controller and array to hold the view controllers
    _tabBarController = [[UITabBarController alloc] init];
    
    NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    // setup the services that the deck view controllers will be using
    MockDeckService* pds1 = [[MockDeckService alloc] initWithUser: _user];
    MockDeckService* pds2 = [[MockDeckService alloc] initWithUser: _user];
    
    // setup the controllers themselves as inner views
    _phraseDeckController = [[DeckViewController alloc] initWithService: pds1];
    _nominationDeckController = [[DeckViewController alloc] initWithService: pds2];
    
    // create the nav controller and add the root view controller as its first view
    UINavigationController* phraseDeckNavigationController = [[UINavigationController alloc] initWithRootViewController:_phraseDeckController];
    phraseDeckNavigationController.navigationController.navigationBar.translucent = NO;
    phraseDeckNavigationController.delegate = self;
    
    // create the nav controller for the
    UINavigationController* nominationDeckNavigationController = [[UINavigationController alloc] initWithRootViewController:_nominationDeckController];
    nominationDeckNavigationController.navigationController.navigationBar.translucent = NO;
    nominationDeckNavigationController.delegate = self;
    
    [localControllersArray addObject: phraseDeckNavigationController];
    [localControllersArray addObject: nominationDeckNavigationController];
    
    NSArray* titles = [NSArray arrayWithObjects:@"Phrases", @"Nominations", nil];
    
    _tabBarController.viewControllers = localControllersArray;
    
    for (UIViewController* controller in _tabBarController.viewControllers) {
        controller.title = [titles objectAtIndex: [_tabBarController.viewControllers indexOfObject: controller]];
    }
    
    // add the tabBarController as a subview in the window
    [self.view addSubview:_tabBarController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
