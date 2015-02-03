//
//  historyList.h
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryListDelegate.h"

@class HistoryItem;

@interface HistoryList : NSObject

@property (strong, nonatomic) id<HistoryListDelegate> delegate;

+ (instancetype)sharedHistoryList;

- (NSArray *) history;
- (void) addHistoryItem:(HistoryItem*)historyItem;
- (void) clearHistory;

@end
