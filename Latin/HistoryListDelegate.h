//
//  HistoryListDelegate.h
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/3/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

@class HistoryList;

@protocol HistoryListDelegate

- (void)historyListChanged:(HistoryList *)historyList;

@end