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
    iTunesApplication* app;
}
- (id)initWithApp:(iTunesApplication*) inputApp;
- (iTunesTrack*)getCurrentTrack;
- (void) updateTrackInfo:(NSNotification *)notification;
@end

