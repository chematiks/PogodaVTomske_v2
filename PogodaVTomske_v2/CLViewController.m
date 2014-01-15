//
//  CLViewController.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 01.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLViewController.h"
#import "CLMainViewCell.h"

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"mainCellIdent";
    CLMainViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        NSArray * nib=[[NSBundle mainBundle] loadNibNamed:@"CLMainViewCell" owner:nil options:nil];
        
        for (id currentObject in nib) {
            cell=(CLMainViewCell *)currentObject;
            break;
        }
    }
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380.0f;
}


@end
