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

#define baseURL @"pogodavtomske.ru/"
#define kCurrent @"current.html"
#define kForecast @"forecast10.html"

#define kPathCloudImage @"cur_weather/"
#define kPathImage @"/images/"
#define kPathMoonImage @"moons/"
#define kPNG @".png"

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
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@%@",city,baseURL,type]];
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
        errorcode=error.code;
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
    //NSLog(@"%@",[html rawContents]);
    NSArray * child=[html findChildTags:@"td"];
    for (int i=0; i < child.count-1; i++) {
        NSString * currentNodeRow = [child[i] rawContents];
      //  NSLog(@"%@",currentNodeRow);
        range = [currentNodeRow rangeOfString:kPathCloudImage];
        if (range.length > 0)
            weather.currentCloudImg = [self findImageURLWithPath:kPathCloudImage inHTML:child[i]];
        
        NSString * currentNode = [child[i] allContents];
        //NSLog(@"%@",currentNode);
        range = [self foundDayOfTheWeek:currentNode];
        if (range.length > 0) {
            NSString * currentCloudText=[currentNode substringFromIndex:range.location+55];
            currentCloudText = [self removeTrashSpaceInString:currentCloudText];
            weather.currentCloudText = currentCloudText;
        }

        range = [currentNode rangeOfString:@"Температура"];
        if (range.length >0)
        {
            NSString * currentTempString=[child[i+1] allContents];
            currentTempString = [self removeTrashSpaceInString:currentTempString];
            weather.currentTemp = [currentTempString floatValue];
            range.length = 0;
        }
        range = [currentNode rangeOfString:@"Ветер"];
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
    NSLog(@"%@",[html rawContents]);
    
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

-(NSRange) foundDayOfTheWeek:(NSString *) string
{
    NSRange range;
    range = [string rangeOfString:@"Понедельник"];
    if (range.length == 0){
        range = [string rangeOfString:@"Вторник"];
        if (range.length == 0) {
            range = [string rangeOfString:@"Среда"];
            if (range.length > 0) {
                range = [string rangeOfString:@"Четверг"];
                if (range.length > 0) {
                    range = [string rangeOfString:@"Пятница"];
                    if (range.length > 0) {
                        return range;
                        range = [string rangeOfString:@"Суббота"];
                            if (range.length > 0)
                                return range;}}}}}
    range = [string rangeOfString:@"Воскресенье"];
    return range;
}

-(NSString *) removeTrashSpaceInString:(NSString *)string
{
  //  NSLog(@"%@",string);
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
      //  NSLog(@"1 %hhd %d",beginRemove,string.length);

        if (([symbolEnd isEqualToString:@" "]
             || [symbolEnd isEqualToString:@"\n"]
             || [symbolBegin isEqualToString:@"\t"]) && !endRemove)
            string = [string substringToIndex:[string length]-1];
        else
            endRemove = YES;
       // NSLog(@"2 %hhd %d",endRemove,string.length);
    }
    while (!(endRemove && beginRemove));
   // NSLog(@"%@",string);
    return string;
}


- (NSMutableArray *)getForecastForCity:(NSString *)city
{
    int error = [self downloadDataForCity:city andType:kForecast];
    if (error)
        return nil;
    NSMutableArray * forecast=[NSMutableArray array];
    
   
    //code parsing cite and write data in array
    
    return forecast;
}

-(HTMLNode *) getHardCore:(HTMLParser *) parser
{
    HTMLNode * currentHTMLDoc=[parser doc];
    HTMLNode * result = [currentHTMLDoc findChildWithAttribute:@"class" matchingName:@"block rc5 b2" allowPartial:NO];
    return result;
}


