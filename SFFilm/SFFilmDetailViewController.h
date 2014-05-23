//
//  SFFilmDetailViewController.h
//  SFFilm
//
//  Created by Dana on 5/14/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//
#import "Movies.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SFFilmDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,weak) Movies *mov;
@property (strong, nonatomic) IBOutlet UILabel *actors;
@property (strong, nonatomic) NSIndexPath* detailItem;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *writer;
@property (strong, nonatomic) IBOutlet UILabel *filmTitle;
@property (strong, nonatomic) IBOutlet UILabel *director;
@property (strong, nonatomic) IBOutlet UILabel *releaseDate;
@property (strong, nonatomic) IBOutlet UIButton *lookup;
- (IBAction)lookUpMovie:(id)sender;
@end
