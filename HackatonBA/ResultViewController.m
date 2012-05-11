//
//  ResultViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "JSONKit.h"

@implementation ResultViewController

- (id)initWithStringResponse:(NSString *)aResponse{
    self = [super init];
    if (self){
        if (!aResponse){
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"response" ofType:@"json"];
            NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
            categories = [[jsonData objectFromJSONData] retain];
        }else{
            //  #TODO Implement this
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
