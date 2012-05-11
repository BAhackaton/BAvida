//
//  ServerAPIManager.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerDelegateProtocol.h"
#import "LocationManager.h"
#import "ServerAPIDelegateProtocol.h"
@interface ServerAPIManager : NSObject<LocationManagerDelegateProtocol>{
    id <ServerAPIDelegateProtocol> delegate;
}

SYNTHESIZE_SINGLETON_INTERFACE_FOR_CLASS(ServerAPIManager)

-(void)queryPointsWithCurrentLocation;
-(void)queryPointsWithLocationCoordinate:(CLLocationCoordinate2D)aLocation;

@property (assign) id <ServerAPIDelegateProtocol> delegate;
@end
