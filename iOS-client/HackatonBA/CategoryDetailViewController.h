//
//  CategoryDetailViewController.h
//  HackatonBA
//
//  Created by Ezequiel Becerra on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageViewLazy.h"

@interface CategoryDetailViewController : UIViewController{
    NSDictionary *dataSource;
    
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *pointsLabel;
    IBOutlet UIImageViewLazy *badgeImage;
}

- (id) initWithDictionary:(NSDictionary *)aDictionary;

@end
