//
//  UITableViewCell+getHeightCell.h
//  PogodaVTomske_v2
//
//  Created by chematiks on 17.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (getHeightCell)

-(float) getHeigthCell:(NSString *)cell;
-(void) configureCell:(NSDictionary *) content;

@end
