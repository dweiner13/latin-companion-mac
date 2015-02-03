//
//  AppDelegate.m
//  Latin
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "AppDelegate.h"
#import "HistoryList.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // clear user defaults (for debugging)
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

- (IBAction)clearHistoryMenuItemClicked:(NSMenuItem *)sender {
    [[HistoryList sharedHistoryList] clearHistory];
}

@end
