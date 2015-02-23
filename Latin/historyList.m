//
//  historyList.m
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "HistoryList.h"

@interface HistoryList ()

@property (strong, nonatomic) NSMutableArray *history;

@end

@implementation HistoryList

- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *storedHistory = [defaults objectForKey:@"history"];
        if(storedHistory) {
            _history = [[NSKeyedUnarchiver unarchiveObjectWithData:storedHistory] mutableCopy];
        }
        else {
            _history = [NSMutableArray array];
        }
    }
    
    return self;
}

+ (instancetype)sharedHistoryList {
    static HistoryList *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

- (void)addHistoryItem:(NSString *)historyItem {
    [_history insertObject:historyItem atIndex:0];
    [self saveHistory];
    
    [self.delegate historyListChanged:self];
}

- (void)saveHistory {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.history] forKey:@"history"];
    [defaults synchronize];
}

- (void)clearHistory {
    [_history removeAllObjects];
    
    [self saveHistory];
    
    [self.delegate historyListChanged:self];
}

- (NSString *)description {
    return self.history.description;
}

@end
