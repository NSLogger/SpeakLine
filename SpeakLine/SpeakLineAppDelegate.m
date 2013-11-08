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
        
    }
    return self;
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking{
    NSLog(@"finished speaking = %d", finishedSpeaking);
    
    [_stopButton setEnabled:NO];
    [_startButton setEnabled:YES];
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
    
}

- (IBAction)stopIt:(id)sender {
    NSLog(@"Stopping");
    
    [_speechSynth stopSpeaking];
}
@end
