//
//  MyVacationsTableViewController.m
//  Places
//
//  Created by Pat Boyle on 12/24/12.
//  Copyright (c) 2012 Pat Boyle. All rights reserved.
//

#import "MyVacationsTableViewController.h"
#import "FlickrFetcher.h"
#import "Photo+Flickr.h"

@interface MyVacationsTableViewController ()
@property (nonatomic, strong) UIManagedDocument *vacationDatabase;
@property (nonatomic, strong) NSArray *vacationDbList;
@end

@implementation MyVacationsTableViewController
@synthesize vacationDatabase = _vacationDatabase;
@synthesize vacationDbList = _vacationDbList;

// get a list of the vacation files that are in the directory (let's simplify by having only one at this point)
// display it
// when you pick it, segue to VacationDetailViewController


-(void) createBasicVacation:(UIManagedDocument *) document
{   // creates a basic vacation with the first 5 photos in the list. (should change this to a specific place)
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchQ, ^(void){
        NSArray* photos = [FlickrFetcher photosInPlace:<#(NSDictionary *)#> maxResults:50];
        [document.managedObjectContext performBlock:^{
            int i=0;
            for (NSDictionary *flickrInfo in photos) {
                NSLog(@"flickrFetched %@", flickrInfo);
                [Photo photoWithFlickrInfo:flickrInfo inManagedObjectContext:document.managedObjectContext];
                i++;
                if (i>5) break;
            }
            [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
            NSLog(@"managed context %@", document.managedObjectContext);
        }];
    });
    dispatch_release(fetchQ);
    NSLog(@"exiting MyVacationsTableViewController: createBasicVacation");
}



-(void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.vacationDatabase.fileURL path]]){
        [self.vacationDatabase saveToURL:self.vacationDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self createBasicVacation:[self vacationDatabase]];
        }];
        
    } else if (self.vacationDatabase.documentState == UIDocumentStateClosed){
        [self.vacationDatabase openWithCompletionHandler:^(BOOL success){
        }];
        [self createBasicVacation:[self vacationDatabase]];
        NSLog(@"useDocument: opened database");
        
        
    } else if (self.vacationDatabase.documentState == UIDocumentStateNormal){
        NSLog(@"useDocument: db state normal");
    }
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"vacation segue"]){
        [[segue destinationViewController] setVacationDatabase:[self vacationDatabase]];
    }
    
}

- (void)setVacationDatabase:(UIManagedDocument *)vacationDatabase
{
    if (_vacationDatabase!=vacationDatabase){
        _vacationDatabase=vacationDatabase;
        [self useDocument]; // get the document open and working
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad in MyVacationsTableViewController");
    

}

- (void)viewWillAppear:(BOOL)animated
{
    // let's simplify by just grabbing the one db that is on the disk
    if (!_vacationDatabase){
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"myVacationDatabase"];
        self.vacationDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
        self.vacationDbList = [NSArray arrayWithObject:self.vacationDatabase];
        
        NSLog(@"viewWillAppear in MyVacationsTableViewController");
    }
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.vacationDbList count];
    
    NSLog(@"numberOfRowsInSection in MyVacationsTableViewController");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellForRowAtIndexPath in MyVacationsTableViewController");
    static NSString *CellIdentifier = @"Vacation Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.vacationDbList objectAtIndex:indexPath.row] localizedName];
//    cell.textLabel.text = [testArray objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
