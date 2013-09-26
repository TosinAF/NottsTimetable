//
//  NTEmptyScheduleCell.m
//  NottsTimetable
//
//  Created by Tosin Afolabi on 21/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "NTEmptyScheduleCell.h"
#import "UIColor+FlatUIColors.h"

@implementation NTEmptyScheduleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        CGSize size = self.frame.size;
        [self setBackgroundColor:[UIColor wetAsphaltColor]];

        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, size.height)];
        [self.timeLabel setBackgroundColor:[UIColor midnightBlueColor]];
        [self.timeLabel setTextColor:[UIColor cloudsColor]];
        [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.timeLabel setFont:[UIFont fontWithName:@"Signika-Light" size:14]];

        [self.contentView addSubview:self.timeLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
