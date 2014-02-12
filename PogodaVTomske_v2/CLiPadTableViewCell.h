//
//  CLiPadTableViewCell.h
//  PogodaVTomske_v2
//
//  Created by Admin on 12.02.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLiPadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayOfTheWeekLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageClouding;
@property (weak, nonatomic) IBOutlet UILabel *dayForecast;
@property (weak, nonatomic) IBOutlet UILabel *nigthForecast;

@end
