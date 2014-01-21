//
//  CLCurrentWeatherCell.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 11.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLCurrentWeatherCell.h"
#import "CLWeatherAPI.h"
#import "keys.h"

@implementation CLCurrentWeatherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor=[UIColor redColor];
        
        UILabel * currentTemp=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 200, 100)];
        currentTemp.textAlignment=NSTextAlignmentCenter;
        currentTemp.font=[currentTemp.font fontWithSize:30];
        
        [self.contentView addSubview:currentTemp];
        
        self.currentTemp=currentTemp;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureCell
{
  //  NSLog(@"name %@",[content objectForKey:@"name"]);
 //   NSString * cell=NSStringFromClass(self.class);
  //  NSLog(@"%@",cell);
    
    NSDictionary * data=[[CLWeatherAPI sharedWeather] getCurrentWeather:@"tomsk"];
    
    self.currentTemp.text=[data objectForKey:kCurrentTemp];
    
}

@end
