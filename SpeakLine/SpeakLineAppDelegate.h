//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by Arun Agrawal on 08/11/13.
//  Copyright (c) 2013 Arun Agrawal. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpeakLineAppDelegate : NSObject <NSApplicationDelegate, NSSpeechSynthesizerDelegate>
{
    NSArray *_voices;
    NSSpeechSynthesizer *_speechSynth;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *startButton;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)stopIt:(id)sender;
- (IBAction)sayIt:(id)sender;

@end
