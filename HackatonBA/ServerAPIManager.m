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

-(void)queryPointsWithLocation:(CLLocation *)aLocation{
    CLLocation *currentLocation = [LocationManager sharedInstance].currentLocation;
    
    if (currentLocation.coordinate.latitude == aLocation.coordinate.latitude &&
        currentLocation.coordinate.longitude == aLocation.coordinate.longitude){
        
        //  You are already in this location. Don't query again
    }else{
        
        NSString *anUrlString = @"anUrl";
        NSURL *anUrl = [NSURL URLWithString:anUrlString];
        NSString *aLatitude = [NSString stringWithFormat:@"%f", aLocation.coordinate.latitude];
        NSString *aLongitude = [NSString stringWithFormat:@"%f", aLocation.coordinate.longitude];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:anUrl];
        [request setPostValue:aLatitude forKey:@"lat"];
        [request setPostValue:aLongitude forKey:@"lon"];
        [request startAsynchronous];   
        
        NSLog(@"#DEBUG > POST location lat:%f lon:%f", aLocation.coordinate.latitude, aLocation.coordinate.longitude);        
    }
}

-(void) dealloc{
    [super dealloc];
}

#pragma mark - LocationManagerDelegateProtocol
-(void) locationUpdate:(CLLocation *)aLocation{
    [self queryPointsWithLocation:aLocation];
}

- (void)locationError:(NSError *)error{
    //  #TODO Implement this
}

@end
