//
//  ShoutMapAnnotation.m
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 06/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import "ShoutMapAnnotation.h"

@implementation ShoutMapAnnotation

- (id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location
{
    self = [super init];
    
    if (self)
    {
        
        _title = newTitle;
        _coordinate = location;
        
    }
    
    return self;
}

- (MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"ShoutMapAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    // annotationView.image = [UIImage imageNamed:@""];
    
    return annotationView;
}

@end
