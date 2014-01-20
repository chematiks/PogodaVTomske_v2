//
//  CLWeatherAPI.m
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLWeatherAPI.h"

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

@end
