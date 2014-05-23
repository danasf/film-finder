//
//  SFFilmTableViewController.h
//  SFFilm
//
//  Created by Dana on 5/12/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movies.h"
#import <CoreLocation/CoreLocation.h>

@interface SFFilmTableViewController : UITableViewController
@property (strong,nonatomic) Movies* mov;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
