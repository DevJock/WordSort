//
//  Home.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/4/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "Home.h"
#import "WordGenerator.h"

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

@implementation Home
{
    int option;
    SKLabelNode *label;
    bool gameModeSelected;
    NSTimer *backgroundTimer;
    WordGenerator *wg;
}

-(void)didMoveToView:(SKView *)view
{
    gameModeSelected = false;
    wg = [[WordGenerator alloc] init];
    [wg preLoad];
    backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addBackgroundWord) userInfo:nil repeats:YES];
    SKLabelNode *GameLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    GameLabel.text = @"Word Sort";
    GameLabel.fontSize = 64;
    GameLabel.fontColor = [SKColor whiteColor];
    GameLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - (label.frame.size.height + 90));
    [self addChild:GameLabel];
    self.scene.backgroundColor = [SKColor blackColor];
    words = [[WordGenerator alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    gl = [[GameLib alloc] init];
    [self drawUI];
}


-(void)moveToGame
{
    SKScene *scene = [GameScene unarchiveFromFile:@"Game"];
 //   GameScene *scene = [[GameScene alloc] initWithSize:self.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKTransition *levelLoad = [SKTransition doorsOpenHorizontalWithDuration:2];
    [self.view presentScene:scene transition:levelLoad];
    if([backgroundTimer isValid])
    [backgroundTimer invalidate];
}



-(void)loadGame
{
    if(option == 1)
    {
        [words loadDataWithSource:@"easyWords"];
    }
    else if(option == 2)
    {
        [words loadDataWithSource:@"words"];
    }
    else if(option == 3)
    {
        [words loadDataWithSource:@"hardWords"];
    }
    else if(option == 4)
    {
         [words loadDataWithSource:appDelegate.customWordFile];
    }
    label.text = @"Loading ....";
    gameModeSelected = true;
    [self performSelector:@selector(moveToGame) withObject:nil afterDelay:2];
}


-(void)drawUI
{
    label =  [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 150);
    label.text = @"Select Difficulty to Start";
    label.fontSize = 29;
    label.color = [SKColor blackColor];
    
    CGSize squareSize =  CGSizeMake(100, 100);
    float spacing = 25;
    
    
    SKSpriteNode *extras = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:squareSize];
    extras.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2 - (100) );
    extras.name = @"extras";
    SKLabelNode *extrasText =  [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    extrasText.text = @"Extras";
    extrasText.name = @"extras";
    extrasText.fontSize = 20;
    extrasText.fontColor = [SKColor blackColor];
    [extras addChild:extrasText];
    
    
    
    
    
    
    
    SKSpriteNode *startButtonEasy = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:squareSize];
    startButtonEasy.position = CGPointMake( -extras.size.width - spacing , self.parent.position.y /2 );
    startButtonEasy.name = @"startEasy";
    SKLabelNode *easyText =  [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    easyText.text = @"Easy";
    easyText.name = @"startEasy";
    easyText.fontSize = 18;
    easyText.fontColor = [SKColor blackColor];
    [startButtonEasy addChild:easyText];
    [extras addChild:startButtonEasy];
    
    
    
    SKSpriteNode *startButtonMedium = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:squareSize];
    startButtonMedium.position = CGPointMake( self.parent.position.x/2 , extras.size.height + spacing );
    startButtonMedium.name = @"startMedium";
    SKLabelNode *mediumText =  [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    mediumText.text = @"Medium";
    mediumText.name = @"startMedium";
    mediumText.fontSize = 18;
    mediumText.fontColor = [SKColor blackColor];
    [startButtonMedium addChild:mediumText];
    [extras addChild:startButtonMedium];
    

    SKSpriteNode *startButtonHard = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:squareSize];
    startButtonHard.position = CGPointMake( extras.size.width + spacing , self.parent.position.y /2 );
    startButtonHard.name = @"startHard";
    SKLabelNode *hardText =  [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    hardText.text = @"Hard";
    hardText.name = @"startHard";
    hardText.fontSize = 18;
    hardText.fontColor = [SKColor blackColor];
    [startButtonHard addChild:hardText];
    [extras addChild:startButtonHard];
    
    
    SKSpriteNode *startButtonCustom = [SKSpriteNode spriteNodeWithColor:[SKColor  orangeColor] size:squareSize];
    startButtonCustom.position = CGPointMake( self.parent.position.x/2 , -extras.size.height - spacing );
    startButtonCustom.name = @"startCustom";
    SKLabelNode *customText =  [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    customText.text = @"Custom";
    customText.name = @"startCustom";
    customText.fontSize = 18;
    customText.fontColor = [SKColor blackColor];
    [startButtonCustom addChild:customText];
    [extras addChild:startButtonCustom];
    
    
    SKSpriteNode *backDrop = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:self.frame.size];
    backDrop.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    backDrop.alpha = 0.5;
   
    backDrop.zPosition = -20;
    
    [self addChild:label];
    [self addChild:extras];
    [self addChild:backDrop];

}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!gameModeSelected)
    {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"extras"])
    {
        UIViewController *vc = self.view.window.rootViewController;
        [vc performSegueWithIdentifier:@"showExtras" sender:self];
    }
    
    if([node.name isEqualToString:@"startEasy"])
    {
      appDelegate.gameMode = @"Easy";
        option = 1;
        [self loadGame];
    }
    
   else if([node.name isEqualToString:@"startMedium"])
    {
        appDelegate.gameMode = @"Medium";
        option = 2;
        [self loadGame];
    }
    else if([node.name isEqualToString:@"startHard"])
    {
        if(appDelegate.appUnlocked)
        {
            option = 3;
          appDelegate.gameMode = @"Hard";
            [self loadGame];
        }
        else
        {
        option = -1;
        label.text = @"Not Available";
        }
    }
    else if([node.name isEqualToString:@"startCustom"])
    {
        if(appDelegate.appUnlocked)
        {
            option = 4;
            if(appDelegate.customWordFile == NULL || [appDelegate.customWordFile length] == 0)
            {
                NSLog(@"Error ... file not selected");
                label.text = @"Word File not Selected";
            }
            else
            {
         appDelegate.gameMode = @"Custom";
           [self loadGame];
            }
        }
        else
        {
            option = -1;
            label.text = @"Not Available";
        }
    }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!gameModeSelected)
    label.text = @"Select Difficulty to Start";
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!gameModeSelected)
    label.text = @"Select Difficulty to Start";
}



-(void)addBackgroundWord
{
    SKLabelNode *word ;
    word= [ SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    word.position = [self randomPosition];
    word.fontSize = 30;
    word.text = [wg newRandomWord];
    word.zPosition = - 100;
    word.color = [SKColor colorWithWhite:0.1 alpha:0.1];
    SKAction *moveDown = [SKAction moveToY:-50 duration:[self randomTime]];
    SKAction *fade = [SKAction fadeAlphaTo:[self randomFade] duration:[self randomTime]];
    SKAction *destroy = [SKAction removeFromParent];
    SKAction *block = [SKAction sequence:@[moveDown,fade,destroy]];
    [word runAction:block];
    [self addChild:word];
}

-(float)randomFade
{
    return (((float)rand() / RAND_MAX) * (1)) ;

}

-(float)randomTime
{
    return (((float)rand() / RAND_MAX) * (6) + 3) ;
}

-(CGPoint)randomPosition
{
    float x =  (((float)rand() / RAND_MAX) * (self.frame.size.width - 120)) + 120;
    float y =  (((float)rand() / RAND_MAX) * (self.frame.size.height)) + self.frame.size.height/2;
    return CGPointMake(x, y);
}



@end
