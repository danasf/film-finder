//
//  SFFilmViewController.m
//  SFFilm
//
//  Created by Dana on 5/8/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import "SFFilmViewController.h"
#import "SFFilmTableViewController.h"
#import "Movies.h"
@interface SFFilmViewController () {
    NSMutableArray *jsonArray;
}

@end

@implementation SFFilmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initiate movies
    self.mov = [Movies sharedInstance];

    // setup basics
    self.isLocationFound = NO;
    self.isInSF = NO;
    self.isDataTransferred = NO;
    self.btn.alpha=0;
    self.errorMsg.alpha=0;

    // start location lookup
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.delegate = self;
    [self.activityIndicator startAnimating];
    self.location = [[CLLocation alloc] init];
    CLLocationCoordinate2D cityCenter =  CLLocationCoordinate2DMake(37.775206,-122.419208);
    self.sanFrancisco = [[CLCircularRegion alloc] initWithCenter:cityCenter radius:13000.0 identifier:@"SF"];
    [self.locationManager startUpdatingLocation];
    
}


// segue handling
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"segOne"])
    {
        NSLog(@"Sending %i items",self.movies.count);
        //SFFilmTableViewController *other = (SFFilmTableViewController *)segue.destinationViewController;
        //[other setLocation:self.location];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    
    // if location is found, lat should be greater than 0.0000
    if(self.location.coordinate.latitude > 0) {
        NSLog(@"Location updated!");
        NSLog(@"Lat:%f",self.location.coordinate.latitude);
        NSLog(@"Lon:%f",self.location.coordinate.longitude);
        
        self.isLocationFound = YES;

        // is it in San Francisco?
        NSLog(@"SF region %@",self.sanFrancisco);
        if ([self.sanFrancisco containsCoordinate:self.location.coordinate]) {
            NSLog(@"Yes, your coordinate is in SF!");
            self.errorMsg.alpha=0.0;
            self.isInSF = YES;
            [self.locationManager stopUpdatingLocation];
            self.mov.location = self.location;
            // then grab data within 1km
            [self getJSONFromLocation:self.location.coordinate withDistance:1000.0];

        } else {
            NSLog(@"Your coordinate is not SF! Keep trying...");
            self.errorMsg.alpha=1.0;
            //[self.locationManager stopUpdatingLocation];
            //[self.btn setTitle:@"Try Again" forState:UIControlStateNormal];
        }
      
    }
    
}

-(void) getJSONFromLocation:(CLLocationCoordinate2D)coordinate withDistance:(float)distance {
    
    
    // make region 
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, distance, distance);
    CLLocationCoordinate2D topLeft, bottomRight;
    topLeft.latitude  = self.location.coordinate.latitude  + (region.span.latitudeDelta  / 2.0);
    topLeft.longitude = self.location.coordinate.longitude - (region.span.longitudeDelta / 2.0);
    bottomRight.latitude  = self.location.coordinate.latitude  - (region.span.latitudeDelta  / 2.0);
    bottomRight.longitude = self.location.coordinate.longitude + (region.span.longitudeDelta / 2.0);

    // grab url
    NSURLSession* s;
    
    NSString *baseURL = [NSString stringWithFormat:@"http://opendata.socrata.com/resource/ge6u-xxyt.json"];
    NSString *params = [NSString stringWithFormat:@"?$where=within_box(location_1,%f,%f,%f,%f)",topLeft.latitude,topLeft.longitude,bottomRight.latitude,bottomRight.longitude];

    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",baseURL,params]];
    NSURLSessionConfiguration *c = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    s = [NSURLSession sessionWithConfiguration: c delegate: self delegateQueue: nil];
    // create the task object
    self.task = [s dataTaskWithURL: url];
    
    // start the action
    [self.task resume];
    
    NSLog(@"URL:%@",url);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
        } else {
            
            
            NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
                jsonArray = (NSMutableArray *)jsonObject;
                for(int i=0; i < jsonArray.count; i++) {
                    NSLog(@"jsonArrayItem - %@",[[jsonObject objectAtIndex:i] objectForKey:@"title"]);
                    [self.mov.data addObject:(NSDictionary*)[jsonObject objectAtIndex:i]];
                    NSLog(@"Movies array length: %i",self.mov.data.count);
                }
                self.isDataTransferred = YES;
        }
        self.btn.alpha=1.0;
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha=0;
    }];
}
- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"did receive response...");
    
    self.data = [NSMutableData data];
    NSLog(@"File Size %@",self.data);
    
    completionHandler(NSURLSessionResponseAllow);
}


- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"Did complete...");
    
    [self performSelectorOnMainThread: @selector(onFinish) withObject:self waitUntilDone: NO];
    
}

- (void) onFinish {
    dispatch_async(dispatch_get_main_queue(),^{
        self.btn.alpha=1.0;
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha=0;
    });
}



- (IBAction)newLocation:(id)sender {
    self.isLocationFound = NO;
    self.isInSF = NO;
    self.isDataTransferred = NO;
    self.btn.alpha=0;
    [self.mov.data removeAllObjects];
    [self.locationManager startUpdatingLocation];
}
@end
