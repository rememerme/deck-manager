//
//  User.m
//  Nominal Nominations
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "User.h"

@implementation User

-(id) initWithSession: (NSString*) session andID: (NSString*) user_id {
    self = [self init];
    _user_id = user_id;
    _session_id = session;
    return self;
}

@end
