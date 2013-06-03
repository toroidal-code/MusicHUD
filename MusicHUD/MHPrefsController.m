//
//  MHPrefsController.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 6/3/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHPrefsController.h"

@implementation MHPrefsController

-(id)init{
    if (![super initWithWindowNibName:@"Preferences"])
        return nil;
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

@end
