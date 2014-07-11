//
//  SettingsViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 05/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

- (IBAction)logOut:(UIButton *)sender;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)logOut:(UIButton *)sender
{
    [PFUser logOut];
    
    [self performSegueWithIdentifier:@"logOut" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"logOut"]) {
        
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        
    }
}

@end
