//
//  GameScene.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/3/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "GameScene.h"
#import "GameOver.h"


@implementation GameScene
{
    int continuity ;
    int score;
    int lives ;
    int correctW;
    SKLabelNode *scoreLabel;
    SKLabelNode *lifeLabel;
    bool gameOver;
}

@synthesize wordcount,nodeTouched;

static const uint32_t worldCollisionMask = 0x1 << 0;
static const uint32_t othersCollisionMask = 0x1 << 1;
static const uint32_t wordsCollisionMask = 0x1 << 2;
static const uint32_t correctCollisionMask = 0x1 << 3;
static const uint32_t incorrectCollisionMask = 0x1 << 4;
static const uint32_t destroyerCollisionMask = 0x1 << 5;





-(void)didMoveToView:(SKView *)view
{
    /* Setup your scene here */
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    words = [[WordGenerator alloc] init];
    gl = [[GameLib alloc] init];
    self.view.multipleTouchEnabled = YES;
    NSLog(@"Game Loaded With %d Words",(int)[appDelegate.stringArray count] );
    wordcount = 0;
    correctW = 0;
    if([appDelegate.appUnlocked isEqualToString:@"Unlocked"] && appDelegate.backgroundImage != nil)
    {
        self.backgroundColor = [SKColor colorWithPatternImage:appDelegate.backgroundImage];
    }
    else
    {
    self.backgroundColor = [SKColor blackColor];
    }
    score = 0;
    gameOver = false;
    continuity = 0;
    lives = 3;
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = @"Score:";
    lifeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lifeLabel.text = @"Lives:";
    self.physicsWorld.gravity = CGVectorMake( 0.0, -0.3 );
    self.physicsWorld.contactDelegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:UIApplicationDidEnterBackgroundNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resume) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    if([appDelegate.gameMode isEqualToString:@"Custom"] && !appDelegate.custom)
    {
        NSLog(@"Achivement Unlocked");
        GKAchievement *achievement =
        [[GKAchievement alloc] initWithIdentifier: appDelegate.playcustom];
        achievement.showsCompletionBanner = YES;
        achievement.percentComplete = 100;
        NSArray *achievements = [NSArray arrayWithObjects:achievement, nil];
        [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
            if (error != nil)
            {
                NSLog(@"Error in reporting achievements: %@", error);
            }
        }];
    }
    
   // [self buildLevel];
    [self addChild:scoreLabel];
    [self addChild:lifeLabel];
    [self playGame];
   appDelegate.wordTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(playGame) userInfo:nil repeats:YES];
}


-(void)pause
{
    NSLog(@"Pause Game");
    [appDelegate.wordTimer invalidate];
    appDelegate.wordTimer = nil;
}

-(void)resume
{
    if(appDelegate.wordTimer == nil)
    {
        NSLog(@"Resuming Game");
        appDelegate.wordTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(playGame) userInfo:nil repeats:YES];
    }
}



-(void)playGame
{
    if(wordcount < appDelegate.numberofwordsgenerated)
    [self addChild:[self newWord]];
    else
    {

        if([appDelegate.gameMode isEqualToString:@"Easy"] && !appDelegate.easy)
        {
            NSLog(@"Achivement Unlocked Beaten Easy ");
            GKAchievement *achievement =
            [[GKAchievement alloc] initWithIdentifier: appDelegate.beateasy];
            achievement.showsCompletionBanner = YES;
            achievement.percentComplete = 100;
            NSArray *achievements = [NSArray arrayWithObjects:achievement, nil];
            [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
                if (error != nil)
                {
                    NSLog(@"Error in reporting achievements: %@", error);
                }
            }];
        }
        else if([appDelegate.gameMode isEqualToString:@"Medium"] && !appDelegate.medium)
        {
            NSLog(@"Achivement Unlocked Beaten Medium ");
            GKAchievement *achievement =
            [[GKAchievement alloc] initWithIdentifier: appDelegate.beatmed];
            achievement.showsCompletionBanner = YES;
            achievement.percentComplete = 100;
            NSArray *achievements = [NSArray arrayWithObjects:achievement, nil];
            [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
                if (error != nil)
                {
                    NSLog(@"Error in reporting achievements: %@", error);
                }
            }];
        }
        else if([appDelegate.gameMode isEqualToString:@"Hard"] && !appDelegate.hard)
        {
            NSLog(@"Achivement Unlocked Beaten Hard ");
            GKAchievement *achievement =
            [[GKAchievement alloc] initWithIdentifier: appDelegate.beathard];
            achievement.showsCompletionBanner = YES;
            achievement.percentComplete = 100;
            NSArray *achievements = [NSArray arrayWithObjects:achievement, nil];
            [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
                if (error != nil)
                {
                    NSLog(@"Error in reporting achievements: %@", error);
                }
            }];
        }

        
    
 
        [appDelegate.wordTimer invalidate];
        score += appDelegate.numberofwordsgenerated;
        lives = 0;
    }
}






