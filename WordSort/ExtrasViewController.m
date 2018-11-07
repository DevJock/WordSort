//
//  ExtrasViewController.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/11/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "ExtrasViewController.h"
#import "GameViewController.h"

@interface ExtrasViewController ()

@end

@implementation ExtrasViewController

@synthesize chooseBackgroundB,chooseFontB,chooseWordFileB;

#define kUTTypeImage image

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    GameViewController *gvc = [[GameViewController alloc] init];
    gvc.canDisplayBannerAds = NO;
    appDelegate.appUnlocked = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppUnlockStatus"];
    
    if([appDelegate.appUnlocked isEqualToString:@"Unlocked"])
    {
        chooseWordFileB.enabled = true;
        chooseFontB.enabled = true;
        chooseBackgroundB.enabled = true;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gameCenter:(id)sender
{
    if(appDelegate.gameCenterEnabled)
    [self showGameCenter];
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Game Center Unavailable"
                                  message:@"If Game Center is disabled try logging in through the Game Center app"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:@"Open Game Center", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];
    }
}


- (IBAction)returnButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)chooseFont:(id)sender
{

}

- (IBAction)chooseBackground:(id)sender
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)chooseWordFile:(id)sender
{
    //FileExplorer *fe = [[FileExplorer alloc] init];
   // [self presentViewController:fe animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    appDelegate.backgroundImage = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}







- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
        if (viewController != nil)
        {
            //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else if (localPlayer.isAuthenticated)
        {
            //authenticatedPlayer: is an example method name. Create your own method that is called after the loacal player is authenticated.
            NSLog(@"Authenticated Player");
            appDelegate.gameCenterEnabled = true;
        }
        else
        {
            NSLog(@"Player not Authenticated");
            appDelegate.gameCenterEnabled = false;
        }
    };
}




- (void) showGameCenter
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    //gameCenterController.leaderboardIdentifier = appDelegate.leaderboardID;
    gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}



- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
