//
//  MHAppDelegate.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHAppDelegate.h"
#import "MHiTunesListener.h"
#import "MHSonoraListener.h"

@implementation MHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    MHiTunesListener * iTunesListener = [[MHiTunesListener alloc] init];
    MHSonoraListener * sonoraListener = [[MHSonoraListener alloc] init];
}

@end
