//
//  ViewController.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerAPIDelegateProtocol.h"
#import "LoadingScreenView.h"

@interface ViewController : UIViewController <ServerAPIDelegateProtocol>{
    BOOL isLoading;
    LoadingScreenView *loadingView;
}
- (IBAction)gpsButtonTapped:(id)sender;
- (IBAction)lookOnMapButtonTapped:(id)sender;

@end
