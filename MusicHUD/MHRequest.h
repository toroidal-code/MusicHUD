//
// Created by Katherine Whitlock on 5/29/13.
// Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface MHRequest : NSObject
+ (void) sendRequestWithTitle:(NSString*)title
                   withArtist:(NSString*)artist
                    withAlbum:(NSString*)album;

+ (void) sendRequestWithTitle:(NSString*)title
                   withArtist:(NSString*)artist
                    withAlbum:(NSString*)album
                 withAlbumArt:(NSData*)albumArt;
@end