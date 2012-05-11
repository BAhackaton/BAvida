//
//  MapSelectionViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapSelectionViewController.h"

@interface MapSelectionViewController ()

@end

@implementation MapSelectionViewController

#pragma mark - Private

- (void)addSelectionPinWithCoordinate:(CLLocationCoordinate2D)aCoordinate{
    selectionPin = [[LocationPin alloc] initWithTitle:@"Selección" withCoordinate:aCoordinate];
    [mapView addAnnotation:selectionPin];
    [selectionPin release]; 
}

- (void)removeSelectionPin{
    if (selectionPin != nil){
        [mapView removeAnnotation:selectionPin];
        selectionPin = nil;        
    }    
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        [self removeSelectionPin];
         
        CGPoint touchPoint = [gestureRecognizer locationInView:mapView];   
        CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
        [self addSelectionPinWithCoordinate:touchMapCoordinate];
    }
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
    
    //  Long Touch gesture recognizer
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] 
                                                       initWithTarget:self action:@selector(handleLongPress:)];
    gestureRecognizer.minimumPressDuration = 2.0;
    [mapView addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];    
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
    currentLocationPin = [[[LocationPin alloc] initWithTitle:@"VOS" 
                                                    withCoordinate:location.coordinate] autorelease];
    [mapView addAnnotation:currentLocationPin];
    
    MKCoordinateSpan aCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion aCoordinateRegion = MKCoordinateRegionMake(location.coordinate, aCoordinateSpan);
    [mapView setRegion:aCoordinateRegion animated:YES];
}

-(void) locationError:(NSError *)error{
    //  #TODO Implement this
}

@end
