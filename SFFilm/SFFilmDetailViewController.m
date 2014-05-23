//
//  SFFilmDetailViewController.m
//  SFFilm
//
//  Created by Dana on 5/14/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import "SFFilmDetailViewController.h"

@interface SFFilmDetailViewController ()

@end

@implementation SFFilmDetailViewController

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
    NSDictionary *geoData =[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"location_1"];
    
    // create map point
    CLLocationCoordinate2D point;
    point.latitude = [[geoData objectForKey:@"latitude"] floatValue];
    point.longitude= [[geoData objectForKey:@"longitude"] floatValue];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(point, 500,500);
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = point;
    marker.title = [[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"title"];
    [self.mapView addAnnotation:marker];
    [self.mapView setRegion:viewRegion animated:YES];
    
    // set labels
    self.filmTitle.text =[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"title"];
    self.director.text =[NSString stringWithFormat:@"Director: %@",[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"director"]];
    self.writer.text = [NSString stringWithFormat:@"Writer: %@",[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"writer"]];
    self.releaseDate.text =[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"release"];
    self.actors.text = [NSString stringWithFormat:@"Starring: %@ %@",[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"actor1"],[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"actor2"]];
    self.location.text =[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"location"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)lookUpMovie:(id)sender {
    NSString *baseURL = [NSString stringWithFormat:@"http://www.imdb.com/find"];
    NSString *params = [NSString stringWithFormat:@"?q=%@&s=all",[[self.mov.data objectAtIndex:self.detailItem.row] objectForKey:@"title"]];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",baseURL,params]];
    [[UIApplication sharedApplication] openURL:url];
    
}
@end
