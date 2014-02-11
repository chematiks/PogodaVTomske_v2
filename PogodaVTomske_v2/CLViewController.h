//
//  CLViewController.h
//  PogodaVTomske_v2
//
//  Created by chematiks on 01.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewMain;
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


@end
