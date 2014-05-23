//
//  SFFilmViewController.h
//  SFFilm
//
//  Created by Dana on 5/8/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Movies.h"

@interface SFFilmViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,NSURLSessionDataDelegate>

@property (strong,nonatomic) Movies* mov;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (strong,nonatomic) CLCircularRegion *sanFrancisco;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *searchAgain;
@property (strong, nonatomic) IBOutlet UILabel *errorMsg;
- (IBAction)newLocation:(id)sender;
@property (strong, nonatomic) NSMutableArray *movies;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property BOOL isLocationFound;
@property BOOL isInSF;
@property BOOL isDataTransferred;

-(void) getJSONFromLocation:(CLLocationCoordinate2D)coordinate withDistance:(float)distance;
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
/// json

@property (nonatomic, strong) NSMutableData *data;
@property (assign) BOOL downloadInProgress;
@property (nonatomic, weak) NSURLSessionDataTask *task;
@property (assign) long long totalBytes;
@property (assign) NSInteger downloadedBytes;

-(void) onFinish;


@end
