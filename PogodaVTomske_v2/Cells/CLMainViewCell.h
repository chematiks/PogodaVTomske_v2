//
//  CLMainViewCell.h
//  PogodaVTomske_v2
//
//  Created by chematiks on 03.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLMainViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel * cityLabel;
@property (nonatomic, retain) IBOutlet UIView * mainView;

-(float) getHeigth;




@end
/*
@protocol DataSourceItem <NSObject>

@optional
-(Class)tableViewCellClass;

@end
*/