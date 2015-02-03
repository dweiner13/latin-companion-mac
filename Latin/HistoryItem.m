//
//  HistoryItem.m
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "HistoryItem.h"

@implementation HistoryItem

- (instancetype) initWithWord:(NSString*)word
                   definition:(NSString*)definition
               targetLanguage:(WhitakerScraperTargetLanguage)targetLanguage {
    self = [super init];
    if (self) {
        _word = [word copy];
        _definition = [definition copy];
        _targetLanguage = targetLanguage;
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.word forKey:@"word"];
    [aCoder encodeObject:self.definition forKey:@"definition"];
    [aCoder encodeInteger:self.targetLanguage forKey:@"targetLanguage"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [[HistoryItem alloc] init];
    
    if(self != nil) {
        _word = [aDecoder decodeObjectForKey:@"word"];
        _definition = [aDecoder decodeObjectForKey:@"definition"];
        _targetLanguage = [aDecoder decodeIntegerForKey:@"targetLanguage"];
    }
                           
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"Word: %@, Language: %li", self.word, self.targetLanguage];
}

@end