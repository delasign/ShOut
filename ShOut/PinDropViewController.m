//
//  PinDropViewController.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 29/06/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "PinDropViewController.h"

@interface PinDropViewController ()

@property (strong,nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITextField *eventTitle;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *endTimePicker;

@property (strong, nonatomic) MKPointAnnotation *centerAnnotation;
@property (strong,nonatomic) MKPinAnnotationView *centerAnnotationView;

@end

@implementation PinDropViewController

@synthesize locationManager;
@synthesize mapView;
@synthesize eventTitle;
@synthesize startTimePicker;
@synthesize endTimePicker;

#pragma mark -  Property Methods

- (MKPointAnnotation *)centerAnnotation
{
    if (!_centerAnnotation) {
        _centerAnnotation = [[MKPointAnnotation alloc] init];
    }
    
    return _centerAnnotation;
}

- (MKPinAnnotationView *)centerAnnotationView
{
    if (!_centerAnnotationView) {
        _centerAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self.centerAnnotation reuseIdentifier:@"centerAnnotationView"];
    }
    
    return _centerAnnotationView;
}

#pragma mark -  View Methods


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.mapView addSubview:self.centerAnnotationView];
    
    self.mapView.centerCoordinate = self.locationManager.location.coordinate;
    [self moveMapAnnotationToCoordinate:self.mapView.centerCoordinate];
    
    
    
    self.centerAnnotationView.image = [UIImage imageNamed:@"pin.png"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.startTimePicker = [[UIDatePicker alloc] init];
    self.endTimePicker = [[UIDatePicker alloc] init];
    
    self.startTimePicker.datePickerMode = UIDatePickerModeTime;
    self.endTimePicker.datePickerMode   = UIDatePickerModeTime;
    
    [startTimePicker addTarget:self action:@selector(setPickerViewStartTime) forControlEvents:UIControlEventValueChanged];
    [endTimePicker addTarget:self action:@selector(setPickerViewEndTime) forControlEvents:UIControlEventValueChanged];
    
    self.startTime.inputView = self.startTimePicker;
    
    self.endTime.inputView = self.endTimePicker;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.startTimePicker.date = [NSDate date];
    self.endTimePicker.date   = [NSDate dateWithTimeInterval:5*60 sinceDate:[NSDate date]];
    
    self.eventTitle.text = Nil;
    self.eventTitle.placeholder = [NSString stringWithFormat:@"Event Title"];
    
    self.startTime.text = [NSString stringWithFormat:(NSString *)[NSDateFormatter localizedStringFromDate:self.startTimePicker.date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle]];
    self.startTime.delegate = self;
    self.startTime.placeholder = [NSString stringWithFormat:@"Start Time"];
    
    self.endTime.text = Nil;
    self.endTime.text = [NSString stringWithFormat:(NSString *)[NSDateFormatter localizedStringFromDate:[self.startTimePicker.date dateByAddingTimeInterval:60*5] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle]];
    self.endTime.placeholder = [NSString stringWithFormat:@"End Time"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    
    self.mapView.centerCoordinate = self.locationManager.location.coordinate;
    [self moveMapAnnotationToCoordinate:self.mapView.centerCoordinate];
    
    
//    NSLog(@" longitude : %7f",self.locationManager.location.coordinate.longitude);
//    NSLog(@" latitude : %7f",self.locationManager.location.coordinate.latitude);
}

#pragma mark -  Custom Methods

#define PIN_WIDTH_OFFSET 0.4 //7.9
#define PIN_HEIGHT_OFFSET 21 //14

- (void)moveMapAnnotationToCoordinate:(CLLocationCoordinate2D) coordinate
{
    
    CGFloat xoffset = CGRectGetMidX(self.mapView.bounds) - PIN_WIDTH_OFFSET;
    CGFloat yoffset = CGRectGetMidY(self.mapView.bounds) - PIN_HEIGHT_OFFSET;
    
//    self.centerAnnotationView.center = CGPointMake(mapViewPoint.x + xoffset, mapViewPoint.y + yoffset);
    self.centerAnnotationView.center = CGPointMake(xoffset, yoffset);
    
//    self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.mapView.centerCoordinate.latitude];
//    self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.mapView.centerCoordinate.longitude];
    
    NSLog(@"%@",NSStringFromCGPoint(CGPointMake(self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude)));
}

- (void)clearKeyboard
{
    
    [self.view endEditing:YES];
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.mapView.centerCoordinate = self.locationManager.location.coordinate;
    [self moveMapAnnotationToCoordinate:self.mapView.centerCoordinate];
    [self.locationManager stopUpdatingLocation];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.centerCoordinate, 300, 300);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];

}

#pragma mark -  Map View Methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    self.centerAnnotation.coordinate = self.mapView.centerCoordinate;
    [self moveMapAnnotationToCoordinate:self.mapView.centerCoordinate];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}

#pragma mark - DatePickerView Methods

- (void)setPickerViewStartTime
{
    self.startTime.text = [NSString stringWithFormat:(NSString *)[NSDateFormatter localizedStringFromDate:self.startTimePicker.date dateStyle:nil timeStyle:NSDateFormatterShortStyle]];
    
}

- (void)setPickerViewEndTime
{
    self.endTime.text = [NSString stringWithFormat:(NSString *)[NSDateFormatter localizedStringFromDate:self.endTimePicker.date dateStyle:nil timeStyle:NSDateFormatterShortStyle]];
    
}

@end
