//
//  ImageManager.h
//  PixelKnights
//
//  Created by Ezequiel Becerra on 1/24/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageManager : NSObject
+(UIImage *) imageFromURLString:(NSString *)anUrlString;
+(UIImage *) cachedImageFromURLString:(NSString *)anUrlString;
+(void) saveImage:(UIImage *)anImage fromURLString:(NSString *)anUrlString;

@end
