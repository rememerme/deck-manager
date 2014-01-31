//
//  HomeViewController.h
//  DeckManager
//
//  Created by Andrew Oberlin on 1/23/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "DeckViewController.h"
#import "MockDeckService.h"

@interface HomeViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, strong) User* user;
@property (atomic, strong) DeckViewController* phraseDeckController;
@property (atomic, strong) DeckViewController* nominationDeckController;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic) UITabBarController *tabBarController;

-(id)initWithUser: (User*) user inManagedObjectContext:(NSManagedObjectContext *)ctx;

@end
