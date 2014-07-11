//
//  SignUpTableViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 02/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "SignUpTableViewController.h"

@interface SignUpTableViewController ()

@property (strong, nonatomic) NSArray *signUpStrings;
@property (strong, nonatomic) NSArray *signUpImages;
- (IBAction)signUp:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

// Details

@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *passwordField;
@property (strong, nonatomic) UITextField *emailField;

@end

@implementation SignUpTableViewController

@synthesize signUpImages;
@synthesize signUpStrings;
@synthesize usernameField;
@synthesize passwordField;
@synthesize emailField;

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
    
    self.signUpStrings = @[@"Username",@"Password",@"E-Mail"];
    
    self.signUpImages = @[@"",@"",@""];
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearKeyboard)];
    
    [self.tableView addGestureRecognizer:tap];
    [self.view addGestureRecognizer:tap];
    
    [self.navigationController.navigationBar  setBackgroundColor:[UIColor redColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    //[[UINavigationBar appearance] setBackgroundColor:[UIColor blueColor]];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.bottomView drawRect:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    
   // [self.view addSubview:self.bottomView];

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setScrollEnabled:NO];
}

- (void)clearKeyboard
{
    
    [self.view endEditing:YES];
    
}

- (IBAction)signUp:(UIButton *)sender
{
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 ||[password length] == 0 ||[email length] == 0)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Oh No !"
                                                         message:@"You must fill in a Username, Password and E-Mail !" delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        PFUser *newUser = [PFUser user];
        
        newUser.username    =   username;
        newUser.password    =   password;
        newUser.email       =   email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (error)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKeyedSubscript:@"error"] delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
                
                [alert show];
                
            }
            else
            {
             
                [self performSegueWithIdentifier:@"signToIntro"
                                          sender:self];
                
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
    
    NSInteger amount = [signUpStrings count] +1;
    
    // Return the number of rows in the section.
    return amount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id loginCell;
    
    if (indexPath.row  == 0) {
        
        LoginTableViewCell * loginCell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        
        if (loginCell == nil){
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoginCell" owner:self options:nil];
            loginCell = [nib objectAtIndex:0];
            
        }
        
        self.usernameField = loginCell.cellTextField;
        
        loginCell.cellTextField.placeholder = [NSString stringWithFormat:self.signUpStrings[indexPath.row]];
        loginCell.cellImage.image = [UIImage imageNamed:self.signUpImages[indexPath.row]];
        
        return loginCell;
    }
    
    else if (indexPath.row  == 1){
        
        LoginTableViewCell * loginCell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        
        if (loginCell == nil){
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoginCell" owner:self options:nil];
            loginCell = [nib objectAtIndex:0];
            
        }
        
        self.passwordField = loginCell.cellTextField;
        
        loginCell.cellTextField.secureTextEntry = YES;
        
        loginCell.cellTextField.placeholder = [NSString stringWithFormat:self.signUpStrings[indexPath.row]];
        loginCell.cellImage.image = [UIImage imageNamed:self.signUpImages[indexPath.row]];
        
        return loginCell;
    }
    
    else if (indexPath.row  == 2){
        
        LoginTableViewCell * loginCell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        
        if (loginCell == nil){
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoginCell" owner:self options:nil];
            loginCell = [nib objectAtIndex:0];
            
        }
        
        self.emailField = loginCell.cellTextField;
        
        loginCell.cellTextField.placeholder = [NSString stringWithFormat:self.signUpStrings[indexPath.row]];
        
        [loginCell.cellTextField setKeyboardType:UIKeyboardTypeEmailAddress];
        
        loginCell.cellImage.image = [UIImage imageNamed:self.signUpImages[indexPath.row]];
        
        return loginCell;
    }

    else if (indexPath.row  == 3) {
        
        SignUpTableViewCell *loginCell = (SignUpTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SignUp"];
        
        if (loginCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SignUpCell" owner:self options:nil];
            loginCell = [nib objectAtIndex:0];
        }
    
    
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
