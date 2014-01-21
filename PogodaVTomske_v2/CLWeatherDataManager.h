//
//  CLWeatherDataManager.h
//  PogodaVTomske_v2
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLWeatherDataManager : NSObject

-(NSDictionary *) loadDataForCity:(NSString *) city;

@end
