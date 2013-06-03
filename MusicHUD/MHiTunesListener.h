//
//  MHiTunesListener.h
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"

@interface MHiTunesListener : NSObject{
    iTunesApplication* _app;
    NSString* _lastTitle;
    NSString* _lastAlbum;
}
- (iTunesTrack*)getCurrentTrack;
- (void) updateTrackInfo:(NSNotification *)notification;
@property (nonatomic, strong) iTunesApplication* app;
@property (nonatomic, strong) NSString* lastTitle;
@property (nonatomic, strong) NSString* lastAlbum;
@end

