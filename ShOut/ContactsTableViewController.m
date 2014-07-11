//
//  ContactsTableViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 05/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "ContactsTableViewController.h"

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error)
        {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        else
        {
            self.friends = objects;
            [self.tableView reloadData];
        }
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEditFriends"])
    {
        
        EditContactsTableViewController *destinationViewController = (EditContactsTableViewController *)segue.destinationViewController;
        
        // Make Edit Contacts friends == to friends array
        
        destinationViewController.friends = [NSMutableArray arrayWithArray:self.friends];
        
    }
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
    return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFUser *user = self.friends[indexPath.row];
    
    cell.textLabel.text = user.username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
