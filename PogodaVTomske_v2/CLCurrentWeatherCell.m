//
//  CLCurrentWeatherCell.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 11.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLCurrentWeatherCell.h"

@implementation CLCurrentWeatherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor=[UIColor redColor];
        
        UILabel * currentTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 200, 80)];
        currentTempLabel.textAlignment=NSTextAlignmentLeft;
        currentTempLabel.font=[currentTempLabel.font fontWithSize:80];
        currentTempLabel.backgroundColor=[UIColor blueColor];
        currentTempLabel.text=@"-00.0";
        
        [self.contentView addSubview:currentTempLabel];
        
        
        
        
        
        
        
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
 //   NSString * cell=NSStringFromClass(self.class);
  //  NSLog(@"%@",cell);
}

@end
