//
//  HistoryViewController.m
//  Latin Companion
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryList.h"
#import "LookupViewController.h"
#import "HistoryItem.h"

static NSString *cellViewIdentifier = @"historyTableCellView";
static NSString *wordColumnIdentifier = @"wordTableColumn";
static NSString *languageColumnIdentifier = @"languageTableColumn";

@interface HistoryViewController ()

@property (weak) IBOutlet NSTableView *tableView;
@property (strong, nonatomic) HistoryList *historyList;
@property (weak, nonatomic) LookupViewController *lookupViewController;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.historyList = [HistoryList sharedHistoryList];
    self.historyList.delegate = self;
    
    self.lookupViewController = (LookupViewController *)self.parentViewController.childViewControllers[0];
    
    [self.tableView reloadData];
}

- (void)updateHistoryView {
    [self.tableView reloadData];
}

#pragma mark - NSTableView delegate

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *result = [tableView makeViewWithIdentifier:cellViewIdentifier owner:self];
    
    HistoryItem *historyItem = (HistoryItem *)[self.historyList.history objectAtIndex:row];
    
    if([tableColumn.identifier isEqualToString:wordColumnIdentifier]) {
        result.textField.stringValue = historyItem.word;
    }
    else {
        result.textField.stringValue = historyItem.targetLanguage==WhitakerScraperTargetLanguageEnglish ? @"Latin to English" : @"English to Latin";
    }
    
    return result;
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    HistoryItem *historyItem = (HistoryItem *)[self.historyList.history objectAtIndex:row];
    
    self.lookupViewController.wordTextField.stringValue = historyItem.word;
    self.lookupViewController.definitionTextView.string = historyItem.definition;
    self.lookupViewController.languageControl.selectedSegment = historyItem.targetLanguage;
    
    return YES;
}

-(void)historyListChanged:(id)historyList {
    [self.tableView reloadData];
}

#pragma mark - NSTableView data source

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.historyList.history.count;
}

@end
