//
//  LoginTableViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 01/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "LoginTableViewController.h"

@interface LoginTableViewController ()

@property (strong, nonatomic) NSArray *loginStrings;
@property (strong, nonatomic) NSArray *loginImages;

@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *passwordField;

- (IBAction)logIn:(UIButton *)sender;


@end

@implementation LoginTableViewController

@synthesize loginImages;
@synthesize loginStrings;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    
    self.loginStrings = @[@"Username",@"Password"];
    
    self.loginImages = @[@"",@""];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearKeyboard)];
    
    [self.tableView addGestureRecognizer:tap];
    [self.view addGestureRecognizer:tap];
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)clearKeyboard
{
    
    [self.view endEditing:YES];
    
}

- (IBAction)logIn:(UIButton *)sender
{
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 ||[password length] == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Oh No !"
                                                         message:@"You must fill in a Username and Password" delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            
            if (error)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKeyedSubscript:@"error"] delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
                
                [alert show];
            }
            else
            {
                [self performSegueWithIdentifier:@"logToIntro" sender:nil];
            }
        }];
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
    return [loginStrings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id loginCell;
    
    if (indexPath.row == 0) {
        LoginTableViewCell * loginCell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        
        if (loginCell == nil){
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoginCell" owner:self options:nil];
            loginCell = [nib objectAtIndex:0];
            
        }
        
        self.usernameField = loginCell.cellTextField;
        
        loginCell.cellTextField.placeholder = [NSString stringWithFormat:self.loginStrings[indexPath.row]];
        loginCell.cellImage.image = [UIImage imageNamed:self.loginImages[indexPath.row]];
        
        return loginCell;
        
        
    }
    
    else if (indexPath.row == 1)
    {
        LoginTableViewCell * loginCell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        
        if (loginCell == nil){
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoginCell" owner:self options:nil];
            loginCell = [nib objectAtIndex:0];
            
        }
        
        self.passwordField = loginCell.cellTextField;
        
        loginCell.cellTextField.secureTextEntry = YES;
        
        loginCell.cellTextField.placeholder = [NSString stringWithFormat:self.loginStrings[indexPath.row]];
        loginCell.cellImage.image = [UIImage imageNamed:self.loginImages[indexPath.row]];
        
        return loginCell;
    }
    

    return loginCell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
