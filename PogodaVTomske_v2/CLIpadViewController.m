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
    _first = YES;
    _speedWind = 10;
    _humidityHeigth = _humidityImage.frame.size.height;
    
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
    _currentWeatherViewFon.backgroundColor = cBackground;
    _currentTempLabel.textColor = cTextYellow;
    _currentCloidTextLabel.textColor = cTextGrey;
    
    _detailWeatherView.backgroundColor = cContur;
    _detailWeatherFon.backgroundColor = cFon;
    _mapView.backgroundColor = cContur;
    
    _currentWindSpeedLabel.textColor = cTextGrey;
    _humidityLabel.textColor = cTextGrey;
    // Do any additional setup after loading the view.
    
    NSURL * url = [[NSURL alloc] initWithString:@"http://earth.nullschool.net/#current/wind/surface/level/orthographic=-279.40,57.50,3000"];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
    [_mapWeather loadRequest:request];
    

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
    
    
    float humidity = [[weather objectForKey:kHumidity] floatValue];
    _humidityLabel.text = [NSString stringWithFormat:@"%.0f%%",humidity];
    [self showHumidity:humidity];    
    
    float currentWindSpeed = [[weather objectForKey:kWindSpeed] floatValue];
    
    if (currentWindSpeed == 0) {
        _speedWind = 0;
    }
    else{
        _speedWind = 3 / [[weather objectForKey:kWindSpeed] floatValue];
    }

    _currentWindSpeedLabel.text = [NSString stringWithFormat:@"%.0f м/с",currentWindSpeed];
    if (_first) {
        [self animationRotate];
    }
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

-(void) showHumidity: (float) humidity
{
    CGRect rect = _humidityImage.frame;
    
    rect.origin.y = rect.origin.y + rect.size.height - _humidityHeigth;
    rect.size.height = _humidityHeigth;
    rect.size.height = (rect.size.height/_humidityHeigth) * humidity;
    rect.origin.y = rect.origin.y + (_humidityHeigth - rect.size.height);
    _humidityImage.frame = rect;

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

#pragma mark
#pragma mark Animation Vent

- (void)clockwiseRotationStopped:(NSString *)paramAnimationID
                        finished:(NSNumber *)paramFinished
                         context:(void *)paramContext{
    
    [UIView beginAnimations:@"counterclockwiseAnimation"
                    context:NULL];
    
    // 5 seconds long
    [UIView setAnimationDuration:_speedWind];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    // Back to original rotation
    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped2:finished:context:)];
    _ventImage.transform = CGAffineTransformMakeRotation((120 * M_PI)/180);
    
    [UIView commitAnimations];
}

- (void)clockwiseRotationStopped2:(NSString *)paramAnimationID
                         finished:(NSNumber *)paramFinished
                          context:(void *)paramContext{
    
    [UIView beginAnimations:@"counterclockwiseAnimation2" context:NULL];
    
    // 5 seconds long
    [UIView setAnimationDuration:_speedWind];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // Back to original rotation
    
    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped3:finished:context:)];
    _ventImage.transform = CGAffineTransformMakeRotation((240 * M_PI)/180);
    
    [UIView commitAnimations];
}

- (void)clockwiseRotationStopped3:(NSString *)paramAnimationID
                         finished:(NSNumber *)paramFinished
                          context:(void *)paramContext{
    
    [UIView beginAnimations:@"counterclockwiseAnimation3" context:NULL];
    
    // 5 seconds long
    [UIView setAnimationDuration:_speedWind];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // Back to original rotation
    
    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped:finished:context:)];
    _ventImage.transform = CGAffineTransformMakeRotation((360 * M_PI)/180);
    
    [UIView commitAnimations];
}

-(void) animationRotate
{
    // Begin the animation
    [UIView beginAnimations:@"clockwiseAnimation"
                    context:NULL];
    
    [UIView setAnimationDuration:_speedWind];
    if (_first){
        [UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:_speedWind * 2];
        _first = NO;
    }
    else
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];

    [UIView setAnimationDidStopSelector: @selector(clockwiseRotationStopped:finished:context:)];
    
    _ventImage.transform = CGAffineTransformMakeRotation((120.0f * M_PI) / 180.0f);

    // Commit the animation
    [UIView commitAnimations];
    
}

@end
