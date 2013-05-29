//
//  MHAppDelegate.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHAppDelegate.h"
#import "MHListener.h"

@implementation MHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    MHListener* backend = [[MHListener alloc] initWithApp:[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"]];
    NSLog(@"%@",[[backend getCurrentTrack] name]);
}

@end
