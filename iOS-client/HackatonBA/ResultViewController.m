//
//  ResultViewController.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "JSONKit.h"
#import "ResultCategoryView.h"
#import "CategoryDetailViewController.h"

@implementation ResultViewController

#pragma mark - Notifications

-(void)categorySelected:(NSNotification *)aNotification{
    NSDictionary *data = aNotification.userInfo;
    CategoryDetailViewController *aViewController = [[[CategoryDetailViewController alloc] initWithDictionary:data] autorelease];
    [self.navigationController pushViewController:aViewController animated:YES];
}

#pragma mark - Public

- (id)initWithStringResponse:(NSString *)aResponse{
    self = [super init];
    if (self){
        if (!aResponse){
            //  #TODO Delete this. Debug code
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"response" ofType:@"json"];
            NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
            dataSource = [[jsonData objectFromJSONData] retain];
        }else{
            dataSource = [[aResponse objectFromJSONString] retain];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(categorySelected:) 
                                                 name:@"resultCategoryViewTouched" 
                                               object:nil];
    
    return self;
}

- (void)viewDidLoad
{
    NSInteger points = 0;
    
    [super viewDidLoad];
    self.navigationItem.title = @"Resultado";

    NSArray *categoriesValues = [[dataSource objectForKey:@"categories"] allValues];

    NSInteger leftMargin = 22;
    NSInteger topMargin = 0;
    NSInteger xMargin = 25;
    NSInteger yMargin = 20;
    
    NSInteger currentRow = 0;
    NSInteger currentCol = 0;
    NSInteger itemsPerRow = 3;
    
    for (NSInteger i=0; i<[categoriesValues count]; i++){
        currentRow = floor(i / itemsPerRow);
        currentCol = i%itemsPerRow;
        
        NSDictionary *aCategoryDictionary = [categoriesValues objectAtIndex:i];
        
        ResultCategoryView *aCategoryView = [[[ResultCategoryView alloc] initWithDictionary:aCategoryDictionary] autorelease];

        
        CGPoint aPoint = CGPointMake(leftMargin + currentCol * (aCategoryView.frame.size.width + xMargin), 
                                     topMargin + currentRow * (aCategoryView.frame.size.height + yMargin));
        [aCategoryView setPosition:aPoint];
        
        [scrollView addSubview:aCategoryView];
        
        points += [[aCategoryDictionary objectForKey:@"value"] integerValue];
//        NSLog(@"col %d row %d", currentCol, currentRow);
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 
                                        [categoriesValues count]/itemsPerRow * 195);
    pointsLabel.text = [NSString stringWithFormat:@"%d pts", points];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [scrollView release];
    scrollView = nil;
    [pointsLabel release];
    pointsLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [dataSource release];
    [scrollView release];
    [pointsLabel release];
    [super dealloc];
}

@end
