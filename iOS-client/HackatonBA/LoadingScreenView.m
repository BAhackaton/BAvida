//
//  LoadingScreenView.m
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "LoadingScreenView.h"

@implementation LoadingScreenView

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init{
    //  #TODO don't hardcode windowsSize
    CGSize windowsSize = CGSizeMake(320, 416);
    CGSize selfSize = CGSizeMake(200, 200);
    
    CGRect viewRect = CGRectMake(windowsSize.width/2.0 - selfSize.width/2.0, 
                                 windowsSize.height/2.0 - selfSize.height/2.0, 
                                 selfSize.width, 
                                 selfSize.height);
    
    self = [self initWithFrame:viewRect];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        //  Background UIView
        CGRect backgroundRect = CGRectMake(0, 0, selfSize.width, selfSize.height);
        UIView *backgroundView = [[UIView alloc] initWithFrame:backgroundRect];
        backgroundView.backgroundColor = [UIColor blackColor];
        backgroundView.alpha = 0.7;
        backgroundView.layer.cornerRadius = 10;
        
        [self addSubview:backgroundView];
        [backgroundView release];
        
        //  Loading wheel
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect activityIndicatorFrame = CGRectMake(selfSize.width/2.0 - activityIndicator.frame.size.width /2.0, 
                                                   selfSize.height/2.0 - activityIndicator.frame.size.height /2.0 - 15, 
                                                   activityIndicator.frame.size.width, 
                                                   activityIndicator.frame.size.height);
        activityIndicator.frame = activityIndicatorFrame;
        [activityIndicator startAnimating];

        [self addSubview:activityIndicator];
        [activityIndicator release];
        
        //  Loading Label
        CGRect labelFrame = CGRectMake(0, 
                                       activityIndicator.frame.origin.y + 50, 
                                       selfSize.width, 
                                       30);
        UIFont *loadingFont = [UIFont fontWithName:@"Helvetica-Bold" size:22];        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
        loadingLabel.textAlignment = UITextAlignmentCenter;
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor whiteColor];
        loadingLabel.text = @"Cargando";
        loadingLabel.font = loadingFont;
        
        [self addSubview:loadingLabel];
        [loadingLabel release];
    }
    return self;
}

- (void)stop{
    [self removeFromSuperview];
}

- (void)dealloc{
    [super dealloc];
}
@end
