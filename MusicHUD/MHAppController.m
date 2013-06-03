//
//  MHAppController.m
//  MusicHUD
//
//  Created by Katherine Whitlock on 6/3/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import "MHAppController.h"

@implementation MHAppController
@synthesize preferencesController;

-(IBAction)showPreferences:(id)sender{
    if(!self.preferencesController)
        self.preferencesController = [[MHPrefsController alloc] initWithWindowNibName:@"Preferences"];
    
    [self.preferencesController showWindow:self];
}

- (void)dealloc {
    [preferencesController release];
    [super dealloc];
}
@end
