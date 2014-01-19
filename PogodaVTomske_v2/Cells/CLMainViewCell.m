//
//  CLMainViewCell.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 03.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLMainViewCell.h"
#import "constants.h"

@implementation CLMainViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        UIView * baseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, hCLMainViewCell)];
        
        
        UILabel * cityLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, hCLMainViewCell, 50)];
        cityLabel.textAlignment=NSTextAlignmentCenter;
        cityLabel.font=[cityLabel.font fontWithSize:30];
        
        
        
        baseView.backgroundColor=[UIColor greenColor];
        [baseView addSubview:cityLabel];
        self.mainView=baseView;
        [self.contentView addSubview:baseView];
        
        self.cityLabel=cityLabel;
        //[[UIScreen mainScreen] bounds].size.height
    
        
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void) configureCell:(NSDictionary *) content
{
  //  NSLog(@"name %@",[content objectForKey:@"name"]);
  //  NSString * cell=NSStringFromClass(self.class);
  //  NSLog(@"%@",cell);
}


@end

