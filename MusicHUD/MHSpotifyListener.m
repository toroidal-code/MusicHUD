//
//  MHSpotifyListener.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/31/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHSpotifyListener.h"
#import "MHRequest.h"

@implementation MHSpotifyListener


- (id)init{
    if( self = [super init] ){
        self.app = (SpotifyApplication*)[SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                            selector:@selector(updateTrackInfo:)
                                                                name:@"com.spotify.client.PlaybackStateChanged"
                                                              object:nil];
        self.lastAlbum = [NSString stringWithString:_app.currentTrack.album];
        self.lastTitle = [NSString stringWithString:_app.currentTrack.name];
    }
    return self;
}

- (SpotifyTrack*)getCurrentTrack{
    SpotifyTrack *currentTrack = _app.currentTrack;
    return currentTrack;
}

- (void) updateTrackInfo:(NSNotification *)notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);
    SpotifyTrack *current = [self getCurrentTrack];
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
    SpotifyTrack *current = [self getCurrentTrack];
    if (newAlbum){
        [MHRequest sendRequestWithTitle:current.name
                             withArtist:current.artist
                              withAlbum:current.album
                           withAlbumArt:[current.artwork TIFFRepresentation]];
    } else
        [MHRequest sendRequestWithTitle:current.name
                             withArtist:current.artist
                              withAlbum:current.album];
}




@end
