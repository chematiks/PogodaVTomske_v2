//
//  CLWeatherAPI.m
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLWeatherAPI.h"
#import "CLWeatherDataManager.h"

@interface CLWeatherAPI ()
{
    BOOL isOnline;
    CLWeatherDataManager * weatherDataManager;
}

@end

@implementation CLWeatherAPI

+(CLWeatherAPI *) sharedWeather
{
    static CLWeatherAPI * _sharedWeather=nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedWeather=[[CLWeatherAPI alloc] init];
    });
    return _sharedWeather;
}

-(id) init
{
    self = [super init];
    if (self) {
        weatherDataManager=[[CLWeatherDataManager alloc] init];
        isOnline = YES;
    }
    return self;
}

- (CLCityWeather *)getWeatherInCity:(NSString *)city
{
    CLCityWeather * weather=[[CLCityWeather alloc] init];
    
    //-------------------------------------------
    //checking have or not data and date last weather data
    //-------------------------------------------
    
    

    return weather;
}

- (NSDictionary *)getCurrentWeather:(NSString *)city
{
    return  [weatherDataManager loadDataForCity:city];
}

-(NSDictionary *) getDetailsWeather:(NSString *) city
{
    return  [weatherDataManager loadDataForCity:city];
}

-(NSDictionary *) getForecastWeather:(NSString *) city
{
    return  [weatherDataManager loadDataForCity:city];
}

-(NSDictionary *) getSunAndMoon:(NSString *) city
{
    return  [weatherDataManager loadDataForCity:city];
}

-(NSDictionary *) getWindAndPressure:(NSString *) city
{
    return  [weatherDataManager loadDataForCity:city];
}

@end
