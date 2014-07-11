//
//  EditContactsTableViewController.h
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 05/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ContactsTableViewController.h"


@interface EditContactsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *allUsers;
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) NSMutableArray *friends;

@end
