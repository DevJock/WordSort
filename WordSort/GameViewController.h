//
//  GameViewController.h
//  SpellCheck
//

//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>

@interface GameViewController : UIViewController<GKGameCenterControllerDelegate,ADBannerViewDelegate>
{
    AppDelegate *appDelegate;
}

@property(nonatomic,strong)ADBannerView *banner;

@end
