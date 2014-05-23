//
//  Movies.m
//  SFFilm
//
//  Created by Dana on 5/14/14.
//  Copyright (c) 2014 Dana Sniezko. All rights reserved.
//

#import "Movies.h"

@implementation Movies

- (id) init {
    self = [super init];
    
    if (self) {
        self.data = [[NSMutableArray alloc] init];
    }
    
    return self;
}


+ (Movies*) sharedInstance {
    static Movies* shared;
    
    if (!shared) {
        shared = [[Movies alloc] init];
    }
    
    return shared;
}

@end
