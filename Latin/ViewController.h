//
//  ViewController.h
//  Latin
//
//  Created by Daniel A. Weiner on 2/2/15.
//  Copyright (c) 2015 Daniel Weiner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *wordTextField;

@property (unsafe_unretained) IBOutlet NSTextView *definitionTextView;

- (IBAction)wordTextFieldReturned:(NSTextField *)sender;

@end