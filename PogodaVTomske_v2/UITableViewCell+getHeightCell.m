//
//  UITableViewCell+getHeightCell.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 17.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "UITableViewCell+getHeightCell.h"
#import "constants.h"

@implementation UITableViewCell (getHeightCell)

-(float)getHeigthCell:(NSString *)cell
{
    if ([cell isEqualToString:@"CLMainViewCell"])
        return hCLMainViewCell;
    else if ([cell isEqualToString:@"CLCurrentWeatherCell"])
        return hCLCurrentWeatherCell;
    else if ([cell isEqualToString:@"CLDetailsCell"])
        return hCLDetailsCell;
    else if ([cell isEqualToString:@"CLForecastCell"])
        return hCLForecastCell;
    else if ([cell isEqualToString:@"CLMapCell"])
        return hCLMapCell;
    else if ([cell isEqualToString:@"CLSunAndMoonCell"])
        return hCLSunAndMoonCell;
    else if ([cell isEqualToString:@"CLWindAndPressureCell"])
        return hCLWindAndPressureCell;
    return 0;
}

- (void)configureCell:(NSDictionary *)content
{
    return;
}

@end
