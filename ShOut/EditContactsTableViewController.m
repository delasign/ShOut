//
//  EditContactsTableViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 05/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "EditContactsTableViewController.h"

@interface EditContactsTableViewController ()

- (BOOL)isFriend:(PFUser *)user;

@end

@implementation EditContactsTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error)
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else
        {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
        
        
    }];
    
    self.currentUser = [PFUser currentUser];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    
    // Check users that are already added
    
    if ([self isFriend:user])
    {
        // add checkmark
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    if ([self isFriend:user])
    {
        // REMOVE CHECKMARK
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        // REMOVE FROM ARRAY OF FRIENDS
        
        for (PFUser *friend in self.friends) {
            
            [self.friends removeObject:friend];
            break;
            
        }
        
        // REMOVE FROM PARSE
        
        [friendsRelation removeObject:user];
    }
    
    else
    {
        // ADDS CHECKMARK
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        // ADD LOCALLY
        
        [self.friends addObject:user];
        
        // ADDS TO PARSE
        
        [friendsRelation addObject:user];
    }
    
    // SAVE TO PARSE
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
       
        if (error) {
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
        
        else {
            
        }
        
    }];
    
}

#pragma mark - Helper Methods

- (BOOL)isFriend:(PFUser *)user
{
    for (PFUser *friend in self.friends)
    {
        
        if ([friend.objectId isEqualToString:user.objectId]) {
            // found a match
            
            return YES;
        }
        
    }
    
    return NO;
}


@end
