//
//  WordGenerator.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/3/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "GameLib.h"

@interface WordGenerator : NSObject
{
    AppDelegate *appDelegate;
    GameLib *gl;
}

@property(nonatomic)int wordsInArray;
-(void)loadDataWithSource:(NSString *)sourceFile;
-(NSString *)newCorrectWord;
-(NSString *)newInCorrectWord;
-(void)generateWords;
-(NSString *)newRandomWord;
-(void)preLoad;

@end
