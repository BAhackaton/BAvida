//
//  ResultViewController.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController{
    NSDictionary *categories;
}

- (id)initWithStringResponse:(NSString *)aResponse;

@end
