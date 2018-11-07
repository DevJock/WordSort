//
//  AppDelegate.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/3/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)NSString* gameMode;
@property(nonatomic,strong)NSString* appUnlocked;
@property (strong,nonatomic)   NSTimer *wordTimer;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) NSString* leaderboardID;
@property(nonatomic,strong) NSString* easyleaderboardID;
@property(nonatomic,strong) NSString* medleaderboardID;
@property(nonatomic,strong) NSString* hardleaderboardID;
@property(nonatomic,strong) NSString* achiv1000;
@property(nonatomic,strong) NSString* beateasy;
@property(nonatomic,strong) NSString* beatmed;
@property(nonatomic,strong)NSString* beathard;
@property(nonatomic)bool simple,easy,medium,hard,custom;
@property(nonatomic,strong) NSString* playcustom;
@property(nonatomic,strong) NSString* inAppPurchaseID;
@property(nonatomic) bool gameCenterEnabled;
@property (strong,nonatomic) NSMutableArray *wordsGenerated;
@property (strong,nonatomic) NSMutableArray *keys;
@property(nonatomic,strong)NSMutableArray *stringArray;
@property(nonatomic)int numberofwordsgenerated;
@property(nonatomic) bool runable;


//PRO Features

@property(nonatomic,strong)UIImage *backgroundImage;
@property(nonatomic,strong)UIFont *wordFont;
@property(nonatomic,strong)NSString* customWordFile;
@end

