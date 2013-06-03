//
//  MHAppDelegate.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHAppDelegate.h"


@implementation MHAppDelegate

-(void)awakeFromNib{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:_statusMenu];
    [statusItem setTitle:@"mh"];
    [statusItem setHighlightMode:YES];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSNotificationCenter* notificationCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidTerminate:)
                               name:@"NSWorkspaceDidTerminateApplicationNotification"
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidTerminate:)
                               name:@"NSWorkspaceDidLaunchApplicationNotification"
                             object:nil];
    [self checkRunning];
}

- (void)checkRunning{
    if ([NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.spotify.client"].count > 0){
        [self setSpotifyListener:[[MHSpotifyListener  alloc] init]];
    }
    if ([NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.iTunes"].count > 0){
        [self setITunesListener:[[MHiTunesListener  alloc] init]];
    }
    if ([NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.iktm.Sonora"].count > 0){
        [self setSonoraListener:[[MHSonoraListener  alloc] init]];
    }

}

- (void) applicationDidTerminate:(NSNotification*)notification
{
    NSDictionary *information = [notification userInfo];
    if ([information[@"NSApplicationBundleIdentifier"] isEqualToString:@"com.spotify.client"])
        [_spotifyListener dealloc];
    else if ([information[@"NSApplicationBundleIdentifier"] isEqualToString:@"com.apple.iTunes"])
        [_iTunesListener dealloc];
    else if ([information[@"NSApplicationBundleIdentifier"] isEqualToString:@"com.iktm.sonora"])
        [_sonoraListener dealloc];
}


- (void) applicationDidLaunch:(NSNotification*)notification
{
    NSDictionary *information = [notification userInfo];
    if ([information[@"NSApplicationBundleIdentifier"] isEqualToString:@"com.spotify.client"])
        [self setSpotifyListener:[[MHSpotifyListener  alloc] init]];
    else if ([information[@"NSApplicationBundleIdentifier"] isEqualToString:@"com.apple.iTunes"])
        [self setITunesListener:[[MHiTunesListener  alloc] init]];
    else if ([information[@"NSApplicationBundleIdentifier"] isEqualToString:@"com.iktm.sonora"])
        [self setSonoraListener:[[MHSonoraListener  alloc] init]];
}

@end
