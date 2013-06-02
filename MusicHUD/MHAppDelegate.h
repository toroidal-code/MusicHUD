//
//  MHAppDelegate.h
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MHiTunesListener.h"
#import "MHSonoraListener.h"
#import "MHSpotifyListener.h"

@interface MHAppDelegate : NSObject <NSApplicationDelegate>{
    MHSpotifyListener * _spotifyListener;
    MHiTunesListener * _iTunesListener;
    MHSonoraListener * _sonoraListener;
}
@property (nonatomic, retain) MHSonoraListener* sonoraListener;
@property (nonatomic, retain) MHiTunesListener* iTunesListener;
@property (nonatomic, retain) MHSpotifyListener* spotifyListener;
@end
