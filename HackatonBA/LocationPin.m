//
//  LocationPin.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationPin.h"

@implementation LocationPin

#pragma mark - Public

-(id)initWithTitle:(NSString *)aTitle withCoordinate:(CLLocationCoordinate2D)coord{
    self = [super init];
    if (self){
        title = [aTitle copy];
        coordinate = coord;
    }
    return self;
}

-(void)dealloc{
    [title release];
    [subTitle release];
    [super dealloc];
}

#pragma mark - MKAnnotation
-(NSString *)title{
    NSString *retVal = title;
    return retVal;
}

-(NSString *)subtitle{
    NSString *retVal = nil;
    return retVal;
}

-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D retVal = coordinate;
    return retVal;
}

@end
