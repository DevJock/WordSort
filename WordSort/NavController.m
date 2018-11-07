//
//  NavController.m
//  WordSort
//
//  Created by Chiraag Bangera on 11/25/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // set the delegate to self
    [self.navigationController.navigationBar setDelegate:self];
  
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
