//
//  LocationPin.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationPin : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subTitle;
}

-(id)initWithTitle:(NSString *)aTitle withCoordinate:(CLLocationCoordinate2D)coord;

@end
