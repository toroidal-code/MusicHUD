//
// Created by Katherine Whitlock on 5/29/13.
// Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MHSonoraListener.h"
#import "MHRequest.h"


@implementation MHSonoraListener

- (id)init {
    if (self = [super init]){
        self.app = (SonoraApplication*)[SBApplication applicationWithBundleIdentifier:@"com.iktm.sonora"];
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                            selector:@selector(updateTrackInfo:)
                                                                name:@"com.iktm.Sonora.trackChanged"
                                                              object:nil];
        self.lastAlbum = _app.album ? [NSString stringWithString:_app.album] : @"None";
        self.lastTitle = _app.track ? [NSString stringWithString:_app.track] : @"None";
    }
    return self;
}

- (void)updateTrackInfo:(NSNotification *)notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);
    if (![_lastTitle isEqualToString:_app.track]){
        if (![_lastAlbum isEqualToString:_app.album]){
            [self sendRequest:true];
            self.lastAlbum = [NSString stringWithString:_app.album];
        }else
            [self sendRequest:false];
        self.lastTitle = [NSString stringWithString:_app.track];
    }
}

- (void) sendRequest:(bool)newAlbum{
    if (newAlbum)
        [MHRequest sendRequestWithTitle:_app.track
                             withArtist:_app.artist
                              withAlbum:_app.album
                           withAlbumArt:[_app.artworkImage TIFFRepresentation]];
    else
        [MHRequest sendRequestWithTitle:_app.track
                             withArtist:_app.artist
                              withAlbum:_app.album];
}

@end