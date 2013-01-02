//
//  VacationTableViewController.m
//  Places
//
//  Created by Pat Boyle on 12/24/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "VacationDetailViewController.h"
#import "ItiniaryTableViewController.h"

@interface VacationDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *itiniary;
@property (weak, nonatomic) IBOutlet UITableViewCell *vacationTags;
@property (nonatomic, strong) UIManagedDocument* vacationDatabase;

@end

@implementation VacationDetailViewController
@synthesize vacationDatabase = _vacationDatabase;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog((@"loaded my vacation"));
    self.itiniary.textLabel.text = @"Itiniary";
    self.vacationTags.textLabel.text = @"Search Tags";
    
 
}
-(void) setVacationDatabase:(UIManagedDocument *)vacationDatabase
{
    if (_vacationDatabase!=vacationDatabase){
        _vacationDatabase = vacationDatabase;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"itiniary segue"]){
        [[segue destinationViewController] setVacationDatabase:[self vacationDatabase]];
    }
    
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

- (void)viewDidUnload {
    [self setItiniary:nil];
    [self setVacationTags:nil];
    [super viewDidUnload];
}
@end
