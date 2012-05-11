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
@interface ServerAPIManager : NSObject<LocationManagerDelegateProtocol>{

}

SYNTHESIZE_SINGLETON_INTERFACE_FOR_CLASS(ServerAPIManager)

-(void)queryPointsWithCurrentLocation;
-(void)queryPointsWithLocation:(CLLocation *)aLocation;
@end
