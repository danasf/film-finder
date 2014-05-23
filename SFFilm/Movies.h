//
//  Movies.h
//  SFFilm
//
//  Created by Dana on 5/14/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Movies : NSObject
+ (Movies*) sharedInstance;
@property (strong,nonatomic) CLLocation *location;
@property (strong,nonatomic) NSMutableArray* data;
@end
