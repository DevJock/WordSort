//
//  ExtrasViewController.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/11/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "AppDelegate.h"
#include "KWFontPicker.h"
#include "FileExplorer.h"

@interface ExtrasViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKGameCenterControllerDelegate,UIAlertViewDelegate>
{
    AppDelegate *appDelegate;
}
- (IBAction)gameCenter:(id)sender;
- (IBAction)returnButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *chooseFontB;
@property (strong, nonatomic) IBOutlet UIButton *chooseBackgroundB;
@property (strong, nonatomic) IBOutlet UIButton *chooseWordFileB;
- (IBAction)chooseFont:(id)sender;
- (IBAction)chooseBackground:(id)sender;
- (IBAction)chooseWordFile:(id)sender;

@end
