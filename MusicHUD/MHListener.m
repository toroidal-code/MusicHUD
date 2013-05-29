//
//  MHListener.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHListener.h"

@implementation MHListener

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithApp:(iTunesApplication*) inputApp{
    if( self = [super init] ){
        app = inputApp;
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                selector:@selector(updateTrackInfo:)
                    name:@"com.apple.iTunes.playerInfo"
                  object:nil];
    }
    return self;
}

- (iTunesTrack*)getCurrentTrack{
    iTunesTrack *currentTrack = app.currentTrack;
    return currentTrack;
}

- (void) updateTrackInfo:(NSNotification *)notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);
}

- (NSImage*)getAlbumArtwork{
    iTunesTrack* currentTrack = [self getCurrentTrack];
    SBElementArray *artworks = [currentTrack artworks];
    iTunesArtwork *artwork = artworks[0];
    return [artwork data];
}

@end
