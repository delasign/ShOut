//
//  PinDropViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 29/06/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "PinDropViewController.h"

@interface PinDropViewController ()

@end

@implementation PinDropViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction =  UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.direction =  UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)swipeLeft:(UIGestureRecognizer *)gesturerecognizer
{
    [self performSegueWithIdentifier:@"PinToMap" sender:self];
}

- (void)swipeRight:(UIGestureRecognizer *)gesturerecognizer
{
    [self performSegueWithIdentifier:@"MapToInbox" sender:self];
}

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
