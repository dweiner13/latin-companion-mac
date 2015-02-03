//
//  HistoryItem.h
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WhitakerScraper.h"

@interface HistoryItem : NSObject <NSCoding>

@property (nonatomic, readonly) NSString* word;
@property (nonatomic, readonly) NSString* definition;
@property (readonly) WhitakerScraperTargetLanguage targetLanguage;

- (instancetype) initWithWord:(NSString*)word
                   definition:(NSString*)definition
               targetLanguage:(WhitakerScraperTargetLanguage)targetLanguage;

@end
