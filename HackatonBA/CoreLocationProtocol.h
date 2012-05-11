//
//  CoreLocationProtocol.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoreLocationProtocol <NSObject>
@required
- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
- (void)locationError:(NSError *)error; // Any errors are sent here

@end
