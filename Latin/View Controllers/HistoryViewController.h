//
//  HistoryViewController.h
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HistoryListDelegate.h"

@interface HistoryViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate, HistoryListDelegate>

- (void)updateHistoryView;

@end