-(void)flashScreen:(int)code
{
    if(code == 1)
    {
        continuity = 0;
        lives -= 1;
        [self removeActionForKey:@"flashR"];
        [self runAction:[SKAction sequence:@[[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            self.backgroundColor = [SKColor redColor];
        }], [SKAction waitForDuration:0.25], [SKAction runBlock:^{
            self.backgroundColor = [SKColor blackColor];
        }], [SKAction waitForDuration:0.25]]] count:1]]] withKey:@"flashR"];
    }
    
    if(code == 2)
    {
        continuity += 1;
        [self removeActionForKey:@"flashG"];
        [self runAction:[SKAction sequence:@[[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            self.backgroundColor = [SKColor greenColor];
        }], [SKAction waitForDuration:0.25], [SKAction runBlock:^{
            self.backgroundColor = [SKColor blackColor];
        }], [SKAction waitForDuration:0.25]]] count:1]]] withKey:@"flashG"];
    }
    
    if(code == 3)
    {
        continuity = 0;
        lives -= 1;
        [self removeActionForKey:@"flashW"];
        [self runAction:[SKAction sequence:@[[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            self.backgroundColor = [SKColor whiteColor];
        }], [SKAction waitForDuration:0.25], [SKAction runBlock:^{
            self.backgroundColor = [SKColor blackColor];
        }], [SKAction waitForDuration:0.25]]] count:1]]] withKey:@"flashW"];
    }


}


-(void)didBeginContact:(SKPhysicsContact *)contact
{
    if([contact.bodyA.node.name isEqualToString:@"destroyerBox"])
    {
        if(score >= 10)
        score -= 10;
        [self flashScreen:3];
        SKSpriteNode *firstNode = (SKSpriteNode *) contact.bodyB.node;
        [firstNode removeFromParent];
        
    }
    
    else if([contact.bodyA.node.name isEqualToString:@"correctBox"])
    {
        if([contact.bodyB.node.name isEqualToString:@"correctWord"])
        {
            score += 20;
            correctW+=1;
            [self flashScreen:2];
        }
        else
        {
            if(score >= 20)
            score -= 20;
             [self flashScreen:1];
        }
        SKSpriteNode *firstNode = (SKSpriteNode *) contact.bodyB.node;
        [firstNode removeFromParent];
    }
    
    else if([contact.bodyA.node.name isEqualToString:@"incorrectBox"])
    {
        if([contact.bodyB.node.name isEqualToString:@"incorrectWord"])
        {
            score += 20;
            correctW+=1;
             [self flashScreen:2];
        }
        else
        {
            if(score >= 20)
            score -= 20;
             [self flashScreen:1];
        }
        SKSpriteNode *firstNode = (SKSpriteNode *) contact.bodyB.node;
        [firstNode removeFromParent];
    }
}


-(void)buildLevel
{
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody = borderBody;
    self.physicsBody.friction = 0.0f;
    self.physicsBody.collisionBitMask = worldCollisionMask;
    self.name = @"worldBox";
    
    SKLabelNode *arrows = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    arrows.text = @"<----- || ----->";
    arrows.position = CGPointMake(self.parent.position.x/2, self.parent.position.y/2 - 50);
    arrows.alpha = 0.5;
    
    SKLabelNode *helpLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helpLabel.text = @"Drag and Drop words";
    helpLabel.fontSize = 19;
    helpLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 50);
    helpLabel.fontColor = [SKColor grayColor];
    helpLabel.alpha = 0.7;
    [helpLabel addChild:arrows];
    
    SKLabelNode *destroyerText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    destroyerText.text = @"Word Shredder";
    destroyerText.fontSize = 25;
    destroyerText.fontColor = [SKColor yellowColor];
    
    SKSpriteNode *destroyer = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(self.frame.size.width, 50)];
    destroyer.position = CGPointMake(self.frame.size.width/2,destroyer.size.height/2);
    destroyer.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:destroyer.size];
    destroyer.physicsBody.dynamic = NO;
    destroyer.physicsBody.collisionBitMask = destroyerCollisionMask;
    destroyer.name = @"destroyerBox";
    [destroyer addChild:destroyerText];
    
    SKLabelNode *correct = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    correct.text = @"C";
    correct.fontSize = 30;
   correct.fontColor = [SKColor blackColor];
    
   SKLabelNode *incorrect = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    incorrect.text = @"I";
    incorrect.fontSize = 20;
   incorrect.fontColor = [SKColor blackColor];
    
    SKSpriteNode *baseRed ;
    baseRed = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"cross"]]];
    baseRed.size = CGSizeMake(50, 50);
    NSLog(@"%lf",baseRed.size.width);
    baseRed.position = CGPointMake(self.frame.size.width - baseRed.size.width - 300 , destroyer.size.height + baseRed.size.height );
    baseRed.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:baseRed.size];
    baseRed.physicsBody.affectedByGravity = NO;
    baseRed.physicsBody.dynamic = NO;
    baseRed.physicsBody.collisionBitMask = incorrectCollisionMask;
    baseRed.name = @"incorrectBox";
   // [baseRed addChild:incorrect];
    
    SKSpriteNode *baseGreen ;
    baseGreen = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"tick"]]];
    baseGreen.size = CGSizeMake(50, 50);
    baseGreen.position = CGPointMake(0 + baseRed.size.width + 300 , destroyer.size.height + baseRed.size.height );
    baseGreen.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:baseGreen.size];
    baseGreen.physicsBody.affectedByGravity = NO;
    baseGreen.physicsBody.dynamic = NO;
    baseGreen.physicsBody.collisionBitMask = correctCollisionMask;
    baseGreen.name = @"correctBox";
   // [baseGreen addChild:correct];
    
    [self addChild:helpLabel];
    [self addChild:destroyer];
    [self addChild:baseRed];
    [self addChild:baseGreen];
}



