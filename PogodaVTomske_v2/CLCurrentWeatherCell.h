//
//  CLCurrentWeatherCell.h
//  PogodaVTomske_v2
//
//  Created by chematiks on 11.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLCurrentWeatherCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel * currentTempLabel;
@property (nonatomic, retain) IBOutlet UILabel * maxTempForecastLabel;
@property (nonatomic, retain) IBOutlet UILabel * minTempForecastLabel;
@property (nonatomic, retain) IBOutlet UILabel * currentCloudingLabel;
@property (nonatomic, retain) IBOutlet UIImage * currentCloudingImage;

@end
