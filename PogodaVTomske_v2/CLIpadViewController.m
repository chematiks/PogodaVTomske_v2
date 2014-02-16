//
//  CLIpadViewController.m
//  PogodaVTomske_v2
//
//  Created by Admin on 12.02.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLIpadViewController.h"
#import "keys.h"
#import "constants.h"
#import "CLWeatherAPI.h"
#import "CLForecastOnDay.h"
#import "CLiPadTableViewCell.h"
#import "interfaceColor.h"

@interface CLIpadViewController ()

@end

@implementation CLIpadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _forecastTableView.delegate = self;
    _forecastTableView.dataSource = self;
    _portraitTableView.dataSource = self;
    _portraitTableView.delegate = self;
    
    [self refreshCurrentWeather];
    [self makeOrientationInterface:[[UIApplication sharedApplication] statusBarOrientation]];
    
    _landscapeView.backgroundColor = cFon;
    _cityLabel.textColor = cTextYellow;

    _forecastTableView.separatorColor = cContur;
    _forecastTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _conturForecastTable.backgroundColor = cContur;
    
    _currentWeatherView.backgroundColor = cContur;
    _currentWeatherViewFon.backgroundColor = cFon;
    _currentTempLabel.textColor = cTextYellow;
    _currentCloidTextLabel.textColor = cTextGrey;
    //_currentWeatherLabel.textColor = cTextGrey;
    // Do any additional setup after loading the view.
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self makeOrientationInterface:toInterfaceOrientation];
}

-(void) makeOrientationInterface:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        _portraitView.hidden = NO;
        _landscapeView.hidden = YES;
    }else{
        _landscapeView.hidden = NO;
        _portraitView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configurateIpad: (NSDictionary *) weather
{
    _loadTimeLabel.text = [NSDateFormatter localizedStringFromDate:[weather objectForKey:kTimeLoad] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    _cityLabel.text = [weather objectForKey:kCity];
    
    _currentTempLabel.text = [[[weather objectForKey:kCurrentTemp] stringValue] stringByAppendingString:@"°"];
    _windDirection.text = [weather objectForKey:kWindDirection];
    _currentCloidTextLabel.text = [weather objectForKey:kCurrentCloudingText];
    
    UIImage * image = [self getCloudImage:[weather objectForKey:kCurrentCloudingImage]];
    _currentCloudImage.image = image;
    _currentWindSpeedLabel.text = [[weather objectForKey:kWindSpeed] stringValue];
    _pressureLabel.text = [[weather objectForKey:kPressure] stringValue];
    _humidityLabel.text = [[weather objectForKey:kHumidity] stringValue];
    _sunriseLabel.text = [weather objectForKey:kSunrire];
    _sunsetLabel.text = [weather objectForKey:kSunset];
    _magneticStormsLabel.text = [weather objectForKey:kMagneticStorms];
    
    NSURL * url;
    if (![[weather objectForKey:kCity] isEqualToString:@"tomsk"])
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",
                                  kHttp,
                                  [weather objectForKey:kCity],
                                  baseURL,
                                  [weather objectForKey:kMoonImage]]];
    else
        url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",
                                  kHttp,
                                  baseURL,
                                  [weather objectForKey:kMoonImage]]];
    
    
    
    //NSLog(@"%@",url);
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:url];
    UIImage * moonImage = [[UIImage alloc] initWithData:imageData];
    _moonImage.image = moonImage;
    
}

