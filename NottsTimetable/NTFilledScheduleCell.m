//
//  NTFilledScheduleCell.m
//  NottsTimetable
//
//  Created by Tosin Afolabi on 23/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "NTFilledScheduleCell.h"
#import "UIColor+FlatUIColors.h"

@implementation NTFilledScheduleCell

- (void)setCellWithClass:(NSString *)className ofType:(NSString *)type atLocation:(NSString *)location andTime:(NSString *)time withLecturer:(NSString *)lecturer
{
    CGSize contentViewSize = self.frame.size;
    [self.contentView setBackgroundColor:[UIColor wetAsphaltColor]];

    /* Time Label */

    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, contentViewSize.height)];
    [timeLabel setText:[NSString stringWithFormat:@"%@:00", time]];
    [timeLabel setBackgroundColor:[UIColor midnightBlueColor]];
    [timeLabel setTextColor:[UIColor cloudsColor]];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setFont:[UIFont fontWithName:@"Signika-Light" size:14]];

    /* Class Label */

    UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [classLabel setText:className];
    [classLabel setTextColor:[UIColor cloudsColor]];
    [classLabel setFont:[UIFont fontWithName:@"Signika-Light" size:28]];

    CGSize expectedSize = [className sizeWithAttributes:@{NSFontAttributeName:classLabel.font}];
    [classLabel setFrame:CGRectMake(55, contentViewSize.height - 40, expectedSize.width, expectedSize.height)];
    [classLabel setTextColor:[UIColor cloudsColor]];

    /* Class Logistics */

    UILabel *classLogisticsLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, contentViewSize.width, 22)];
    [classLogisticsLabel setTextColor:[UIColor grayColor]];
    
    NSMutableAttributedString *classLogisticsString = [[NSMutableAttributedString alloc] init];

    NSDictionary *locationSymbolDict = @{NSFontAttributeName:[UIFont fontWithName:@"Entypo" size:21]};
    NSAttributedString *locationSymbol = [[NSAttributedString alloc] initWithString:@"\ue724" attributes:locationSymbolDict];

    NSDictionary *locationDict = @{NSFontAttributeName:[UIFont fontWithName:@"Signika-Light" size:13]};
    NSAttributedString *locationText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@  |  ", location] attributes:locationDict];

    NSDictionary *lecturerDict = @{NSFontAttributeName:[UIFont fontWithName:@"Signika-Light" size:13]};
    NSAttributedString *lecturerText = [[NSAttributedString alloc] initWithString:lecturer attributes:lecturerDict];

    [classLogisticsString appendAttributedString:locationSymbol];
    [classLogisticsString appendAttributedString:locationText];
    [classLogisticsString appendAttributedString:lecturerText];
    [classLogisticsLabel setAttributedText:classLogisticsString];

    /* Class Type */

    UILabel *classTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentViewSize.width - 50, contentViewSize.height - 20, 40, 12)];
    [classTypeLabel setText:type];
    [classTypeLabel setTextColor:[UIColor cloudsColor]];
    [classTypeLabel setFont:[UIFont fontWithName:@"Signika-Light" size:10]];
    [classTypeLabel setTextAlignment:NSTextAlignmentCenter];
    [classTypeLabel setBackgroundColor:[UIColor pumpkinColor]];
    [classTypeLabel.layer setCornerRadius:3];

    [self.contentView addSubview:timeLabel];
    [self.contentView addSubview:classLabel];
    [self.contentView addSubview:classLogisticsLabel];
    [self.contentView addSubview:classTypeLabel];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
