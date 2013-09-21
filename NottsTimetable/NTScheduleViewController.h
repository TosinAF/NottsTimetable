//
//  NTScheduleViewController.h
//  NottsTimetable
//
//  Created by Tosin Afolabi on 20/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTScheduleViewController : UITableViewController

typedef NS_ENUM(NSInteger, NTScheduleViewDay) {
    NTScheduleViewDayMonday,
    NTScheduleViewDayTuesday,
    NTScheduleViewDayWednesday,
    NTScheduleViewDayThursday,
    NTScheduleViewDayFriday
};

- (id)initWithStyle:(UITableViewStyle)style forDay:(NTScheduleViewDay)day;

@end
