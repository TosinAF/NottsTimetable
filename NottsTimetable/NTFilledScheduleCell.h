//
//  NTFilledScheduleCell.h
//  NottsTimetable
//
//  Created by Tosin Afolabi on 23/09/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTFilledScheduleCell : UITableViewCell

- (void)setCellWithClass:(NSString *)className ofType:(NSString *)type atLocation:(NSString *)location andTime:(NSString *)time withLecturer:(NSString *)lecturer;

@end
