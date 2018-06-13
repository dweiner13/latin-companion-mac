//
//  WhitakerScraper.m
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "WhitakerScraper.h"
#import "TFHpple.h"

@interface WhitakerScraper ()

@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) NSURLConnection *currentConnection;

@end

@implementation WhitakerScraper

- (void)initiateRequestForWord:(NSString *)word targetLanguage:(WhitakerScraperTargetLanguage)targetLanguage {
    // cancel a connection if there is one already in progress
    if(self.currentConnection) {
        [self.currentConnection cancel];
        self.currentConnection = nil;
    }

    self.word = word;
    
    NSString *baseURL = [NSString new];
    if (targetLanguage==WhitakerScraperTargetLanguageEnglish) {
        baseURL = @"http://www.archives.nd.edu/cgi-bin/wordz.pl?keyword=";
    }
    else {
        baseURL = @"http://www.archives.nd.edu/cgi-bin/wordz.pl?english=";
    }
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURL, word]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    
    self.receivedData = [NSMutableData new];
    
    self.currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!self.currentConnection) {
        NSLog(@"connection nil??");
        
        self.receivedData = nil;
        self.word = nil;
        self.currentConnection = nil;
    }
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate whitakerScraper:self loadingFailedWithError:error];
    
    self.receivedData = nil;
    self.word = nil;
    self.currentConnection = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    TFHpple *definitionParser = [TFHpple hppleWithHTMLData:self.receivedData];

    NSString *definitionXpathQueryString = @"//pre";

    NSArray *definitionNodes = [definitionParser searchWithXPathQuery:definitionXpathQueryString];
    
    NSString *definition = [[[definitionNodes firstObject] content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.delegate whitakerScraper:self loadedDefinition:definition];
    
    self.receivedData = nil;
    self.word = nil;
    self.currentConnection = nil;
}

@end
