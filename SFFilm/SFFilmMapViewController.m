//
//  SFFilmMapViewController.m
//  SFFilm
//
//  Created by Dana on 5/18/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import "SFFilmMapViewController.h"

@interface SFFilmMapViewController ()

@end

@implementation SFFilmMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    // create shared movies object
    self.mov = [Movies sharedInstance];
    NSLog(@"Passed location:%f,%f",self.mov.location.coordinate.latitude,self.mov.location.coordinate.longitude);
    for(NSDictionary *item in self.mov.data) {
        NSDictionary *geo =[item objectForKey:@"location_1"];
        // create map point
        [self addPointWithLat:[[geo objectForKey:@"latitude"] floatValue] Lon:[[geo objectForKey:@"longitude"] floatValue] Title:[item objectForKey:@"title"]];
        
    }
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.mov.location.coordinate, 1000, 1000);
    [self.mapView setRegion:viewRegion animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPointWithLat:(float)lat Lon:(float)lon Title:(NSString *)title {
    CLLocationCoordinate2D point;
    point.latitude = lat;
    point.longitude= lon;
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = point;
    marker.title = title;
    [self.mapView addAnnotation:marker];

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
