//
//  CLPogodaVTomskeParser.h
//  PogodaVTomske_v2
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCityWeather.h"
#import "CLForecastOnDay.h"

@interface CLPogodaVTomskeParser : NSObject

-(CLCityWeather *) getCurrentWeatherForCity:(NSString *)city;
-(NSMutableArray *) getForecastForCity:(NSString *)city;

@end
