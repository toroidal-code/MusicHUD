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
@property (nonatomic, strong) SpotifyApplication* app;
@property (nonatomic, strong) NSString* lastTitle;
@property (nonatomic, strong) NSString* lastAlbum;
@end

