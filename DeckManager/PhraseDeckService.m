//
//  PhraseDeckService.m
//  DeckManager
//
//  Created by Jake Gregg on 1/22/14.
//  Copyright (c) 2014 Rememerme. All rights reserved.
//

#import "PhraseDeckService.h"

@implementation PhraseDeckService

-(NSArray*) getDeckListWithUser:(User *)user
{
    NSString *urlString = [@"http://nomnom.rememerme.com:8003/rest/v1/phrase-decks/?access_token=" stringByAppendingString:user.session_id];
    NSLog(@"%@", urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSError* requestError = nil;
    // Make the request
    NSHTTPURLResponse* response = nil;
    NSData* adata = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &requestError];
    if(adata && [response statusCode] == 200) {
        return [self parseDeckListWithData: adata];
    }
    else {
        NSLog(@"Request error %@", requestError);
        return nil;
    }

}

-(NSArray*) getFakeDeckList
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[@"decks_test.json" stringByDeletingPathExtension] ofType:[@"decks_test.json" pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    return [self parseDeckListWithData: data];
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
            Deck* d = [[Deck alloc] initWithDictionary: deck];
            [retArray addObject:d];
        }
    }
    else {
        NSLog(@"Parse error %@", parseError);
    }
        
    return [[NSArray alloc] initWithArray:retArray];
}

@end
