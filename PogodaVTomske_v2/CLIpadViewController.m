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
    
    [self refreshCurrentWeather];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configurateIpad: (NSDictionary *) weather
{
    _cityLabel.text = [weather objectForKey:kCity];
    _currentTempLabel.text = [[weather objectForKey:kCurrentTemp] stringValue];
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
    // NSLog(@"'%@'",clouding);
    
    NSUInteger lengthRemove = kPathImage.length + kPathCloudImage.length;
    
    NSString * cloudNumber = [clouding substringFromIndex:lengthRemove];
    //  NSLog(@"'%i'",[cloudNumber integerValue]);
    
   
    NSString * result;
    int number=[cloudNumber intValue];
    
    if (number == 0) {
        NSUInteger lengthRemove = kPathImage.length + kPathForecastCloud.length+5;
        
        cloudNumber = [clouding substringFromIndex:lengthRemove];
        number = [cloudNumber intValue];
    }
    
    switch (number) {
        case 1: result=@"sun-128.png"; break;
        case 2: result=@"partly_cloudy_day-128.png"; break;
        case 3: result=@"partly_cloudy_day-128.png"; break;
        case 4: result=@"partly_cloudy_rain-128.png"; break;
        case 5: result=@"partly_cloudy_rain-128.png"; break;
        case 6: result=@"partly_cloudy_rain-128.png"; break;
        case 7: result=@"storm-128.png"; break;
        case 8: result=@"clouds-128.png"; break;
        case 9: result=@"little_rain-128.png"; break;
        case 10: result=@"little_rain-128.png"; break;
        case 11: result=@"little_rain-128.png"; break;
        case 12: result=@"downpour-128.png"; break;
        case 13: result=@"rain-128.png"; break;
        case 14: result=@"rain-128.png"; break;
        case 15: result=@"storm-128.png"; break;
        case 16: result=@"clouds-128.png"; break;
        case 17: result=@"partly_cloudy_day-128.png"; break;
        case 18: result=@"partly_cloudy_day-128.png"; break;
        case 19: result=@"clouds-128.png"; break;
        case 20: result=@"sun-128.png"; break;
        default: break;
    }
    
    
    return [UIImage imageNamed:result];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) refreshCurrentWeather
{
    NSDictionary * weather = [[CLWeatherAPI sharedWeather] getCurrentWeather:@"tomsk"];
    [self configurateIpad:weather];
    _forecastOn10Day = [weather objectForKey:kForecast];
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
    
    cell = [self configureCell: cell WithData:_forecastOn10Day[indexPath.row]];
    
    return cell;
    
}

-(CLiPadTableViewCell *) configureCell:(CLiPadTableViewCell *)cell WithData:(CLForecastOnDay *) forecast
{
    
    cell.dayForecast.text = [NSString stringWithFormat:@"%.0f",forecast.maxTemp];
    cell.nigthForecast.text = [NSString stringWithFormat:@"%.0f",forecast.minTemp];
   
    
    cell.imageClouding.image = [self getCloudImage:forecast.cloudImg];
    return cell;
}

@end
