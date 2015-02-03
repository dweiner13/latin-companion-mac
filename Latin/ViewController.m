//
//  ViewController.m
//  Latin
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.definitionTextView.font = [NSFont fontWithName:@"Menlo" size:12];
    
    // Do any additional setup after loading the view.
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)wordTextFieldReturned:(NSTextField *)sender {
    self.definitionTextView.string = [self definitionForWord:sender.stringValue];
}


- (NSString *)definitionForWord:(NSString *)word {
    NSString *baseURL = @"http://www.archives.nd.edu/cgi-bin/words.exe?";
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURL, word]];
    
    NSData *HTMLData = [NSData dataWithContentsOfURL:requestURL];
    
    TFHpple *definitionParser = [TFHpple hppleWithHTMLData:HTMLData];
    
    NSString *definitionXpathQueryString = @"//pre";
    
    NSArray *definitionNodes = [definitionParser searchWithXPathQuery:definitionXpathQueryString];
    
    return [[definitionNodes firstObject] content];
}

@end
