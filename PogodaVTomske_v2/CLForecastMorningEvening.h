//
//  CLForecastMorningEvening.h
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLForecastMorningEvening : NSObject

@property (nonatomic, retain) NSString * partOfTheDay;
@property (nonatomic, retain) NSDate *   forecastDay;
@property (nonatomic) float              averageTemp;
@property (nonatomic, retain) NSString * cloudImg;

@end
