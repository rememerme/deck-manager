//
//  PhraseDeckService.m
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "PhraseDeckService.h"

@implementation PhraseDeckService

@synthesize user = _user;
NSString* const PhraseDeckURL = @"http://nomnom.rememerme.com:8003/rest/v1/phrase-decks/";


-(id) initWithUser:(User *) user {
    self = [super init];
    _user = user;
    return self;
}

-(NSArray*) getDeckList {
    NSString* urlString = [self addAccessTokenTo:PhraseDeckURL];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError* requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData* adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    if(adata && [response statusCode] == 200) {
        return [PhraseDeckService parseDeckListWithData: adata];
    }
    else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }

}

-(Deck *) createWithDeck: (Deck *) deck {
    // setup the URL with the access token given by the session_id
    NSString* urlString = [self addAccessTokenTo:PhraseDeckURL];
    NSLog(@"%@", urlString);
    
    // prepare the request to the URL
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    
    // create a post dictionary using content-type application/json
    NSArray* objects = [NSArray arrayWithObjects: deck.name, deck.description, nil];
    NSArray* keys = [NSArray arrayWithObjects:@"description", @"name", nil];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSError* requestError = nil;
    NSData* jsonRequest = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&requestError];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData* adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    if(adata && [response statusCode] == 200) {
        return [PhraseDeckService parseDeckWithData: adata];
    }
    else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }
}

-(void) updateCardsFromDeck: (Deck *) deck {
    
}

#pragma mark private methods

+(Deck*) parseDeckWithData: (NSData*) adata {
    NSError* parseError = nil;
    NSDictionary* deckDict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
    
    if (deckDict) {
        return [[Deck alloc] initWithDictionary:deckDict];
    }
    
    NSLog(@"Parse error %@", parseError);
    return nil;
}

+(NSArray*) parseDeckListWithData: (NSData*) adata {
    // Handle the response
    NSLog(@"Friend Response Success");
        
    NSError* parseError = nil;
    NSArray* decksArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
    NSLog(@"%@", decksArray);
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
        
    if(decksArray) {
        for (NSDictionary* deck in decksArray) {
            Deck* d = [[Deck alloc] initWithDictionary: deck];
            [retArray addObject:d];
        }
    }
    else {
        NSLog(@"Parse error %@", parseError);
    }
        
    return [[NSArray alloc] initWithArray:retArray];
}

-(NSString*) addAccessTokenTo: (NSString*) url {
    return [url stringByAppendingString:[@"?access_token=" stringByAppendingString:_user.session_id]];
}

@end
