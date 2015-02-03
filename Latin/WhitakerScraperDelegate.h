//
//  WhitakerScraperDelegate.h
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/3/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

@class WhitakerScraper;

@protocol WhitakerScraperDelegate

- (void)whitakerScraper:(WhitakerScraper *)scraper loadedDefinition:(NSString *)definition;
- (void)whitakerScraper:(WhitakerScraper *)scraper loadingFailedWithError:(NSError *)error;

@end
