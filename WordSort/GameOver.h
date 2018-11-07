//
//  GameOver.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/4/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import"AppDelegate.h"

@interface GameOver : SKScene
{
    int score;
    AppDelegate *appDelegate;
}

-(void)reportScore;



@property(nonatomic)int score;
@property(nonatomic)int wordsPlayed;
@property(nonatomic)int correctWords;

@end
