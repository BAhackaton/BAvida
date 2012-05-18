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
#import "LocationPin.h"
#import "LoadingScreenView.h"
#import "ServerAPIDelegateProtocol.h"

@interface MapSelectionViewController : UIViewController <MKMapViewDelegate, LocationManagerDelegateProtocol, ServerAPIDelegateProtocol>{
    IBOutlet MKMapView *mapView;
    LocationPin *selectionPin;
    LocationPin *currentLocationPin;
    LoadingScreenView *loadingView;
}

@end
