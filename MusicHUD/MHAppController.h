//
//  MHAppController.h
//  MusicHUD
//
//  Created by Katherine Whitlock on 6/3/13.
//  Copyright (c) 2013 Katherine Whitlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHPrefsController.h"

@interface MHAppController : NSObject

@property (strong) MHPrefsController *preferencesController;
-(IBAction)showPreferences:(id)sender; 
@end
