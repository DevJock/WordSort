//
//  GameOver.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/4/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "GameOver.h"
#import "Home.h"

@implementation GameOver

@synthesize score,correctWords,wordsPlayed;



-(void)didMoveToView:(SKView *)view
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.runable = false;
    self.scene.backgroundColor = [SKColor blackColor];
    [appDelegate.wordsGenerated removeAllObjects];
    [appDelegate.keys removeAllObjects];
    [appDelegate.stringArray removeAllObjects];
    [self drawGameOver];
    if(appDelegate.gameCenterEnabled)
    {
      if([appDelegate.gameMode isEqualToString:@"Easy"] || [appDelegate.gameMode isEqualToString:@"Medium"] || [appDelegate.gameMode isEqualToString:@"Hard"])
    [self reportScore];
    }
}



-(void)drawGameOver
{
    SKLabelNode *gameOver = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameOver.text = @"Game Over!";
    gameOver.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - gameOver.frame.size.height - 75);
    gameOver.fontColor = [SKColor redColor];
    gameOver.fontSize = 64;
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %d",score];
    scoreLabel.position = CGPointMake(self.parent.position.x/2, self.parent.position.y - scoreLabel.frame.size.height - 50 );
    scoreLabel.fontColor = [SKColor whiteColor];
    scoreLabel.fontSize = 50;
    [gameOver addChild:scoreLabel];
    
    
    SKLabelNode *pWords = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pWords.text = [NSString stringWithFormat:@"Words Played: %d",wordsPlayed];
    pWords.position = CGPointMake(self.parent.position.x/2, self.parent.position.y - pWords.frame.size.height - 50);
    pWords.fontColor = [SKColor whiteColor];
    pWords.fontSize = 40;
    [scoreLabel addChild:pWords];
    
    SKLabelNode *cWords = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    cWords.text = [NSString stringWithFormat:@"Correctly Sorted Words: %d",correctWords];
    cWords.position = CGPointMake(self.parent.position.x/2, self.parent.position.y - cWords.frame.size.height - 50);
    cWords.fontColor = [SKColor whiteColor];
    cWords.fontSize = 20;
    [pWords addChild:cWords];
    
    SKLabelNode *iWords = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    iWords.text = [NSString stringWithFormat:@"Inorrectly Sorted Words: %d",wordsPlayed - correctWords];
    iWords.position = CGPointMake(self.parent.position.x/2, self.parent.position.y - iWords.frame.size.height - 25);
    iWords.fontColor = [SKColor whiteColor];
    iWords.fontSize = 20;
    [cWords addChild:iWords];
    
    SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    tryAgain.text = @"Play Again";
    tryAgain.fontColor = [SKColor whiteColor];
    tryAgain.fontSize = 28;
    
    SKSpriteNode *tryAgainBox = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(300, 100)];
    tryAgainBox.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - tryAgainBox.size.height - 75);
    tryAgain.name = @"button";
    tryAgainBox.name = @"button";
    [tryAgainBox addChild:tryAgain];
    
    
    
    [self addChild:gameOver];
    [self addChild:tryAgainBox];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if([node.name isEqualToString:@"button"])
    {
        Home *scene = [[Home alloc] initWithSize:self.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *trans = [SKTransition fadeWithDuration:2];
        [self.view presentScene:scene transition:trans];
    }
}


-(void)reportScore
{
    NSLog(@"Uploading Scores");
    GKScore *score2Rep;
    if([appDelegate.gameMode isEqualToString:@"Easy"])
    score2Rep= [[GKScore alloc] initWithLeaderboardIdentifier:appDelegate.easyleaderboardID];
    else if([appDelegate.gameMode isEqualToString:@"Medium"])
        score2Rep= [[GKScore alloc] initWithLeaderboardIdentifier:appDelegate.medleaderboardID];
    else if([appDelegate.gameMode isEqualToString:@"Hard"])
        score2Rep= [[GKScore alloc] initWithLeaderboardIdentifier:appDelegate.hardleaderboardID];
    score2Rep.value = score;
    [GKScore reportScores:@[score2Rep] withCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}




@end
