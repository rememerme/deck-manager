//
//  PhraseDeckService.m
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "PhraseDeckService.h"

@implementation PhraseDeckService

NSString* const PhraseDeckURL = @"http://nomnom.rememerme.com:8003/rest/v1/phrase-decks/";
@synthesize dDao = _dDao;
@synthesize upDao = _upDao;
@synthesize user = _user;


-(id) initWithUser:(User *) user inManagedObjectContext:(NSManagedObjectContext *) ctx{
    self = [super init];
    _user = user;
    _dDao = [[PhraseDeckDao alloc] initWithNSManagedObjectContext: ctx];
    _upDao = [[UpdateDao alloc] initWithNSManagedObjectContext: ctx];
    return self;
}

-(void) updateDeckList {
    // Get the list of updates from the pharse deck service
    NSString* urlString = [self addSinceParamTo: [self addAccessTokenTo:PhraseDeckURL withAmp: false] withAmp: true];
    NSLog(@"%@", urlString);
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError* requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData* adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    if(adata && [response statusCode] == 200) {
        Update* up = [_upDao getLatestUpdate];
        up.phrase_decks = [NSDate date];
        [self parseDeckListWithData: adata];
        
        // save core data
        NSError* coreDataError;
        [_dDao.managedObjectContext save: &coreDataError];
    }
    else {
        NSLog(@"Request error %@", requestError);
    }

}

-(PhraseDeck*) createDeck: (NSDictionary *) postDeck {
    // setup the URL with the access token given by the session_id
    NSString* urlString = [self addAccessTokenTo:PhraseDeckURL withAmp:false];
    NSLog(@"%@", urlString);
    
    // prepare the request to the URL
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    
    // create a post dictionary using content-type application/json
    NSError* requestError = nil;
    NSData* jsonRequest = [NSJSONSerialization dataWithJSONObject: postDeck options:0 error:&requestError];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonRequest];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData* adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    if(adata && [response statusCode] == 200) {
        PhraseDeck* deck = [self parseDeckWithData: adata];
        
        // save core data
        NSError* coreDataError;
        [_dDao.managedObjectContext save: &coreDataError];
        
        return deck;
    }
    else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }
}

#pragma mark private methods

-(PhraseDeck*) parseDeckWithData: (NSData*) adata {
    NSError* parseError = nil;
    NSDictionary* deckDict = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
    
    if (deckDict) {
        return [_dDao createDeckWithDictionary: deckDict];
    }
    
    NSLog(@"Parse error %@", parseError);
    return nil;
}

-(NSArray*) parseDeckListWithData: (NSData*) adata {
    // Handle the response
    NSLog(@"Friend Response Success");
        
    NSError* parseError = nil;
    NSArray* decksArray = [NSJSONSerialization JSONObjectWithData:adata options:kNilOptions error:&parseError];
    NSLog(@"%@", decksArray);
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
        
    if(decksArray) {
        for (NSDictionary* deck in decksArray) {
            PhraseDeck* d = [_dDao createDeckWithDictionary: deck];
            [retArray addObject:d];
        }
    }
    else {
        NSLog(@"Parse error %@", parseError);
    }
        
    return [[NSArray alloc] initWithArray:retArray];
}

-(NSString*) addSinceParamTo: (NSString*) url withAmp: (BOOL) amp {
    Update* update = [_upDao getLatestUpdate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    if (update.phrase_decks == nil) {
        return url;
    }
    
    NSString* lastLookup = [formatter stringFromDate:update.phrase_decks];
    
    if (amp) {
        return [url stringByAppendingString: [@"&since=" stringByAppendingString: lastLookup]];
    }
    else {
        return [url stringByAppendingString: [@"?since=" stringByAppendingString: lastLookup]];
    }
}

-(NSString*) addAccessTokenTo: (NSString*) url withAmp: (BOOL) amp {
    if (!amp) {
        return [url stringByAppendingString:[@"?access_token=" stringByAppendingString:_user.session_id]];
    }
    else {
        return [url stringByAppendingString:[@"&access_token=" stringByAppendingString:_user.session_id]];
    }
}

@end
