//
//  FileExplorer.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/12/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameLib.h"
#import "AppDelegate.h"

@interface FileExplorer : UITableViewController
{
    AppDelegate *appDelegate;
    GameLib *gl;
}
- (IBAction)backButton:(id)sender;


@end
