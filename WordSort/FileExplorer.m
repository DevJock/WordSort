//
//  FileExplorer.m
//  WordSort
//
//  Created by Chiraag Bangera on 10/12/14.
//  Copyright (c) 2014 Chiraag Bangera. All rights reserved.
//

#import "FileExplorer.h"

@interface FileExplorer ()
{
    NSMutableArray *files;
    int ind;
}

@end

@implementation FileExplorer


- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    gl = [[GameLib alloc] init];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFileManager *manager = [NSFileManager defaultManager];
    files = [[manager contentsOfDirectoryAtPath:[gl documentsPath] error:nil] mutableCopy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i=0;i<[files count];i++)
        {
            NSArray *t = [[files objectAtIndex:i] componentsSeparatedByString:@"."];
            if(![[t objectAtIndex:([t count] -1)] isEqualToString:@"txt"])
            {
                [files removeObjectAtIndex:i];
            }
            
            if([[files objectAtIndex:i] isEqualToString:appDelegate.customWordFile])
            {
                ind = i;
            }
     
        }
    });

  
    // Uncomment the following line to preserve selection between presentations.
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
     self.clearsSelectionOnViewWillAppear = NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
}


-(IBAction)leftItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Text Files Found";
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [files count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *fileName = [files objectAtIndex:indexPath.row];
    cell.textLabel.text = fileName;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:20];
    if((int)indexPath.row == ind)
    {
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *selectedFile = [files objectAtIndex:indexPath.row];
    appDelegate.customWordFile = selectedFile;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:selectedFile forKey:@"UserCustomFile"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
