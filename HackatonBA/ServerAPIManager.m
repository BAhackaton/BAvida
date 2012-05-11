//
//  ServerAPIManager.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerAPIManager.h"
#import "ASIFormDataRequest.h"
@implementation ServerAPIManager
@synthesize delegate;
SYNTHESIZE_SINGLETON_IMPLEMENTATION_FOR_CLASS(ServerAPIManager)

#pragma mark - Private

#pragma mark - Public
-(id)init{
    self = [super init];
    if (self){
        [LocationManager sharedInstance].delegate = self;
    }
    return self;
}

-(void)queryPointsWithCurrentLocation{
    [[LocationManager sharedInstance] locate];
}

-(void)queryPointsWithLocationCoordinate:(CLLocationCoordinate2D)aLocation{
    CLLocation *currentLocation = [LocationManager sharedInstance].currentLocation;
    
    if (currentLocation.coordinate.latitude == aLocation.latitude &&
        currentLocation.coordinate.longitude == aLocation.longitude){
        
        //  You are already in this location. Don't query again
    }else{

        NSString *aLatitude = [NSString stringWithFormat:@"%f", aLocation.latitude];
        NSString *aLongitude = [NSString stringWithFormat:@"%f", aLocation.longitude];

        //  GET Request        
        NSString *anUrlString = [NSString stringWithFormat:@"http://10.15.11.60:8000/badata/bikestation/?lat=%@&lon=%@&dis=1", aLatitude, aLongitude];
        NSURL *anUrl = [NSURL URLWithString:anUrlString];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:anUrl];
        [request setDelegate:self];
        [request startAsynchronous];
        
        NSLog(@"#DEBUG > GET location lat:%f lon:%f", aLocation.latitude, aLocation.longitude);        
    }
}

-(void) dealloc{
    [super dealloc];
}

#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@"#DEBUG > Received response: %@", responseString);
    
    [delegate requestFinished:request];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"#DEBUG > Error on query");
    
    [delegate requestFailed:request];
}

#pragma mark - LocationManagerDelegateProtocol
-(void) locationUpdate:(CLLocation *)aLocation{
    [self queryPointsWithLocationCoordinate:aLocation.coordinate];
}

- (void)locationError:(NSError *)error{
    //  #TODO Implement this
}

@end
