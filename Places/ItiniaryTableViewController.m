//
//  ItiniaryTableViewController.m
//  Places
//
//  Created by Pat Boyle on 12/30/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "ItiniaryTableViewController.h"
#import "Place.h"

@interface ItiniaryTableViewController ()
@property (nonatomic, strong) UIManagedDocument *vacationDatabase;
@end

@implementation ItiniaryTableViewController
@synthesize vacationDatabase = _vacationDatabase;

- (void)viewDidLoad
{
    [super viewDidLoad];

}
-(void) setVacationDatabase:(UIManagedDocument *)vacationDatabase
{
    if (_vacationDatabase!=vacationDatabase){
        _vacationDatabase=vacationDatabase;
    }
    [self setupFetchedResultsController];
    
}

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want tall places
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.vacationDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSLog(@"%@", [[self.fetchedResultsController fetchedObjects] description]);

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Places cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Place *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = place.name;
    NSLog(@"%@", place.name);
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
