//
// Created by Katherine Whitlock on 5/29/13.
// Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MHRequest.h"


@implementation MHRequest

+ (void)sendRequestWithTitle:(NSString *)title withArtist:(NSString *)artist withAlbum:(NSString *)album {
    [MHRequest sendRequestWithTitle:title
                         withArtist:artist
                          withAlbum:album
                       withAlbumArt:nil];
}

+ (void) sendRequestWithTitle:(NSString *)title withArtist:(NSString *)artist withAlbum:(NSString *)album withAlbumArt:(NSData *)albumArt{

    // Create the URL request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost:8080/"]];

    [request setHTTPMethod:@"POST"];

    NSMutableData *body = [NSMutableData data];

    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    if (albumArt){
        // Convert the NSImage to NSData
        NSData* imageData = [[NSBitmapImageRep imageRepWithData:albumArt] representationUsingType:NSPNGFileType properties:nil];

        // file
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"albumArt\"; filename=\"album.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }

    // title
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", title] dataUsingEncoding:NSUTF8StringEncoding]];

    // artist
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"artist\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", artist] dataUsingEncoding:NSUTF8StringEncoding]];

    // album
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"album\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", album] dataUsingEncoding:NSUTF8StringEncoding]];

    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    // set request body
    [request setHTTPBody:body];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil ];

    [request release];
}


@end