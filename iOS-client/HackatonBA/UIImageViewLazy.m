//
//  UIImageLazy.m
//  PixelKnights
//
//  Created by Ezequiel Becerra on 3/11/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "UIImageViewLazy.h"
#import "ImageManager.h"

@implementation UIImageViewLazy

-(id) initWithURL:(NSString *)anUrlString withPlaceholder:(NSString *)placeholderString{
    UIImage *anImage = [ImageManager cachedImageFromURLString:anUrlString];
    
    if (anImage){
        self = [super initWithImage:anImage];
    }else{
        UIImage *placeholderImage = [UIImage imageNamed:placeholderString];
        self = [super initWithImage:placeholderImage];
        if (self){
            [self loadURL:anUrlString];
        }        
    }
    
    return self;
}

-(void)loadURL:(NSString *)anUrlString{
    
    UIImage *anImage = [ImageManager cachedImageFromURLString:anUrlString];

    if (anImage){
        self.image = anImage;
        
    }else{
        
        /*  #TODO calling loadUrl twice will produce a memoryleak 
         *  on request
         */        
        
        NSURL *url = [NSURL URLWithString:anUrlString];
        request = [[ASIHTTPRequest alloc] initWithURL:url];
        
        [request setDelegate:self];
        [request startAsynchronous];
        
        [urlString release];
        urlString = [anUrlString copy];        
    }    
}

+(id) imageViewWithURL:(NSString *)anUrlString withPlaceholder:(NSString *)placeholderString{
    UIImageViewLazy *retVal = [[UIImageViewLazy alloc] initWithURL:anUrlString 
                                           withPlaceholder:placeholderString];
    [retVal autorelease];
    return retVal;
}

-(void) dealloc{
    [request clearDelegatesAndCancel];
    [request release];
    [urlString release];
    [super dealloc];
}

#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)aRequest{
    // Use when fetching binary data
    NSData *responseData = [aRequest responseData];
    UIImage *anImage = [UIImage imageWithData:responseData];
    self.image = anImage;
    [ImageManager saveImage:anImage fromURLString:urlString];
}

-(void) requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"#DEBUG requestFailed");
}
@end
