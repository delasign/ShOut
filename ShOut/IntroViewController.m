//
//  IntroViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 29/06/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *introImageView;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (strong, nonatomic) NSArray *introText;
@property (strong, nonatomic) IBOutlet UIPageControl *introPageControl;
- (IBAction)introPageChange:(UIPageControl *)sender;
@property (strong, nonatomic) CAAnimation *transition;

@end

@implementation IntroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // IMPLEMENT INTROTEXT
    
    _introText = @[@"1", @"2", @"3", @"4", @"5"];
    
    // IMPLEMENT UIPAGECONTROL
    
    _introPageControl = [[UIPageControl alloc] init];
    _introPageControl.frame = CGRectMake(self.view.frame.size.width*240/320,
                                         self.view.frame.size.height/2 - self.view.frame.size.height*37/568 ,
                                         self.view.frame.size.width*110/320,
                                         self.view.frame.size.height*37/568);
    _introPageControl.numberOfPages = 5;
    _introPageControl.currentPage = 0;
    _introPageControl.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    [self.view addSubview:_introPageControl];
    [_introPageControl addTarget:self action:@selector(introPageChange:) forControlEvents:UIControlEventValueChanged];
    
    // IMPLEMENT LABEL
    
    _introLabel.text = self.introText[_introPageControl.currentPage];
    [self.view addSubview:_introLabel];
    
    // IMPLEMENT GESTURE METHODS
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    
    swipeLeft.direction =  UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    // NAVIGATION CONTROLLER MODS
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
}

// Gesture recognizers

- (void)swipeLeft:(UIGestureRecognizer *)gestureRecognizer
{
    [self performSegueWithIdentifier:@"introSwipeOut" sender:nil];
}

- (void)swipeUp:(UIGestureRecognizer *)gestureRecognizer
{
    _introPageControl.currentPage++;
    //[_transition setSubtype:kCATransitionFromBottom];
    [self updateUI];
}

- (void)swipeDown:(UIGestureRecognizer *)gestureRecognizer
{
    _introPageControl.currentPage--;
    //[_transition setSubtype:kCATransitionFromTop];
    [self updateUI];
}

- (void)introPageChange:(UIPageControl *)sender
{
    [self updateUI];
}

- (void)updateUI
{
    _introLabel.text = [NSString stringWithFormat:@"%ld",(_introPageControl.currentPage+1)];
}


@end
