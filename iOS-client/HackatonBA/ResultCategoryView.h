//
//  ResultCategoryView.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageViewLazy.h"

@interface ResultCategoryView : UIView{
    UIImageViewLazy *badgeImageView;
    NSDictionary *dataSource;
}

-(id) initWithDictionary:(NSDictionary *)aDictionary;
-(void) setPosition:(CGPoint)aPoint;
@end
