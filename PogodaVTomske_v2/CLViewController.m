//
//  CLViewController.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 01.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLViewController.h"
#import "UITableViewCell+getHeightCell.h"
#import "CLMainViewCell.h"
#import "CLCurrentWeatherCell.h"
#import "CLDetailsCell.h"
#import "CLForecastCell.h"
#import "CLMapCell.h"
#import "CLSunAndMoonCell.h"
#import "CLWindAndPressureCell.h"
#import "constants.h"
#import "keys.h"
#import "CLWeatherAPI.h"


@interface CLViewController ()
{
    NSMutableArray * cellIdArray;
    UIRefreshControl * pullToRefresh;
}
@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    cellIdArray=[[NSMutableArray alloc] initWithObjects:
                 @"CLMainViewCell",
                 @"CLCurrentWeatherCell",
                 @"CLForecastCell",
                 @"CLDetailsCell",
                 @"CLMapCell",
                 @"CLSunAndMoonCell",
                 @"CLWindAndPressureCell", nil];
    
    
    pullToRefresh=[[UIRefreshControl alloc] init];
    
    pullToRefresh.tintColor=[UIColor blueColor];
    UIFont * font=[UIFont fontWithName:@"HelveticaNeue-Light" size:13];

    UILabel * pullToRefreshTitle=[[UILabel alloc] initWithFrame:CGRectMake(175, -60, 300, 100)];
    pullToRefreshTitle.font=font;
    pullToRefreshTitle.textColor=[UIColor blueColor];
    pullToRefreshTitle.text=@"Потяни чтобы обновить!";
    [self.tableViewMain addSubview:pullToRefreshTitle];
    
    [pullToRefresh addTarget:self action:@selector(beginRefreshing) forControlEvents:UIControlEventValueChanged];
    
    [self.tableViewMain addSubview:pullToRefresh];
    
    [self.tableViewMain setDecelerationRate:UIScrollViewDecelerationRateFast];
    
    NSString * deviceType = [[UIDevice currentDevice] model];
    if ([deviceType isEqualToString:@"iPad"]
        || [deviceType isEqualToString:@"iPad Simulator"]) {
        NSDictionary * weather = [[CLWeatherAPI sharedWeather] getCurrentWeather:@"tomsk"];
        
        [self configurateIpad:weather];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) beginRefreshing
{
    NSLog(@"UPDATE");
    [pullToRefresh endRefreshing];

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

#pragma mark - 
#pragma mark UItableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellIdArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
   	NSString * cellId = [cellIdArray objectAtIndex:indexPath.row];
   
    Class theClass=[self cellClassForCellId:cellId];
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        cell=[[theClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //NSDictionary * cellData=[[NSDictionary alloc] initWithObjectsAndKeys:@"cell",@"name", nil];
    
    [cell configureCell];
   
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[[UITableViewCell alloc] init];
    return [cell getHeigthCell:cellIdArray[indexPath.row]];
}

-(Class)cellClassForCellId:(NSString *)cellId
{
    return NSClassFromString(cellId);
}

#pragma mark -
#pragma mark - Hand Dragging Table View

-(void)scrollViewDidEndDragging:(UITableView *)tableView willDecelerate:(BOOL)decelerate
{
    [self handDraggingTableView:tableView];
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView
{
    [self handDraggingTableView:tableView];
}

-(void) handDraggingTableView:(UITableView *) tableView
{
    float targetY=tableView.contentOffset.y;
    if (targetY <hCLMainViewCell+hCLCurrentWeatherCell){
        if (targetY <= hCLForecastCell/2) {
            [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else
            if (targetY > hCLForecastCell/2) {
                [tableView setContentOffset:CGPointMake(0, hCLMainViewCell) animated:YES];
            }else
                if (targetY <= hCLMainViewCell/2) {
                    [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                }else
                    if (targetY > hCLMainViewCell/2) {
                        [tableView setContentOffset:CGPointMake(0, hCLMainViewCell) animated:YES];
                    }
    }
}

@end
