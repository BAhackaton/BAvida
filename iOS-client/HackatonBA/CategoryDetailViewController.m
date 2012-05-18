//
//  CategoryDetailViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryDetailViewController.h"

@interface CategoryDetailViewController ()

@end

@implementation CategoryDetailViewController

- (id) initWithDictionary:(NSDictionary *)aDictionary{
    self = [super init];
    if (self){
        dataSource = [aDictionary copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [dataSource objectForKey:@"name"];
    descriptionLabel.text = [dataSource objectForKey:@"desc"];
    
    NSString *pointsString = [NSString stringWithFormat:@"%d pts", [[dataSource objectForKey:@"value"] integerValue]];
    pointsLabel.text = pointsString;
    [badgeImage loadURL:[dataSource objectForKey:@"thumb"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [badgeImage release];
    badgeImage = nil;
    [pointsLabel release];
    pointsLabel = nil;
    [descriptionLabel release];
    descriptionLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [dataSource release];
    [badgeImage release];
    [pointsLabel release];
    [descriptionLabel release];
    [super dealloc];
}
@end
