//
//  SFFilmMapViewController.h
//  SFFilm
//
//  Created by Dana on 5/18/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Movies.h"
@interface SFFilmMapViewController : UIViewController
@property (nonatomic,weak) Movies *mov;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (void) addPointWithLat:(float)lat Lon:(float)lon Title:(NSString*)title;

@end
