//
//  CLIpadViewController.h
//  PogodaVTomske_v2
//
//  Created by Admin on 12.02.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLIpadViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *landscapeView;
@property (weak, nonatomic) IBOutlet UIView *portraitView;

- (IBAction)refreshData:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *loadTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentCloidTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *currentCloudImage;
@property (weak, nonatomic) IBOutlet UILabel *currentWindSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *magneticStormsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moonImage;

@property (weak, nonatomic) IBOutlet UIImageView *conturForecastTable;
@property (weak, nonatomic) IBOutlet UITableView *forecastTableView;
@property (weak, nonatomic) IBOutlet UITableView *portraitTableView;

@property (weak, nonatomic) IBOutlet UIView *currentWeatherView;
@property (weak, nonatomic) IBOutlet UIImageView *currentWeatherViewFon;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;

@property (nonatomic, strong) NSArray * forecastOn10Day;

@end
