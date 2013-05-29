//
//  MHListener.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 5/28/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHListener.h"
#import <objc/runtime.h>

@implementation MHListener

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithApp:(iTunesApplication*) inputApp{
    if( self = [super init] ){
        self.app = inputApp;
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                selector:@selector(updateTrackInfo:)
                    name:@"com.apple.iTunes.playerInfo"
                  object:nil];
        self.lastAlbum = [[NSString alloc] initWithString:_app.currentTrack.album];
        self.lastTitle = [[NSString alloc] initWithString:_app.currentTrack.name];
    }
    return self;
}

- (iTunesTrack*)getCurrentTrack{
    iTunesTrack *currentTrack = _app.currentTrack;
    return currentTrack;
}

- (void) updateTrackInfo:(NSNotification *)notification {
    NSDictionary *information = [notification userInfo];
    NSLog(@"track information: %@", information);
    if ([information[@"Player State"] isEqualToString:@"Playing"]){
        iTunesTrack *current = [self getCurrentTrack];
        if (![_lastTitle isEqualToString:current.name]){
            if (![_lastAlbum isEqualToString:current.album]){
                [self sendRequest:true];
                [_lastAlbum release];
                self.lastAlbum = [[NSString alloc] initWithString:_app.currentTrack.album];
            }else
                [self sendRequest:false];
            [_lastTitle release];
            self.lastTitle = [[NSString alloc] initWithString:_app.currentTrack.name];
        }
    }
}



- (void)sendRequest:(bool) newAlbum{

    iTunesTrack *current = [self getCurrentTrack];
    // Create the URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:@"http://localhost:8080/"]];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    if (newAlbum){
        // Convert the NSImage to NSData
        iTunesArtwork *albumArt = [self getCurrentTrack].artworks[0];
        const char* className = class_getName([albumArt.rawData class]);
        NSLog(@"albumArt.data is a: %s", className);
        //if ([albumArt.data isMemberOfClass:[NSImage class]]) {
            //NSImage * image = albumArt.data;
            NSData *imageData = albumArt.rawData;
            NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
            imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
            // file
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"albumArt\"; filename=\"album.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //}
    }
    
    // title 
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", [current name]] dataUsingEncoding:NSUTF8StringEncoding]];

    // artist
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"artist\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", [current artist]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // album
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"album\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", [current album]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil ];
    
    [request release];
}



@end
