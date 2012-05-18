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
#import "ResultViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Home";
    loadingView = [[LoadingScreenView alloc] init];
    isLoading = NO;    
    [ServerAPIManager sharedInstance].delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ServerAPIManager sharedInstance].delegate = self;
}

- (IBAction)gpsButtonTapped:(id)sender {
    if (!isLoading){
        [[ServerAPIManager sharedInstance] queryPointsWithCurrentLocation];
        [self.view addSubview:loadingView];
        isLoading = YES;        
    }
}

- (IBAction)lookOnMapButtonTapped:(id)sender {
    if (!isLoading){
        MapSelectionViewController *aViewController = [[[MapSelectionViewController alloc] init] autorelease];
        [self.navigationController pushViewController:aViewController animated:YES];        
    }
}

-(void)dealloc{
    [ServerAPIManager sharedInstance].delegate = nil;
    [loadingView release];
    [super dealloc];
}

#pragma mark - ServerAPIDelegateProtocol 
-(void)requestFinished:(ASIHTTPRequest *)request{
    [loadingView stop];
    isLoading = NO;
    
    [ServerAPIManager sharedInstance].delegate = nil;    

    ResultViewController *aView = [[[ResultViewController alloc] initWithStringResponse:request.responseString] autorelease];    
    [self.navigationController pushViewController:aView animated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [loadingView stop];
    isLoading = NO;
}

@end
