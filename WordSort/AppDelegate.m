//
//  AppDelegate.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/3/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize runable,gameMode,leaderboardID,gameCenterEnabled,wordsGenerated,keys,numberofwordsgenerated,wordTimer,stringArray,appUnlocked,inAppPurchaseID,backgroundImage,wordFont,customWordFile,easyleaderboardID,medleaderboardID,hardleaderboardID,achiv1000,beateasy,beathard,beatmed,playcustom,simple,easy,medium,hard,custom;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    leaderboardID = @"com.ChiraagBangera.WordSort.TopPlayers";
    easyleaderboardID = @"com.ChiraagBangera.WordSort.EasyLB";
    medleaderboardID = @"com.ChiraagBangera.WordSort.MedLB";
    hardleaderboardID = @"com.ChiraagBangera.WordSort.HardLB";
    achiv1000 = @"TS1";
    beateasy = @"com.ChiraagBangera.WordSort.BeatLevelEasy";
    beatmed = @"com.ChiraagBangera.WordSort.BeatLevelMed";
    beathard = @"com.ChiraagBangera.WordSort.BeatLevelHard";
    playcustom = @"com.ChiraagBangera.WordSort.CustomChap";
    inAppPurchaseID =@"PlusPurchase";
    wordsGenerated = [[NSMutableArray alloc] init];
    keys = [[NSMutableArray alloc] init];
    stringArray = [[NSMutableArray alloc] init];
    backgroundImage = [[UIImage alloc] init];
    wordFont = [[UIFont alloc] init];
    customWordFile = [[NSString alloc] init];
    gameMode = [[NSString alloc] init];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
