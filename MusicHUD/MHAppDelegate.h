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
    NSStatusItem * statusItem;
}
@property (nonatomic, strong) MHSonoraListener* sonoraListener;
@property (nonatomic, strong) MHiTunesListener* iTunesListener;
@property (nonatomic, strong) MHSpotifyListener* spotifyListener;
@property (weak) IBOutlet NSMenu *statusMenu;
@end
