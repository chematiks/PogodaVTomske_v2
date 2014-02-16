//
//  CLPogodaVTomskeParser.m
//  PogodaVTomske_v2
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLPogodaVTomskeParser.h"
#import "HTMLParser.h"
#import "HTMLNode.h"
#import "constants.h"




@interface CLPogodaVTomskeParser ()
{
    HTMLParser * parserCurrent;
    HTMLParser * parserForcast;
}

@end

@implementation CLPogodaVTomskeParser

-(int) downloadDataForCity:(NSString *) city andType:(NSString *) type
{
    NSError * error = nil;
    if ([city isEqualToString:@"tomsk"]) city=@"";
    if (city.length >0)
        city=[city stringByAppendingString:@"."];
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",kHttp,city,baseURL,type]];
    NSData * data=[[NSData alloc] initWithContentsOfURL:url];
    NSString * stroka=[[NSString alloc] initWithData:data encoding:NSWindowsCP1251StringEncoding];
    if ([type isEqualToString:kCurrent])
        parserCurrent=[[HTMLParser alloc] initWithString:stroka error:&error];
    else
        parserForcast=[[HTMLParser alloc] initWithString:stroka error:&error];
    
    int errorcode=0;
    if (error)
    {
        NSLog(@"Error: %@", error);
        errorcode=(int)error.code;
    }
    return errorcode;
}

- (CLCityWeather *)getCurrentWeatherForCity:(NSString *)city
{
    int error = [self downloadDataForCity:city andType:kCurrent];
    if (error)
        return nil;
    CLCityWeather * currentWeather=[[CLCityWeather alloc] init];
    
    HTMLNode * currentHTML=[self getHardCore:parserCurrent];
    
    currentWeather.city=city;
    currentWeather.timeLoadWeather=[NSDate date];
    
    HTMLNode * currentHTML2 = [currentHTML findChildWithAttribute:@"width" matchingName:@"640" allowPartial:YES];
    
    NSArray * array=[currentHTML2 findChildTags:@"tr"];
    
    
    currentWeather = [self getCurrentTemp:array[0] in:currentWeather];
    
    currentWeather = [self getSunAndMoonInfo:array[1] in:currentWeather];
    
    currentWeather = [self getPressureAndHumidity:array[2] in:currentWeather];

    currentWeather = [self getMagneticStorms:array[3] in:currentWeather];
    
    
   /* for (HTMLNode * node in array) {
        NSLog(@"%@",[node tagName]);
        NSLog(@"%@",[node allContents]);
        
    }
    */
    //http://pogodavtomske.ru/current.html
    //code parsing cite and write data in currentWeather
    
    
    return currentWeather;
}

-(CLCityWeather *) getCurrentTemp:(HTMLNode *) html in:(CLCityWeather *) weather
{
    NSRange range;
    NSArray * child=[html findChildTags:@"td"];
    for (int i=0; i < child.count-1; i++) {
        //NSLog(@"%@",[child[i] rawContents]);
        NSString * currentNodeRow = [child[i] rawContents];
        range = [currentNodeRow rangeOfString:[kPathImage stringByAppendingString:kPathCloudImage]];
        if (range.length > 0){
            weather.currentCloudImg = [self findImageURLWithPath:kPathCloudImage inHTML:child[i]];
            NSArray * currentCloudTextNode = [[child[i] children][1] children];
            NSString * currentCloudText = [currentCloudTextNode[7] rawContents];
            currentCloudText = [self removeTrashSpaceInString:currentCloudText];
            weather.currentCloudText = currentCloudText;
        }
        range = [currentNodeRow rangeOfString:@"Температура"];
        if (range.length >0)
        {
            NSString * currentTempString=[child[i+1] allContents];
            currentTempString = [self removeTrashSpaceInString:currentTempString];
            weather.currentTemp = [currentTempString floatValue];
            range.length = 0;
        }
        range = [currentNodeRow rangeOfString:@"Ветер"];
        if (range.length > 0)
        {
            NSString * currentSpeedWind = [child[i+1] allContents];
            currentSpeedWind = [self removeTrashSpaceInString:currentSpeedWind];
            weather.currentSpeedWind = [currentSpeedWind floatValue];
            range.length=0;
            
            NSString * currentWindDirection = [currentSpeedWind substringFromIndex:10];
            currentWindDirection = [self removeTrashSpaceInString:currentWindDirection];
            weather.currentWindDirection = currentWindDirection;
            range.length = 0;
        }
        
        
        
    }

    return weather;
}

-(CLCityWeather *) getSunAndMoonInfo:(HTMLNode *) html in:(CLCityWeather *) weather
{
    
    NSRange range;
    
    weather.moonImage = [self findImageURLWithPath:kPathMoonImage inHTML:html];
 
    NSArray * child=[html findChildTags:@"td"];
    for (int i=0; i < child.count-1; i++) {
        NSString * currentNodeRow = [child[i] rawContents];
        range = [currentNodeRow rangeOfString:@"Солнце"];
        if (range.length > 0)
        {
            NSArray * child2=[child[i+1] findChildTags:@"span"];
            weather.timeSunrise=[child2[0] allContents];
            weather.timeSunSet=[child2[1] allContents];
        }
    }
    return weather;
}

