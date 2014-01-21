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

@implementation CLWeatherDataManager

- (NSDictionary *)loadDataForCity:(NSString *)city
{
    NSDictionary * weather=[[NSDictionary alloc] initWithObjectsAndKeys:@"-10.0",kCurrentTemp, nil];
    CLPogodaVTomskeParser * parser=[[CLPogodaVTomskeParser alloc] init];
    
    [parser getCurrentWeatherForCity:city];
    [parser getForecastForCity:city];
    
    
    
    return weather;
}

@end
