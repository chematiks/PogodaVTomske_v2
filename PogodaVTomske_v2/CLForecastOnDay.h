//
//  CLForecastOnDay.h
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLForecastOnDay : NSObject

@property (nonatomic) float              maxTemp;
@property (nonatomic) float              minTemp;
@property (nonatomic, retain) NSString * cloudImg;

@end
