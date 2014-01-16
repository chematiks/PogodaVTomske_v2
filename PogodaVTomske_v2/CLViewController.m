//
//  CLViewController.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 01.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLViewController.h"
#import "CLMainViewCell.h"
#import "CLCurrentWeatherCell.h"

@interface CLViewController ()

@end

@implementation CLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UItableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
   	 if (indexPath.row == 0) {
        static NSString * cellId = @"mainCellIdent";
        CLMainViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
         
        if (cell == nil) {
            NSArray * nib=[[NSBundle mainBundle] loadNibNamed:@"CLMainViewCell" owner:nil options:nil];
            
            for (id currentObject in nib) {
                //cell=(CLMainViewCell *)currentObject;
                
               // UITableViewCell * cell=[self getClassCell];
                //cell=[cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell=[[CLMainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                NSLog(@"%f",cell.mainView.bounds.size.height);
                break;
            }
        }
        
        cell.cityLabel.text=@"Tomsk";
        return cell;
    }else{
        static NSString * cellId = @"currentWeatherCellId";
        CLCurrentWeatherCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) {
            NSArray * nib=[[NSBundle mainBundle] loadNibNamed:@"CLCurrentWeatherCell" owner:nil options:nil];
            
            for (id currentObject in nib) {
                cell=(CLCurrentWeatherCell *)currentObject;
                break;
            }
        }
        return cell;
    }
    
    
   
    
    return NULL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // CLMainViewCell.
    CLMainViewCell * cell=[[CLMainViewCell alloc] init];
    float heigth=[cell getHeigth];
    NSLog(@"hei  %f",heigth);
    if (indexPath.row < 2)
        return 250;
    return 100.0f;
}

-(Class)cellClassForItem:(id)rowItem
{
    Class theClass = [ UITableViewCell class ] ;
    
    if ( [ rowItem isKindOfClass:[ CLMainViewCell class ] ] )
    {
        theClass = [ CLMainViewCell class ] ;
    }
    else if ( [ rowItem isKindOfClass:[ CLCurrentWeatherCell class ] ] )
    {
        theClass = [ CLCurrentWeatherCell class ] ;
    }
    
    return theClass ;
}

-(Class) getClassCell
{
    return [CLMainViewCell class];
}


@end
