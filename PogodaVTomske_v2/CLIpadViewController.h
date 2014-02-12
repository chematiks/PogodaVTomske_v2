//
//  CLIpadViewController.h
//  PogodaVTomske_v2
//
//  Created by Admin on 12.02.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLIpadViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)refreshData:(id)sender;

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

@property (weak, nonatomic) IBOutlet UITableView *forecastTableView;

@property (nonatomic, weak) NSArray * forecastOn10Day;

@end
