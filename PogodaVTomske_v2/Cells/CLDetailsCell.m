//
//  CLDetailsCell.m
//  PogodaVTomske_v2
//
//  Created by chematiks on 03.01.14.
//  Copyright (c) 2014 chematiks. All rights reserved.
//

#import "CLDetailsCell.h"

@implementation CLDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.contentView.backgroundColor=[UIColor yellowColor];
        
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
   // NSLog(@"name %@",[content objectForKey:@"name"]);
  //  NSString * cell=NSStringFromClass(self.class);
  //  NSLog(@"%@",cell);
}

@end
