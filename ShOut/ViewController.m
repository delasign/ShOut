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
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _uniqueIdentifier = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    _logoImage.image = [UIImage imageNamed:@"LaunchImage.png"];
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser)
    {
        NSLog(@"%@",currentUser.username);
        
        [NSTimer scheduledTimerWithTimeInterval:4.0
                                         target:self
                                       selector:@selector(introSegue)
                                       userInfo:0 repeats:NO];
    }
    else
    {
        PFUser *user = [PFUser user];
        user.username = [NSString stringWithFormat:@"%@",_uniqueIdentifier];
        
        user.password = [NSString stringWithFormat:@"%@",_uniqueIdentifier];
        
        [user signUpInBackground];
        
        NSLog(@"NEW USER ! ID:%@", user.username);
        
        [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(numberSegue) userInfo:0 repeats:NO];
    }
    
}




- (void)numberSegue
{
    [self performSegueWithIdentifier:@"phoneNumber" sender:nil];
}

- (void)introSegue
{
    [self performSegueWithIdentifier:@"introScreen" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"phoneNumber"]) {
        
        // PUT WHOLE USER SIGN UP IN THAT SCREEN AND INCLUDE MOBILE PHONE
        
        
    }
}


@end
