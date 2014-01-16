//
//  CLMainViewCell.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 03.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLMainViewCell.h"

@implementation CLMainViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        UIView * baseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        
        
        UILabel * cityLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 50)];
        cityLabel.textAlignment=NSTextAlignmentCenter;
        cityLabel.font=[cityLabel.font fontWithSize:30];
        
        
        
        baseView.backgroundColor=[UIColor greenColor];
        [baseView addSubview:cityLabel];
        self.mainView=baseView;
        [self.contentView addSubview:baseView];
        
        self.cityLabel=cityLabel;
        
        
        //CGSize size=CGSizeMake(320, 250);
       // NSLog(@"%f",self.bounds.size.height);
        
    }
    self.contentView.backgroundColor=[UIColor yellowColor];

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(float)getHeigth
{
    return 199.0f;
}


@end

