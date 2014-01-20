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
       
        UILabel * cityLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 20, 220, 40)];
        cityLabel.textAlignment=NSTextAlignmentCenter;
        cityLabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:(30)];
      //  cityLabel.backgroundColor=[UIColor blueColor];
        cityLabel.text=@"Томск";
        cityLabel.textColor=[UIColor whiteColor];
        [self.contentView addSubview:cityLabel];
        
        self.contentView.backgroundColor=[UIColor greenColor];
        self.cityLabel=cityLabel;
    
        
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

