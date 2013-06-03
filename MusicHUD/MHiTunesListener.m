//
//  MHiTunesListener.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHiTunesListener.h"
#import "MHRequest.h"

@implementation MHiTunesListener

- (id)init{
    if( self = [super init] ){
        self.app = (iTunesApplication*)[SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                selector:@selector(updateTrackInfo:)
                    name:@"com.apple.iTunes.playerInfo"
                  object:nil];
        self.lastAlbum = [NSString stringWithString:_app.currentTrack.album];
        self.lastTitle = [NSString stringWithString:_app.currentTrack.name];
    }
    return self;
}

- (iTunesTrack*)getCurrentTrack{
    iTunesTrack *currentTrack = _app.currentTrack;
    return currentTrack;
}

- (void) updateTrackInfo:(NSNotification *)notification {
    //NSDictionary *information = [notification userInfo];
    //NSLog(@"track information: %@", information);
    iTunesTrack *current = [self getCurrentTrack];
    if (![_lastTitle isEqualToString:current.name]){
        if (![_lastAlbum isEqualToString:current.album]){
            [self sendRequest:true];
            self.lastAlbum = [NSString stringWithString:_app.currentTrack.album];
        }else
            [self sendRequest:false];
        self.lastTitle = [NSString stringWithString:_app.currentTrack.name];
    }
}

- (void)sendRequest:(bool) newAlbum{
    iTunesTrack *current = [self getCurrentTrack];
    if (newAlbum){
        iTunesArtwork *albumArt = [self getCurrentTrack].artworks[0];
        [MHRequest sendRequestWithTitle:current.name
                             withArtist:current.artist
                              withAlbum:current.album
                           withAlbumArt:albumArt.rawData];
    } else
        [MHRequest sendRequestWithTitle:current.name
                             withArtist:current.artist
                              withAlbum:current.album];
}



@end
