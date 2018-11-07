//
//  GameScene.h
//  WordSort
//

//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WordGenerator.h"
#import "GameLib.h"
#import "AppDelegate.h"

@interface GameScene : SKScene<SKPhysicsContactDelegate>
{
    AppDelegate *appDelegate;
    WordGenerator *words;
    GameLib *gl;
}





-(void)playGame;
@property(nonatomic)  int wordcount;
@property(nonatomic,weak)   SKNode *nodeTouched;

@end
