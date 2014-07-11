//
//  ViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 29/06/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) NSString *uniqueIdentifier;
//@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)Login:(UIButton *)sender;
- (IBAction)SignUp:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _uniqueIdentifier = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
   // _logoImage.image = [UIImage imageNamed:@"LaunchImage.png"];
    
    self.navigationItem.hidesBackButton = YES;
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser)
    {
        [self performSegueWithIdentifier:@"introScreen" sender:nil];
    }
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"phoneNumber"]) {
        
        // PUT WHOLE USER SIGN UP IN THAT SCREEN AND INCLUDE MOBILE PHONE
        
        
    }
}


- (IBAction)Login:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"login" sender:nil];
}

- (IBAction)SignUp:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"signUp" sender:nil];
}

@end
