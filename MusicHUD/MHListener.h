//
//  MHListener.h
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"

@interface MHListener : NSObject{
    iTunesApplication* _app;
    NSString* _lastTitle;
    NSString* _lastAlbum;
}
- (id)initWithApp:(iTunesApplication*) inputApp;
- (iTunesTrack*)getCurrentTrack;
- (void) updateTrackInfo:(NSNotification *)notification;
@property (nonatomic, retain) iTunesApplication* app;
@property (nonatomic, retain) NSString* lastTitle;
@property (nonatomic, retain) NSString* lastAlbum;
@end

