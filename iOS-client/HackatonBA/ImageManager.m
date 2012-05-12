//
//  ImageManager.m
//  PixelKnights
//
//  Created by Ezequiel Becerra on 1/24/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "ImageManager.h"
@implementation ImageManager

#pragma mark - Private
+ (NSString*) filenameFromURLString:(NSString*)stringToStrip {
    NSString *extension = [[stringToStrip componentsSeparatedByString:@"."] lastObject];
    
    stringToStrip = [stringToStrip stringByDeletingPathExtension];
    NSString *retVal = nil;
    NSCharacterSet *stripCharacterSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    retVal = [[stringToStrip componentsSeparatedByCharactersInSet:stripCharacterSet] componentsJoinedByString:@""];
    retVal = [retVal stringByAppendingPathExtension:extension];
    return retVal;
}

+(NSString *)filePathFromURLString:(NSString *)anUrlString{
    NSString *escapedFilename = [ImageManager filenameFromURLString:anUrlString];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *retVal = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@", escapedFilename]];

    return retVal;
}

#pragma mark - Public
+(void) saveImage:(UIImage *)anImage fromURLString:(NSString *)anUrlString{
    NSString *filepath = [ImageManager filePathFromURLString:anUrlString];
    [UIImagePNGRepresentation(anImage) writeToFile:filepath atomically:YES];
    
    NSLog(@"#DEBUG Saving %@", filepath);
}

+(UIImage *) imageFromURLString:(NSString *)anUrlString{
    //  Look for image at disk
    UIImage *retVal = [ImageManager cachedImageFromURLString:anUrlString];
    
    //  If is not there, then download it
    if (!retVal){
        NSURL *anUrl = [NSURL URLWithString:anUrlString];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:anUrl]];
        
        [self saveImage:image fromURLString:anUrlString];
        retVal = image;
    }
    
    return retVal;
}

+(UIImage *) cachedImageFromURLString:(NSString *)anUrlString{
    NSLog(@"#DEBUG Loading %@", anUrlString);
    
    NSString *filepath = [ImageManager filePathFromURLString:anUrlString];
    
    UIImage *retVal = [UIImage imageWithContentsOfFile:filepath];
    return retVal;
}

@end
