//
//  SFFilmTableViewController.m
//  SFFilm
//
//  Created by Dana on 5/12/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import "SFFilmTableViewController.h"
#import "Movies.h"
#import "SFFilmDetailViewController.h"
@interface SFFilmTableViewController ()


@end

@implementation SFFilmTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // movies shared obj
    self.mov = [Movies sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.mov.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];

    // set cell label to movie title
    cell.textLabel.text =[[self.mov.data objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"Preparing to send ROW: %i",indexPath.row);
    if ([[segue identifier] isEqualToString:@"detailPage"]) {
        // send the index path to detail view
        [[segue destinationViewController] setDetailItem:indexPath];
    }
    else if ([[segue identifier] isEqualToString:@"map"]) {
         //[[segue destinationViewController] setLocation:self.location];
    }
}

@end
