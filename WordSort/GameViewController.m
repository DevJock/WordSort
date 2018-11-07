//
//  GameViewController.m
//  SpellCheck
//
//  Created by Chiraag Bangera on 10/3/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "GameViewController.h"
#import "Home.h"

@implementation SKScene (Unarchive)
+ (instancetype)unarchiveFromFile:(NSString *)file
{
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    return scene;
}
@end

@implementation GameViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [self.banner removeFromSuperview];
    self.banner.delegate = nil;
    self.banner = nil;
}


-(void)viewWillAppear:(BOOL)animated
{
    if([appDelegate.appUnlocked isEqualToString:@"Unlocked"])
    {
    self.canDisplayBannerAds = NO;
    }
    else
    {
    self.canDisplayBannerAds = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.appUnlocked = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppUnlockStatus"];
    appDelegate.customWordFile = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserCustomFile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if(![localPlayer isAuthenticated])
    {
    [self authenticateLocalPlayer];
    }
    if([appDelegate.appUnlocked isEqualToString:@"Unlocked"])
    {
    [self.banner layoutSubviews];
    self.banner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.banner.delegate = self;
    [self.banner sizeToFit];
    self.canDisplayBannerAds = NO;
    }
    else
    {
    [self.banner layoutSubviews];
    self.banner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.banner.delegate = self;
    [self.banner sizeToFit];
    self.canDisplayBannerAds = YES;
    }
    // Configure the view.
    SKView * skView = (SKView *)self.originalContentView;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    skView.showsPhysics = NO;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    Home *scene = [Home unarchiveFromFile:@"Home"];
    //Home *scene = [[Home alloc ]init];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [skView presentScene:scene];
}




-(void)checks
{
    [GKAchievement loadAchievementsWithCompletionHandler: ^(NSArray *scores, NSError *error)
    {
        if(error != NULL) { /* error handling */ }
        for (GKAchievement* achievement in scores)
        {
            if([achievement isCompleted])
            {
                if([achievement.identifier isEqualToString:appDelegate.achiv1000])
                {
                    appDelegate.simple = true;
                }
                
                else if([achievement.identifier isEqualToString:appDelegate.beateasy])
                {
                    appDelegate.easy = true;
                }
                
                else if([achievement.identifier isEqualToString:appDelegate.beatmed])
                {
                    appDelegate.medium = true;
                }
                
                else if([achievement.identifier isEqualToString:appDelegate.beathard])
                {
                    appDelegate.hard = true;
                }
                
                else if([achievement.identifier isEqualToString:appDelegate.playcustom])
                {
                    appDelegate.custom = true;
                }
                
            }
        }
        
    }];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (banner.isBannerLoaded) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!banner.isBannerLoaded)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void) authenticateLocalPlayer
{
    NSLog(@"Logging in to Game Center");
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
            NSLog(@"Authenticated Player");
            appDelegate.gameCenterEnabled = true;
            [self checks];
        }
        else
        {
            NSLog(@"Player not Authenticated");
            appDelegate.gameCenterEnabled = false;
        }
    };
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
