//
//  WordGenerator.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/3/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "WordGenerator.h"

@implementation WordGenerator
{
    NSTimer *timer;
    NSMutableArray *localStorage,*randomStorage;
    int iHelper;
    int cHelper;
    int max;
    int upperBounds;
}

@synthesize wordsInArray;





-(void)loadDataWithSource:(NSString *)sourceFile
{
    max = 5000;
    NSString* content;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.numberofwordsgenerated = 0;
    gl = [[GameLib alloc] init];
     [appDelegate.stringArray removeAllObjects];
    if([sourceFile isEqualToString:appDelegate.customWordFile])
    {
        NSString* path =  [gl pathToFile:sourceFile];
        content = [NSString stringWithContentsOfFile:path
                                            encoding:NSUTF8StringEncoding
                                               error:NULL];
    }
    else
    {
    NSString* path = [[NSBundle mainBundle] pathForResource:sourceFile
                                                     ofType:@"txt"];
     content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    }
    appDelegate.stringArray = [[content componentsSeparatedByString: @"\n"] mutableCopy];
    localStorage = [NSMutableArray arrayWithArray:appDelegate.stringArray];
    wordsInArray = (int)[localStorage count];
    appDelegate.runable = true;
    NSLog(@"Using %@ as Source",sourceFile);
    upperBounds = wordsInArray < max ? wordsInArray : max ;
   timer = [NSTimer scheduledTimerWithTimeInterval:00.1 target:self selector:@selector(generateWords) userInfo:nil repeats:YES];
}


-(NSString *)wordDestructor:(NSString *)word
{
    NSString *theWord = [[NSString alloc] init];
    int destructorPasses = arc4random() % 3;
    for(int i =0;i<destructorPasses;i++)
    {
        int randomPos = arc4random() % (int)[word length];
        NSString  *ch = [NSString stringWithFormat:@"%c",[word characterAtIndex:randomPos]];
        theWord = [word stringByReplacingOccurrencesOfString:ch withString:@""];
    }
    return theWord;
}





-(NSString *)newInCorrectWord
{
    NSString *t = [[NSString alloc] init];
     NSString *tt = [[NSString alloc] init];
    int randomIndex;
    do
    {
    randomIndex = arc4random() % (int)[localStorage count];
    t = [localStorage objectAtIndex:randomIndex];
    tt = [self wordDestructor:t];
    }while((( tt == NULL ||  [tt length] < 2 || [self wordCheck:tt]  )&& [t length] > 2));
   [localStorage removeObjectAtIndex:randomIndex];
return tt;
}



-(NSString *)newCorrectWord
{
    NSString *t ;
    int randomIndex = arc4random() % (int)[localStorage count];
    t = [localStorage objectAtIndex:randomIndex];
    [localStorage removeObjectAtIndex:randomIndex];
    return t;
}




-(BOOL)wordCheck:(NSString *)word
{
    UITextChecker *Checker = [[UITextChecker alloc] init];
    NSRange range = [Checker rangeOfMisspelledWordInString:[word lowercaseString]
                                                     range:NSMakeRange(0, [word length])
                                                startingAt:0 wrap:NO
                                                  language:@"en_US"];
    
    if ( range.location == NSNotFound )
    {
        return true;
    }
    else
    {
        return false;
    }
}




-(void)generateWords
{
    if(appDelegate.numberofwordsgenerated <1)
     NSLog(@"Generating Words....");
    
    if(appDelegate.numberofwordsgenerated < upperBounds)
    {
    if(appDelegate.runable)
    {
    int genRand =  arc4random() % 2;
    if(genRand == 1)
    {
        [appDelegate.wordsGenerated addObject:[self newCorrectWord]];
        [appDelegate.keys addObject:@"correctWord"];
    }
    else if(genRand == 0)
    {
        [appDelegate.wordsGenerated addObject:[self newInCorrectWord]];
       [appDelegate.keys addObject:@"incorrectWord"];
    }
    //NSLog(@"%@",appDelegate.wordsGenerated);
    appDelegate.numberofwordsgenerated++;
    }
    }
    else
    {
        [timer invalidate];
        appDelegate.runable  =false;
    }
}

-(void)preLoad
{
    NSString *temp;
    randomStorage = [[NSMutableArray alloc] init];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"random"
                                                     ofType:@"txt"];
    temp = [NSString stringWithContentsOfFile:path
                                        encoding:NSUTF8StringEncoding
                                           error:NULL];
    randomStorage= [[temp componentsSeparatedByString: @"\n"] mutableCopy];
}

-(NSString *)newRandomWord
{
    NSString *word;
    int randomIndex = arc4random() % (int)[randomStorage count];
    word= [randomStorage objectAtIndex:randomIndex];
    return word;
}


@end


