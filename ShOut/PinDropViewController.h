//
//  PinDropViewController.h
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 29/06/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ShoutMapAnnotation.h"

@interface PinDropViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate, UIPickerViewDelegate,UITextFieldDelegate>

@end
