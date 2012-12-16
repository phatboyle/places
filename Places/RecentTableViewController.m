//
//  RecentTableViewController.m
//  Places
//
//  Created by Boyle, Patrick on 10/14/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "RecentTableViewController.h"
#import "ImageViewController.h"

@interface RecentTableViewController ()


@end

@implementation RecentTableViewController
@synthesize photoList;


-(void)loadRecents{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    photoList = [settings objectForKey:@"key.recentphotos"];
    NSLog(@"loadRecents photo count %d",[photoList count]);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadRecents];
    self.clearsSelectionOnViewWillAppear = NO;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self photoList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Recent Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *photo = [self.photoList objectAtIndex:indexPath.row];
    
    NSString *title = [photo valueForKey:@"title"];
    NSString *description = [photo valueForKeyPath:@"description._content"];
    
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    description = [description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (title && ![title isEqualToString:@""]){
        cell.textLabel.text=title;
        cell.detailTextLabel.text=description;
    } else if (description && ![description isEqualToString:@""]){
        cell.textLabel.text=description;
        cell.detailTextLabel.text=@"";
    } else {
        cell.textLabel.text = @"Unknown";
        cell.detailTextLabel.text=@"";
    }
    return cell;


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue description] == @"MapSegue"){
    }
    if ([segue description] == @"ShowImageSegue"){
    NSDictionary *imageDict = [self.photoList objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [[segue destinationViewController] setImage:imageDict withTitle:self.title];
    }
}


@end
