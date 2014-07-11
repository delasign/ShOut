//
//  ContactsTableViewController.h
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 05/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "EditContactsTableViewController.h"

@interface ContactsTableViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;

@end
