//
//  ResultCategoryView.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultCategoryView.h"
@implementation ResultCategoryView

#pragma mark - Private

-(void)buttonTouched:(id) sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resultCategoryViewTouched" object:nil userInfo:dataSource];
}

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithDictionary:(NSDictionary *)aDictionary{
    self = [super init];
    if (self){
        dataSource = [aDictionary copy];
        
        UIImage *dummyCategoryImage = [UIImage imageNamed:@"dummy_category.png"];
        
        //  Badge Image
        badgeImageView = [[[UIImageViewLazy alloc] init] autorelease];
        badgeImageView.frame = CGRectMake(0, 18, 75, 75);
        badgeImageView.image = dummyCategoryImage;
        [badgeImageView loadURL: [aDictionary objectForKey:@"thumb"]];
        [self addSubview:badgeImageView];
        
        //  Badge Name Label
        CGRect titleLabelRect = CGRectMake(0, 0, 75, 18);
        UILabel *titleLabel = [[[UILabel alloc] initWithFrame:titleLabelRect] autorelease];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = [aDictionary objectForKey:@"name"];
        titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:titleLabel];
        
        //  Points Label
        CGRect pointsLabelRect = CGRectMake(0, 18+75, 75, 18);
        UILabel *pointsLabel = [[[UILabel alloc] initWithFrame:pointsLabelRect] autorelease];
        pointsLabel.textColor = [UIColor blackColor];
        pointsLabel.text = [[aDictionary objectForKey:@"value"] stringValue];
        pointsLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:pointsLabel];
        
        //  self config
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, 75, 117);
        
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        aButton.frame = self.frame;
        [self addSubview:aButton];
    }
    return self;
}

-(void)setPosition:(CGPoint)aPoint{
    CGRect newFrame = CGRectMake(aPoint.x, 
                                 aPoint.y, 
                                 self.frame.size.width, 
                                 self.frame.size.height);
    self.frame = newFrame;
}
                               
-(void)dealloc{
    [dataSource release];
    [super dealloc];
}

@end
