//
//  CLCityWeather.h
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCityWeather : NSObject

@property (nonatomic, retain) NSString *      city;
@property (nonatomic,retain) NSDate *         timeLoadWeather;
@property (nonatomic) float                   currentTemp;
@property (nonatomic,retain) NSString *       currentCloudImg;
@property (nonatomic,retain) NSString *       currentCloudText;
@property (nonatomic) float                   currentSpeedWind;
@property (nonatomic,retain) NSString *       currentWindDirection;
@property (nonatomic) float                   currentPressure;
@property (nonatomic,retain) NSDate *         timeSunSet;
@property (nonatomic,retain) NSDate *         timeSunrise;
@property (nonatomic) float                   humidityAir;
@property (nonatomic,retain) NSString *       magneticStorms;
@property (nonatomic,retain) NSString *       moonImage;
//@property (nonatomic,retain) NSMutableArray * forecastFor10Days;


@end
