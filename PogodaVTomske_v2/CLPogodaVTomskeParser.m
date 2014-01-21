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

@implementation CLPogodaVTomskeParser

 


/*
-(int) downLoadData
{
    NSError * error = nil;
    NSData * data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.baseURL stringByAppendingString:@"/forecast10.html"]]];
    NSString * stroka=[[NSString alloc] initWithData:data encoding:NSWindowsCP1251StringEncoding];
    self.parser=[[HTMLParser alloc] initWithString:stroka error:&error];
    int errorcode=0;
    if (error)
    {
        NSLog(@"Error: %@", error);
        errorcode=error.code;
    }
    NSData * todayData=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.baseURL stringByAppendingString:@"/index.html"]]];
    NSString * todaystr=[[NSString alloc] initWithData:todayData encoding:NSWindowsCP1251StringEncoding];
    self.todayParser=[[HTMLParser alloc] initWithString:todaystr error:&error];
    if (error)
    {
        NSLog(@"Error: %@", error);
        errorcode=error.code;
        
    }
    
    return errorcode;
}


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
    todayInt=0;
    wallpapers =[NSMutableArray array];
    UIImage * wallp1=[UIImage imageNamed568:@"Wallpaper1.jpg"];
    [wallpapers addObject:wallp1];
    UIImage * wallp2=[UIImage imageNamed568:@"wallpaper2.jpg"];
    [wallpapers addObject:wallp2];
    wallpapersDeg =[NSMutableArray array];
    UIImage * wallpD1=[UIImage imageNamed568:@"Wallpaper1deg.jpg"];
    [wallpapersDeg addObject:wallpD1];
    UIImage * wallpD2=[UIImage imageNamed568:@"wallpaper2deg.jpg"];
    [wallpapersDeg addObject:wallpD2];
}
*/



@end
