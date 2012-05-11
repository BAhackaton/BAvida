//
//  MapSelectionViewController.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "LocationManager.h"
#import "LocationManagerDelegateProtocol.h"

@interface MapSelectionViewController : UIViewController <MKMapViewDelegate, LocationManagerDelegateProtocol>{
    IBOutlet MKMapView *mapView;
}

@end
