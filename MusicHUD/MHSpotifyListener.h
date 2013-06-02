//
//  MHSpotifyListener.h
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/31/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spotify.h"

@interface MHSpotifyListener : NSObject{
    SpotifyApplication* _app;
    NSString* _lastTitle;
    NSString* _lastAlbum;
}
- (void) updateTrackInfo:(NSNotification *)notification;
@property (nonatomic, retain) SpotifyApplication* app;
@property (nonatomic, retain) NSString* lastTitle;
@property (nonatomic, retain) NSString* lastAlbum;
@end

