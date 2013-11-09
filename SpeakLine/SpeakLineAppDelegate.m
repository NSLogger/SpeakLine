//
//  SpeakLineAppDelegate.m
//  SpeakLine
//
//  Created by Arun Agrawal on 08/11/13.
//  Copyright (c) 2013 Arun Agrawal. All rights reserved.
//

#import "SpeakLineAppDelegate.h"

@implementation SpeakLineAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(id)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"Init");
        
        _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
        
        [_speechSynth setDelegate:self];
        
        _voices = [NSSpeechSynthesizer availableVoices];
    }
    return self;
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    NSLog(@"finished speaking = %d", finishedSpeaking);
    
    [_stopButton setEnabled:NO];
    [_startButton setEnabled:YES];
    [_tableView setEnabled:YES];
}

- (IBAction)sayIt:(id)sender {
    NSString *string = [_textField stringValue];
    
    if ([string length] == 0) {
        NSLog(@"String from %@ is zero length", _textField);
    }
    
    [_speechSynth startSpeakingString:string];
    
    NSLog(@"Have started to say: %@", string);
    
    [_stopButton setEnabled:YES];
    [_startButton setEnabled:NO];
    [_tableView setEnabled:NO];
    
}

- (IBAction)stopIt:(id)sender {
    NSLog(@"Stopping");
    
    [_speechSynth stopSpeaking];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    return (NSInteger)[_voices count];
}

- (id)tableView:(NSTableView *)tv
        objectValueForTableColumn:(NSTableColumn *)tableColumn
                                row:(NSInteger)row
{
    NSString *v = [_voices objectAtIndex:row];
    NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
    
    return [dict objectForKey:NSVoiceName];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [_tableView selectedRow];
    
    if (row == -1) {
        return;
    }
    
    NSString *selectedVoice = [_voices objectAtIndex:row];
    
    [_speechSynth setVoice:selectedVoice];
    NSLog(@"new voice = %@", selectedVoice);
}

- (void)awakeFromNib
{
    NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
    NSInteger defaultRow = [_voices indexOfObject:defaultVoice];
    NSIndexSet *indices = [NSIndexSet indexSetWithIndex:defaultRow];
    [_tableView selectRowIndexes:indices byExtendingSelection:NO];
    [_tableView scrollRowToVisible:defaultRow];
    
}
@end