-(SKLabelNode *)newWord
{
    SKLabelNode *word;
    word= [ SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    word.text = [appDelegate.wordsGenerated objectAtIndex:wordcount];
    word.name = [appDelegate.keys objectAtIndex:wordcount];
    word.position = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height/2 + 200);
    wordcount++;
    word.fontSize = 32;
    word.speed = 0.5;
    word.fontColor = [SKColor whiteColor];
    word.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(word.frame.size.width + 50,word.frame.size.height + 75)];
    word.physicsBody.affectedByGravity = YES;
    word.physicsBody.dynamic = YES;
    word.physicsBody.allowsRotation = NO;
    word.physicsBody.friction = 0.0f;
    word.physicsBody.linearDamping = 0.0f;
    word.physicsBody.mass = 1;
    word.physicsBody.restitution = 1.0f;
    word.physicsBody.collisionBitMask = 0;
    word.physicsBody.contactTestBitMask = correctCollisionMask | incorrectCollisionMask | destroyerCollisionMask | ~othersCollisionMask | ~worldCollisionMask | ~wordsCollisionMask ;
    return word;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    for(UITouch *touch in touches)
        {
            CGPoint location = [touch locationInNode:self];
            SKNode *node = [self nodeAtPoint:location];
            if ([node.name isEqualToString:@"correctWord"] || [node.name isEqualToString:@"incorrectWord"])
            {
                //NSLog(@"Touched: %@",node);
                self.nodeTouched = node;
                self.nodeTouched.physicsBody.affectedByGravity = NO;
                self.nodeTouched.physicsBody.dynamic = NO;
            }
            
        }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    for(UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        self.nodeTouched.position = location;
    }

}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.nodeTouched.physicsBody.affectedByGravity = YES;
    self.nodeTouched.physicsBody.dynamic = YES;
    [self.nodeTouched.physicsBody applyImpulse:CGVectorMake(0, -200)];
    self.nodeTouched = nil;
    self.nodeTouched.position = CGPointZero;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.nodeTouched.physicsBody.affectedByGravity = YES;
    self.nodeTouched.physicsBody.dynamic = YES;
    [self.nodeTouched.physicsBody applyImpulse:CGVectorMake(0, -200)];
    self.nodeTouched = nil;
    self.nodeTouched.position = CGPointZero;
}

-(void)update:(NSTimeInterval)currentTime
{
    if(continuity >= 5)
    {
        lives += 1;
        continuity = 0;
    }
    if(lives <= 0)
    {
        lives = 3;
        gameOver = true;
        [appDelegate.wordTimer invalidate];
        NSLog(@"GameOver!");
        GameOver *scene = [[GameOver alloc] initWithSize:self.size];
        scene.wordsPlayed = wordcount +1 ;
        scene.correctWords = correctW;
        scene.score = score;
        scene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *close = [SKTransition doorsCloseHorizontalWithDuration:2];
        [self.view presentScene:scene transition:close];
    }
    
    
    
    if(score >= 1000 && !appDelegate.simple)
    {
       // NSLog(@"Achivement status: %d",appDelegate.simple);
         appDelegate.simple = true;
        GKAchievement *achievement =
        [[GKAchievement alloc] initWithIdentifier: appDelegate.achiv1000];
        achievement.showsCompletionBanner = YES;
        achievement.percentComplete = 100;
        NSArray *achievements = [NSArray arrayWithObjects:achievement, nil];
        [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
            if (error != nil)
            {
                NSLog(@"Error in reporting achievements: %@", error);
            }
        }];
    }
   lifeLabel.text = [ NSString stringWithFormat:@"Lives: %d",lives];
   lifeLabel.fontSize = 32;
   lifeLabel.position = CGPointMake(CGRectGetMidX(self.frame) + 100,CGRectGetMidY(self.frame) + 300);
   scoreLabel.text = [ NSString stringWithFormat:@"Score: %d",score];
   scoreLabel.fontSize = 32;
   scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) - 100,CGRectGetMidY(self.frame) + 300);
}





@end