-(CLCityWeather *) getPressureAndHumidity:(HTMLNode *) html in:(CLCityWeather *) weather
{
    NSRange range;
    NSArray * child=[html findChildTags:@"td"];
    for (int i=0; i < child.count-1; i++) {
        NSString * currentNodeRow = [child[i] rawContents];
        range = [currentNodeRow rangeOfString:@"Давление"];
        if (range.length > 0)
        {
            NSString * string=[child[i+1] allContents];
            string = [self removeTrashSpaceInString:string];
            weather.currentPressure = [string floatValue];
            range.length = 0;
        }
        
        range = [currentNodeRow rangeOfString:@"Влажность"];
        if (range.length > 0)
        {
            NSString * string=[child[i+1] allContents];
            string = [self removeTrashSpaceInString:string];
            weather.humidityAir = [string floatValue];
            range.length = 0;
        }
        
    }
    
    return weather;
}

-(CLCityWeather *) getMagneticStorms:(HTMLNode *) html in:(CLCityWeather *) weather
{
    //NSLog(@"%@",[html rawContents]);
    
    NSArray * allTDTeg = [html findChildTags:@"td"];
    NSString * magneticStorms = [allTDTeg[allTDTeg.count-1] allContents];
    magneticStorms = [self removeTrashSpaceInString:magneticStorms];
    weather.magneticStorms = magneticStorms;
    return weather;
}

-(NSString *) findImageURLWithPath:(NSString *) path inHTML:(HTMLNode *) html
{
    NSString * rawContents = [html rawContents];
    
    NSString * string = [NSString stringWithFormat:@"%@%@",kPathImage,path];
    
    NSRange rangeBegin = [rawContents rangeOfString:string];
    NSRange rangeEnd = [rawContents rangeOfString:kPNG];
    
    NSRange rangeResult;
    
    rangeResult.location = rangeBegin.location;
    
    rangeResult.length = (rangeEnd.location + kPNG.length) - rangeResult.location;
    
    NSString * result = [rawContents substringWithRange:rangeResult];
    
    return result;
}


-(NSString *) removeTrashSpaceInString:(NSString *)string
{
    BOOL beginRemove = NO;
    BOOL endRemove = NO;
    do {
        NSString * symbolBegin = [string substringToIndex:1];
        NSString * symbolEnd = [string substringFromIndex:[string length]-1];
        if (([symbolBegin isEqualToString:@" "]
             || [symbolBegin isEqualToString:@"\n"]
             || [symbolBegin isEqualToString:@"\t"]) && !beginRemove)
            string = [string substringFromIndex:1];
        else
            beginRemove = YES;

        if (([symbolEnd isEqualToString:@" "]
             || [symbolEnd isEqualToString:@"\n"]
             || [symbolBegin isEqualToString:@"\t"]) && !endRemove)
            string = [string substringToIndex:[string length]-1];
        else
            endRemove = YES;
    }
    while (!(endRemove && beginRemove));
    return string;
}


- (NSMutableArray *)getForecastForCity:(NSString *)city
{
    int error = [self downloadDataForCity:city andType:kForecastHtml];
    if (error)
        return nil;
    NSMutableArray * forecast=[NSMutableArray array];
    
    HTMLNode * core = [self getHardCore:parserForcast];
    
    NSArray * findTableInCore = [core children];
    NSArray * allStringInTable = [findTableInCore[9] findChildTags:@"tr"];
    
    for (HTMLNode * node in allStringInTable)
    {
       // NSLog(@"%@",[node rawContents] );
        if ([[node rawContents] rangeOfString:@"125px"].length > 0) {
            HTMLNode * currentNode = node;
            CLForecastOnDay * currentDay = [self getForecastForOneDay:currentNode];
            if (!currentDay.minTemp) {
                NSLog(@"not data forecast on the day!!!");
            }
            [forecast addObject:currentDay];
        }

    }
    //code parsing cite and write data in array
    
    return forecast;
}

-(CLForecastOnDay *) getForecastForOneDay: (HTMLNode *)currentNode
{
    CLForecastOnDay * forecast = [[CLForecastOnDay alloc] init];
    
    
    NSArray * arrayColomn = [currentNode findChildTags:@"td"];
    
    forecast.cloudImg = [self findImageURLWithPath:kPathForecastCloud inHTML:currentNode];

    NSArray * arrayTemp = [arrayColomn[2] findChildTags:@"span"];
    if (arrayTemp.count > 1) {
        forecast.minTemp = [[arrayTemp[0] allContents] floatValue];
        forecast.maxTemp = [[arrayTemp[1] allContents] floatValue];
    }else{
        forecast.maxTemp = [[arrayTemp[0] allContents] floatValue];
        forecast.minTemp = kNoForecast;
    }
    return forecast;
}

-(HTMLNode *) getHardCore:(HTMLParser *) parser
{
    HTMLNode * currentHTMLDoc=[parser doc];
    HTMLNode * result = [currentHTMLDoc findChildWithAttribute:@"class" matchingName:@"block rc5 b2" allowPartial:NO];

    return result;
}

@end
