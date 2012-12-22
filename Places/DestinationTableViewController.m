//
//  DestinationTableViewController.m
//  Places
//
//  Created by Boyle, Patrick on 10/13/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "DestinationTableViewController.h"
#import "ImageViewController.h"

@interface DestinationTableViewController ()

@end

@implementation DestinationTableViewController

@synthesize photos = _photos;


- (void)viewDidLoad
{
    [super viewDidLoad];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger x =[[self photos] count];
    NSLog(@"number of rows %d", x);
    return x;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Descriptions";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *photosInPlace = [self.photos objectAtIndex:indexPath.row];
    
    NSString *title = [photosInPlace valueForKey:@"title"];
    NSString *description = [photosInPlace valueForKeyPath:@"description._content"];
    
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

- (void)setPhotoList: (NSArray *)photoList withTitle:(NSString *)title{
    self.photos=photoList;
    NSInteger x =[self.photos count];
    NSLog(@"number of rows %d", x);
    
    self.title=title;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowImageSegue"]){
    NSDictionary *imageDictionary = [self.photos objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [[segue destinationViewController ] setImage:imageDictionary withTitle:self.title];
    }
}



@end
