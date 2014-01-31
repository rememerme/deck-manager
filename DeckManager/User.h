//
//  User.h
//  Nominal Nominations
//
//  Created by Jake Gregg on 1/18/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString* session_id;
@property (nonatomic, strong) NSString* user_id;

-(id) initWithSession: (NSString*) session andID: (NSString*) user_id;

@end
