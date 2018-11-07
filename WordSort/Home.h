//
//  Home.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/4/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "WordGenerator.h"
#import "GameLib.h"
#import "GameScene.h"
#import "AppDelegate.h"


@interface Home : SKScene
{
    WordGenerator *words;
    AppDelegate *appDelegate;
    GameLib *gl ;
}




@end
