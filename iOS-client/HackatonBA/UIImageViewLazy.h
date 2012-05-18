//
//  UIImageLazy.h
//  PixelKnights
//
//  Created by Ezequiel Becerra on 3/11/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface UIImageViewLazy : UIImageView <ASIHTTPRequestDelegate>{
    NSString *urlString;
    ASIHTTPRequest *request;
}

-(id) initWithURL:(NSString *)anUrlString withPlaceholder:(NSString *)placeholderString;
+(id) imageViewWithURL:(NSString *)anUrlString withPlaceholder:(NSString *)placeholderString;

-(void)loadURL:(NSString *)anUrlString;

@end
