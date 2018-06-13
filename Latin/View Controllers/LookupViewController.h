//
//  ViewController.h
//  Latin
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WhitakerScraper.h"

@interface LookupViewController : NSViewController <WhitakerScraperDelegate>

@property (weak) IBOutlet NSTextField *wordTextField;
@property (unsafe_unretained) IBOutlet NSTextView *definitionTextView;
@property (weak) IBOutlet NSSegmentedControl *languageControl;

- (IBAction)wordTextFieldReturned:(NSTextField *)sender;
- (void)definitionLoaded:(NSString *)definition forWord:(NSString *)word;
- (void)lookupWord:(NSString *)word inLanguage:(WhitakerScraperTargetLanguage)targetLanguage;

@end