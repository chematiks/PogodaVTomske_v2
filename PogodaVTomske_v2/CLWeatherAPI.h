//
//  CLWeatherAPI.h
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCityWeather.h"

@interface CLWeatherAPI : NSObject

+(CLWeatherAPI *) sharedWeather;

-(CLCityWeather *) getWeatherInCity:(NSString *) city;

-(NSDictionary *) getCurrentWeather:(NSString *) city;
-(NSDictionary *) getDetailsWeather:(NSString *) city;
-(NSDictionary *) getForecastWeather:(NSString *) city;
-(NSDictionary *) getSunAndMoon:(NSString *) city;
-(NSDictionary *) getWindAndPressure:(NSString *) city;

@end
