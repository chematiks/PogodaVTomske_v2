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
    [parser getForecastForCity:city];
    
   // currentWeather.currentTemp = roundf(currentWeather.currentTemp);
   // NSString * curTempString = [NSString stringWithFormat:@"%.2f",currentWeather.currentTemp];
 /*   NSDictionary * weather=@{kWindDirection: currentWeather.currentWindDirection,
                             kCurrentTemp: [NSNumber numberWithFloat:currentWeather.currentTemp]
                           //  kWindSpeed: currentWeather.currentSpeedWind
                             };
    
                            , ,
                            ,
                            currentWeather.currentCloudText, kCurrentCloudingText,
                            currentWeather.currentCloudImg, kCurrentCloudingImage,
                            currentWeather.moonImage, kMoonImage,
                            currentWeather.magneticStorms, kMagneticStorms,
                            currentWeather.timeSunrise, kSunrire,
                            currentWeather.timeSunSet, kSunset,
                            currentWeather.humidityAir, kHumidity,
                            currentWeather.currentPressure, kPressure,nil];
    */
    NSDictionary * weather=[[NSDictionary alloc] initWithObjectsAndKeys:
                            currentWeather.currentWindDirection, kWindDirection,
                            [NSNumber numberWithFloat:currentWeather.currentTemp], kCurrentTemp,
                            [NSNumber numberWithFloat:currentWeather.currentSpeedWind], kWindSpeed,
                            currentWeather.currentCloudText, kCurrentCloudingText,
                            currentWeather.currentCloudImg, kCurrentCloudingImage,
                            currentWeather.moonImage, kMoonImage,
                            currentWeather.magneticStorms, kMagneticStorms,
                            currentWeather.timeSunrise, kSunrire,
                            currentWeather.timeSunSet, kSunset,
                            [NSNumber numberWithFloat:currentWeather.humidityAir], kHumidity,
                            [NSNumber numberWithFloat:currentWeather.currentPressure], kPressure,
                            city, kCity, nil];
    
    
    
    return weather;
}

@end
