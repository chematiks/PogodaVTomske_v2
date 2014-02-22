//
//  CLWeatherDataManager.m
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLWeatherDataManager.h"
#import "CLPogodaVTomskeParser.h"
#import "keys.h"
#import "CLCityWeather.h"

@implementation CLWeatherDataManager

- (NSDictionary *)loadDataForCity:(NSString *)city
{
    
    CLPogodaVTomskeParser * parser=[[CLPogodaVTomskeParser alloc] init];
    
    CLCityWeather * currentWeather = [parser getCurrentWeatherForCity:city];
    
    currentWeather.forecastFor10Days = [parser getForecastForCity:city];
    
   
    NSMutableDictionary * weather = [[NSMutableDictionary alloc] init];
    
    [weather setObject:currentWeather.forecastFor10Days forKey:kForecast];
    if (currentWeather.currentWindDirection) {
        [weather setObject:currentWeather.currentWindDirection forKey:kWindDirection];
    }
    [weather setObject:[NSNumber numberWithFloat:currentWeather.currentTemp] forKey:kCurrentTemp];
    [weather setObject:[NSNumber numberWithFloat:currentWeather.currentSpeedWind] forKey:kWindSpeed];
    [weather setObject:currentWeather.currentCloudText forKey:kCurrentCloudingText];
    [weather setObject:currentWeather.currentCloudImg forKey:kCurrentCloudingImage];
    [weather setObject:currentWeather.moonImage forKey:kMoonImage];
    [weather setObject:currentWeather.magneticStorms forKey:kMagneticStorms];
    [weather setObject:currentWeather.timeSunrise forKey:kSunrire];
    [weather setObject:currentWeather.timeSunSet forKey:kSunset];
    [weather setObject:[NSNumber numberWithFloat:currentWeather.humidityAir] forKey:kHumidity];
    [weather setObject:[NSNumber numberWithFloat:currentWeather.currentPressure] forKey:kPressure];
    [weather setObject:city forKey:kCity];
    [weather setObject:currentWeather.timeLoadWeather forKey:kTimeLoad];
    
    
    
    
    
    return weather;
}

@end