/*

-(void) parserData
{
    self.baseURL=@"http://pogodavtomske.ru";
    self.dataPogoda=[PTpogodaData alloc]; //создаем контейнер для данных
    //инициализируем URL и парсим
    [self downLoadData];
    self.dataPogoda.forecastOnTenDay=[NSMutableArray array];
    HTMLNode * todaybody=[self.todayParser body];
    
    HTMLNode * todayprognoz=[todaybody findChildWithAttribute:@"class" matchingName:@"center rc5" allowPartial:TRUE];
    HTMLNode * todayprognoz2=[todayprognoz findChildWithAttribute:@"class" matchingName:@"block rc5 b2" allowPartial:TRUE];
    HTMLNode * todayprognoz3=[todayprognoz2 findChildWithAttribute:@"class" matchingName:@"whdisplay" allowPartial:TRUE];
    NSArray * todayarray=[todayprognoz3 findChildTags:@"tr"];
    PTprognozNaDay * prognozToday=[[PTprognozNaDay alloc] parsWeatherForDay:[todayarray objectAtIndex:1]];
    [self.dataPogoda.forecastOnTenDay addObject:prognozToday];
    //Разбираем данные
    HTMLNode * bodyNode = [self.parser body]; // получаем родительский элемент
    // Берем id="temp" и получаем текущую температуру
    HTMLNode *currentWeather = [bodyNode findChildWithAttribute:@"class" matchingName:@"right rc5" allowPartial:TRUE];
    HTMLNode * currentWeather2=[currentWeather findChildTag:@"table"];
    HTMLNode * tempNode=[currentWeather2 findChildTag:@"p"];
    HTMLNode * tempNode2=[tempNode findChildTag:@"span"];
    NSString * strTemp=[tempNode2 allContents];
    NSRange range=[strTemp rangeOfString:@"c"];
    range.length=range.location-1;
    range.location=0;
    self.dataPogoda.currentTemp=[strTemp substringWithRange:range];
    //получаем текущую облачность
    //картинка
    NSString * currrentCloudImageURL=@" ";
    HTMLNode * cloud=[currentWeather2 findChildTag:@"img"];
    NSString * cloudImagestr=[cloud rawContents];
    NSRange cloudRange;
    NSUInteger posleURL=[cloudImagestr rangeOfString:@"title="].location;
    NSUInteger peredURL=[cloudImagestr rangeOfString:@"src="].location;
    cloudRange.length=ABS(posleURL -peredURL)-7;
    cloudRange.location=peredURL+5;
    currrentCloudImageURL=[cloudImagestr substringWithRange:cloudRange];
    
    //  NSLog(@"%@",currrentCloudImageURL);
    
    self.dataPogoda.currentCloudImage=[self.baseURL stringByAppendingString:currrentCloudImageURL];
    //текст
    NSArray * cloudFind=[currentWeather2 findChildTags:@"td"];
    HTMLNode * cloudiness=[cloudFind objectAtIndex:3];
    NSString * cloudStr=[cloudiness rawContents];
    NSRange cloudRang;
    NSUInteger posle=[cloudStr rangeOfString:@"</"].location;
    NSUInteger pered=[cloudStr rangeOfString:@"\">"].location;
    cloudRang.length=ABS(posle-pered)-17;
    cloudRang.location=pered+10;
    NSString* currentCloud=[cloudStr substringWithRange:cloudRang];
    self.dataPogoda.currentOblachnost=currentCloud;
    //---------------прогноз на сегодня--------------------
    HTMLNode * weeklyprognoz=[bodyNode findChildWithAttribute:@"class" matchingName:@"center rc5" allowPartial:TRUE];
    HTMLNode * weeklyprognoz2=[weeklyprognoz findChildWithAttribute:@"class" matchingName:@"block rc5 b2" allowPartial:TRUE];
    HTMLNode * weeklyprognoz3=[weeklyprognoz2 findChildWithAttribute:@"class" matchingName:@"whdisplay" allowPartial:TRUE];
    NSArray * weeklyprognoz4=[weeklyprognoz3 findChildTags:@"tr"];
    for (HTMLNode * weather in weeklyprognoz4)
    {
        NSString * test=[weather rawContents];
        if ([test rangeOfString:@"125px"].location<100)
        {
            PTprognozNaDay * prognoz1Day=[[PTprognozNaDay alloc] parsWeatherForDay:weather];
            [self.dataPogoda.forecastOnTenDay addObject:prognoz1Day];
        }
    }

}
*/



@end
