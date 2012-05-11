//
//  MapSelectionViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapSelectionViewController.h"
#import "LoadingScreenView.h"

@interface MapSelectionViewController ()

@end

@implementation MapSelectionViewController

#pragma mark - Private
- (void)userDoneSelectingCoord{
    if (!selectionPin && !currentLocationPin){
        //  Alert error
        UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"¡Oh no!" 
                                                          message:@"No hay coordenadas seleccionadas :-(" 
                                                         delegate:nil 
                                                cancelButtonTitle:@"Ok" 
                                                otherButtonTitles:nil];
        [anAlert show];
    }else{
        CLLocationCoordinate2D coordinatesToQuery;

        if (selectionPin){
            //  Use selected coordinates
            coordinatesToQuery = selectionPin.coordinate;
        }else if (currentLocationPin) {
            //  Use GPS coordinates
            coordinatesToQuery = currentLocationPin.coordinate;
        }
        
        LoadingScreenView *loadingView = [[LoadingScreenView alloc] init];
        [self.view addSubview:loadingView];
    }
}

- (void)addRightNavigationButton{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonSystemItemDone 
                                                                   target:self 
                                                                   action:@selector(userDoneSelectingCoord)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
}

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
    
    [self addRightNavigationButton];
    
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
