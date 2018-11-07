//
//  GameLib.h
//  WordSort
//
//  Created by Chiraag Bangera on 10/6/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface GameLib : NSObject
{
    AppDelegate *appDelegate;
}

-(BOOL)fileCheck:(NSString *)fileName;
- (void)writeStringToFile:(NSString*)aString and:(NSString *)fileName;
- (NSString*)readStringFromFile:(NSString *)fileName;
-(NSArray *)listFileAtPath:(NSString *)path;
-(NSString *)sizeOfFolder:(NSString *)folderPath;
- (bool)deleteFile:(NSString *)fileName;
-(void)deleteFilesOfType:(NSString *)extension;
-(NSString *)documentsPath;
-(NSString *)pathToFile:(NSString *)fileName;
-(NSMutableDictionary *)mergeDictionaries:(NSMutableDictionary *)lhs and:(NSMutableDictionary *)rhs;


@end
