//
//  ViewController.m
//  Latin
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "LookupViewController.h"
#import "TFHpple.h"
#import "HistoryList.h"
#import "HistoryViewController.h"
#import "HistoryItem.h"

@interface LookupViewController ()

@property (nonatomic) WhitakerScraper *scraper;

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong, nonatomic) HistoryList *historyList;
@property (weak, nonatomic) HistoryViewController *historyViewController;

// stores the target language for the query-in-progress. Assigned on query start and
// nulled when the query finishes
@property (nonatomic) WhitakerScraperTargetLanguage currentQueryTargetLanguage;

@end

@implementation LookupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.definitionTextView.font = [NSFont fontWithName:@"Menlo" size:12];
    
    self.scraper = [WhitakerScraper new];
    self.scraper.delegate = self;
    
    self.historyList = [HistoryList sharedHistoryList];
    
    self.historyViewController = (HistoryViewController *)self.parentViewController.childViewControllers[1];
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)lookupWord:(NSString *)word inLanguage:(WhitakerScraperTargetLanguage)targetLanguage {
    self.currentQueryTargetLanguage = targetLanguage;
    
    [self.scraper initiateRequestForWord:word targetLanguage:targetLanguage];
    
    [self.progressIndicator startAnimation:self];
}

- (IBAction)wordTextFieldReturned:(NSTextField *)sender {
    [self lookupWord:sender.stringValue inLanguage:self.languageControl.selectedSegment];
}

- (void)definitionLoaded:(NSString *)definition forWord:(NSString *)word {
    self.definitionTextView.string = definition;
    
    HistoryItem *historyItem = [[HistoryItem alloc] initWithWord:word definition:definition targetLanguage:self.currentQueryTargetLanguage];
    
    self.currentQueryTargetLanguage = -1;
    
    [self.historyList addHistoryItem:historyItem];
    
    [self.historyViewController updateHistoryView];
    
    [self.progressIndicator stopAnimation:self];
}

- (IBAction)languageControlChanged:(NSSegmentedControl *)sender {
    if([self.wordTextField.stringValue isEqualToString:@""]) {
        return;
    }
   else {
       [self lookupWord:self.wordTextField.stringValue inLanguage:sender.selectedSegment];
       return;
   }
}

#pragma mark - WhitakerScraper delegate

- (void)whitakerScraper:(WhitakerScraper *)scraper loadingFailedWithError:(NSError *)error {
    NSString* asciiError = @"  _    _ _                _     _ \n | |  | | |              | |   | |\n | |  | | |__ ______ ___ | |__ | |\n | |  | | '_ \\______/ _ \\| '_ \\| |\n | |__| | | | |    | (_) | | | |_|\n  \\____/|_| |_|     \\___/|_| |_(_)";
    
    self.definitionTextView.string = [NSString stringWithFormat:@"%@\n\n%@", asciiError, error.localizedDescription];
    
    [self.progressIndicator stopAnimation:self];
}

-(void)whitakerScraper:(WhitakerScraper *)scraper loadedDefinition:(NSString *)definition {
    self.definitionTextView.string = definition;
    
    HistoryItem *historyItem = [[HistoryItem alloc] initWithWord:scraper.word definition:definition targetLanguage:self.currentQueryTargetLanguage];
    
    self.currentQueryTargetLanguage = -1;
    
    [self.historyList addHistoryItem:historyItem];
    
    [self.historyViewController updateHistoryView];
    
    [self.progressIndicator stopAnimation:self];
}

@end
