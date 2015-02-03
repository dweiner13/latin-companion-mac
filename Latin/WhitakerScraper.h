//
//  WhitakerScraper.h
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WhitakerScraperDelegate.h"

@interface WhitakerScraper : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSString *word;

typedef NS_ENUM(NSInteger, WhitakerScraperTargetLanguage) {
    WhitakerScraperTargetLanguageEnglish = 0,
    WhitakerScraperTargetLanguageLatin = 1
};

@property (strong, nonatomic) id<WhitakerScraperDelegate> delegate;

- (void)initiateRequestForWord:(NSString *)word targetLanguage:(WhitakerScraperTargetLanguage)targetLanguage;

@end
