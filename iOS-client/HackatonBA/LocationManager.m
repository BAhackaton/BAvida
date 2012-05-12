//
//  LocationManager.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
@synthesize currentLocation, delegate;

SYNTHESIZE_SINGLETON_IMPLEMENTATION_FOR_CLASS(LocationManager)

-(id)init{
    self = [super init];
    if (self){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    return self;
}

-(void)locate{
    [locationManager startUpdatingLocation];
}

-(void)dealloc{
    [locationManager release];
    [currentLocation release];
    [super dealloc];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    [delegate locationUpdate:newLocation];
    [locationManager stopUpdatingLocation];
}

@end
