//
// Created by Katherine Whitlock on 5/29/13.
// Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Sonora.h"

@interface MHSonoraListener : NSObject{
    SonoraApplication *  _app;
    NSString * _lastTitle;
    NSString * _lastAlbum;
}
- (void) updateTrackInfo:(NSNotification *)notification;
@property (nonatomic, retain) SonoraApplication * app;
@property (nonatomic, retain) NSString * lastTitle;
@property (nonatomic, retain) NSString * lastAlbum;

@end