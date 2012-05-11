//
//  ViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ServerAPIManager.h"
#import "MapSelectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)gpsButtonTapped:(id)sender {
    [[ServerAPIManager sharedInstance] queryPointsWithCurrentLocation];
}

- (IBAction)lookOnMapButtonTapped:(id)sender {
    MapSelectionViewController *aViewController = [[[MapSelectionViewController alloc] init] autorelease];
    [self.navigationController pushViewController:aViewController animated:YES];
}

@end
