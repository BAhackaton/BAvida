//
//  MapSelectionViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapSelectionViewController.h"
#import "LocationPin.h"

@interface MapSelectionViewController ()

@end

@implementation MapSelectionViewController

#pragma mark - Private

-(void)zoomMapView{

}

#pragma mark - Public

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [LocationManager sharedInstance].delegate = self;
        [[LocationManager sharedInstance] locate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [mapView release];
    mapView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mapView release];
    [super dealloc];
}

#pragma mark - LocationManagerDelegateProtocol
-(void) locationUpdate:(CLLocation *)location{
    LocationPin *locationPin = [[[LocationPin alloc] initWithTitle:@"VOS" 
                                                    withCoordinate:location.coordinate] autorelease];
    [mapView addAnnotation:locationPin];
    
    MKCoordinateSpan aCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion aCoordinateRegion = MKCoordinateRegionMake(location.coordinate, aCoordinateSpan);
    [mapView setRegion:aCoordinateRegion animated:YES];
}

-(void) locationError:(NSError *)error{
    //  #TODO Implement this
}

@end
