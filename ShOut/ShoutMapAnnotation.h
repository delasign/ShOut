//
//  ShoutMapAnnotation.h
//  ShOut
//
//  Created by Oscar de la Hera Gomez on 06/07/2014.
//  Copyright (c) 2014 Oscar de la Hera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ShoutMapAnnotation : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location;

- (MKAnnotationView *)annotationView;

@end