-(UIImage *) getCloudImage:(NSString *) clouding
{
    NSUInteger lengthRemove = kPathImage.length + kPathCloudImage.length;
    NSString * cloudNumber = [clouding substringFromIndex:lengthRemove];
   
    NSString * result;
    int number=[cloudNumber intValue];
    
    if (number == 0) {
        NSUInteger lengthRemove = kPathImage.length + kPathForecastCloud.length+5;
        
        cloudNumber = [clouding substringFromIndex:lengthRemove];
        number = [cloudNumber intValue];
    }
    
    switch (number) {
        case 1: result=@"sun-512_.png"; break;
        case 2: result=@"partly_cloudy_day-512_.png"; break;
        case 3: result=@"partly_cloudy_day-512_.png"; break;
        case 4: result=@"partly_cloudy_rain-512_.png"; break;
        case 5: result=@"partly_cloudy_rain-512_.png"; break;
        case 6: result=@"partly_cloudy_rain-512_.png"; break;
        case 7: result=@"storm-512_.png"; break;
        case 8: result=@"clouds-512_.png"; break;
        case 9: result=@"little_rain-512_.png"; break;
        case 10: result=@"little_rain-512_.png"; break;
        case 11: result=@"little_rain-512_.png"; break;
        case 12: result=@"downpour-512_.png"; break;
        case 13: result=@"rain-512_.png"; break;
        case 14: result=@"rain-512_.png"; break;
        case 15: result=@"storm-512_.png"; break;
        case 16: result=@"clouds-512_.png"; break;
        case 17: result=@"partly_cloudy_day-512_.png"; break;
        case 18: result=@"partly_cloudy_day-512_.png"; break;
        case 19: result=@"clouds-512_.png"; break;
        case 20: result=@"sun-512_.png"; break;
        default: break;
    }
    return [UIImage imageNamed:result];
}

-(void) refreshCurrentWeather
{
    NSDictionary * weather = [[CLWeatherAPI sharedWeather] getCurrentWeather:@"tomsk"];
    [self configurateIpad:weather];
    _forecastOn10Day = [weather objectForKey:kForecast];
    [_forecastTableView reloadData];
}

- (IBAction)refreshData:(id)sender
{
    [self refreshCurrentWeather];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _forecastOn10Day.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"ipadCell";
    
    CLiPadTableViewCell * cell=[self.forecastTableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        cell=[[CLiPadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.contentView.backgroundColor = cBackground;
    
    cell = [self configureCell: cell WithData:_forecastOn10Day[indexPath.row]];
    cell.dayOfTheWeekLabel.text = [self getDayOfTheWeekForCellWithIndex:indexPath.row];
    if (indexPath.row < 2)
        cell.dayOfTheWeekLabel.textColor = cTextYellow;
    else
        cell.dayOfTheWeekLabel.textColor = cTextGrey;
    cell.dayForecast.textColor = cTextYellow;
    cell.nigthForecast.textColor = cTextGrey;
    
    return cell;
    
}

-(CLiPadTableViewCell *) configureCell:(CLiPadTableViewCell *)cell WithData:(CLForecastOnDay *) forecast
{
    
    cell.dayForecast.text = [[NSString stringWithFormat:@"%.0f",forecast.maxTemp] stringByAppendingString:@"°"];
    if (forecast.minTemp < kNoForecast)
        cell.nigthForecast.text = [[NSString stringWithFormat:@"%.0f",forecast.minTemp] stringByAppendingString:@"°"];
    else
        cell.nigthForecast.text = @"";
    cell.imageClouding.image = [self getCloudImage:forecast.cloudImg];
    return cell;
    
}

-(NSString *) getDayOfTheWeekForCellWithIndex: (NSInteger) index
{
    switch (index) {
        case 0: return @"Сегодня";
        case 1: return @"Завтра";
        //case 2: return @"Послезавтра";
        default: break;
    }
    NSDate * date = [NSDate date];
    NSDateFormatter * format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"e"];
    NSString * string=[format stringFromDate:date];
    NSInteger numberDay=[string integerValue]+index;
    numberDay = numberDay%7;
    if (numberDay==2) return @"Понедельник";
    if (numberDay==3) return @"Вторник";
    if (numberDay==4) return @"Среда";
    if (numberDay==5) return @"Четверг";
    if (numberDay==6) return @"Пятница";
    if (numberDay==0) return @"Суббота";
    if (numberDay==1) return @"Воскресение";
    return @"";
}

@end
