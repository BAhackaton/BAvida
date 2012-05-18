//
//  LocationManager.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerDelegateProtocol.h"
#import "SynthesizeSingleton.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    id <LocationManagerDelegateProtocol> delegate;
}

SYNTHESIZE_SINGLETON_INTERFACE_FOR_CLASS(LocationManager)

@property (readonly) CLLocation *currentLocation;
@property (assign) id<LocationManagerDelegateProtocol> delegate;

-(void)locate;

@end
