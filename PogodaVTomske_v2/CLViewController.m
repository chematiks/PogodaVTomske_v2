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

#import "CLIpadTableViewController.h"


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
    
  /*  NSString * deviceType = [[UIDevice currentDevice] model];
    if ([deviceType isEqualToString:@"iPad"]
        || [deviceType isEqualToString:@"iPad Simulator"]) {
        NSDictionary * weather = [[CLWeatherAPI sharedWeather] getCurrentWeather:@"tomsk"];
        
    }
    */
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
